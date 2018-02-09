//
//  AppDelegate.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//


#import "AppDelegate.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

#define jpuchKey @"c9de28cd2cbf3c33f33e4bec"

#import "NotificationModel.h"
#import "AdvertisementViewController.h"
#import "NavigationBaseController.h"
#import "ZLGestureLockViewController.h"

@interface AppDelegate ()<JPUSHRegisterDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)NotificationModel *notificationModel;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
     NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:jpuchKey
                          channel:@"App Store"
                 apsForProduction:false
            advertisingIdentifier:advertisingId];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
        [defult setObject:registrationID forKey:@"registrationID"];
    }];
    application.applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
    // 创建窗口
    AdvertisementViewController *advertisement = [[AdvertisementViewController alloc] init];
    advertisement.blockMainViewController = ^{
        self.window.rootViewController = self.root;

    };
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = advertisement;
    // 显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}

// NS_DEPRECATED_IOS(3_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得Extras字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,(long)badge,sound,customizeField1);
    
    // iOS 10 以下 Required
    [JPUSHService handleRemoteNotification:userInfo];
}

//iOS 7 Remote Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:  (NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"this is iOS7 Remote Notification");
    
    // iOS 10 以下 Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark- JPUSHRegisterDelegate // 2.1.9版新增JPUSHRegisterDelegate,需实现以下两个方法

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center  willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSDictionary *dic = [userInfo objectForKey:@"aps"];
        NSString *string = [dic objectForKey:@"alert"];
        NSString *dataString = [userInfo objectForKey:@"iosNotification extras key"];
        self.notificationModel = [self stringChangeWithStringDictionary:dataString];
        if ([self.notificationModel.msg_type intValue]!=2) {
            [self alertControlerWithContentText:string];
        }
        
    }
    else {
        // 本地通知
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler: (void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSDictionary *dic = [userInfo objectForKey:@"aps"];
        NSString *string = [dic objectForKey:@"alert"];
        NSString *dataString = [userInfo objectForKey:@"iosNotification extras key"];
        self.notificationModel = [self stringChangeWithStringDictionary:dataString];
        if ([self.notificationModel.msg_type intValue]!=2 ) {
            [self alertControlerWithContentText:string];
        }
    }
    else {
        // 本地通知
        NSLog(@"本地通知");
    }
    completionHandler();  // 系统要求执行这个方法
}
/*
 *推送注册设备token
 **/
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
/*
 *注册设备token失败调取
 **/
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [RDUserInformation getInformation].leaveTime = [[NSDate date] dateWithYMD];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if ([NSDate isAfterFiveMinute:[RDUserInformation getInformation].leaveTime]) {
        if ([[RDUserInformation getInformation].gesturesStatus intValue]==1) {
            int index = (int)self.root.selectedIndex;
            ZLGestureLockViewController *viewController = [[ZLGestureLockViewController alloc] initWithUnlockType:ZLUnlockTypeValidatePsw];
            NavigationBaseController *base = [[NavigationBaseController alloc] initWithRootViewController:viewController];
            [self.root.viewControllers[index] presentViewController:base animated:YES completion:nil];
        }
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
//    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField = [extras valueForKey:@"message extras key"]; //服务端传递的Extras附加字段，key是自己定义的
    NSData *jsonData = [customizeField dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                       
                                                                      options:NSJSONReadingMutableContainers
                                       
                                                                        error:&err];
    NSString *msg_type =[NSString stringWithFormat:@"%@",dictionary[@"msg_type"]];
    if ([msg_type intValue]==2) {
        [self outLogin];
    }
    [JPUSHService setBadge:0];
}
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (self.isForceLandscape) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)networkDidLogin:(NSNotification *)notification {
    
    
    if ([JPUSHService registrationID]) {
        NSLog(@"get RegistrationID:%@",[JPUSHService registrationID]);//获取registrationID
    }
}
-(NotificationModel *)stringChangeWithStringDictionary:(NSString*)string{
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                
                                                               options:NSJSONReadingMutableContainers
                                
                                                                 error:&err];
    NotificationModel *model = [NotificationModel mj_objectWithKeyValues:dictionary];
    return model;
}
-(void)alertControlerWithContentText:(NSString*)message{
    WS(weakself)
    PromptView *prompt = [[PromptView alloc] initWithTitleString:@"提示" SubTitleString:message];
    
    [prompt show];
    prompt.goonBlock = ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationCenter" object:weakSelf.notificationModel];
        
    };
    
}

-(void)outLogin{
    
   PromptView *prompt = [[PromptView alloc] initWithTitleString:@"提示" SubTitleString:[NSString stringWithFormat:@"您好：您的账户刚刚在一台新设备上登录，如果是您本人操作请忽略此通知，如非您本人操作，建议您登录您的账号并及时修改密码。"]];
    
    
    [prompt show];
    
    [[RDUserInformation getInformation] cleanUserInfo];
    [self.root outLogin];
    
}
-(TabBarBaseController *)root{
    if (!_root) {
        _root = [[TabBarBaseController alloc] init];
    }
    return _root;
}
-(BOOL)isForceLandscape{
    if (!_isForceLandscape) {
        _isForceLandscape = NO;
    }
    return _isForceLandscape;
}
@end
