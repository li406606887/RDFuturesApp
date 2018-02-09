//
//  ZLGestureLockViewController.m
//  GestureLockDemo
//
//  Created by ZL on 2017/4/5.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ZLGestureLockViewController.h"
#import "ZLGestureLockView.h"
#import "ZLGestureLockIndicator.h"

#define GesturesPassword @"gesturesPwd"

@interface ZLGestureLockViewController () <ZLGestureLockDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) ZLGestureLockView *gestureLockView;
// 手势状态栏提示label
@property (weak, nonatomic) UILabel *statusLabel;

// 账户名
@property (weak, nonatomic) UILabel *nameLabel;
// 账户头像
@property (weak, nonatomic) UIImageView *headIcon;

// 其他账户登录按钮
@property (weak, nonatomic) UIButton *otherAcountBtn;
// 重新绘制按钮
@property (weak, nonatomic) UIButton *resetPswBtn;
// 忘记手势密码按钮
@property (weak, nonatomic) UIButton *forgetPswBtn;

// 创建的手势密码
@property (nonatomic, copy) NSString *lastGesturePsw;
//api
@property (nonatomic, copy) NSString *api;

@property (nonatomic) ZLUnlockType unlockType;

@end

@implementation ZLGestureLockViewController

#pragma mark - 类方法

+ (void)deleteGesturesPassword {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:GesturesPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)addGesturesPassword:(NSString *)gesturesPassword {
    [[NSUserDefaults standardUserDefaults] setObject:gesturesPassword forKey:GesturesPassword];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"gesturesStatus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)gesturesPassword {
    return [[NSUserDefaults standardUserDefaults] objectForKey:GesturesPassword];
}

#pragma mark - inint

- (instancetype)initWithUnlockType:(ZLUnlockType)unlockType {
    if (self = [super init]) {
        _unlockType = unlockType;
        if (_unlockType == ZLUnlockTypeModifyPsw) {
            self.api = @"/api/user/setGesturesPwd.api";
        }else if (_unlockType == ZLUnlockTypeCreatePsw || _unlockType == ZLUnlockTypeClosePsw) {
            self.api = @"/api/user/switchGesturesStatus.api";
        }
    }
    return self;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupMainUI];
    
    self.gestureLockView.delegate = self;
    
    self.resetPswBtn.hidden = YES;
    switch (_unlockType) {
        case ZLUnlockTypeCreatePsw:
        {
            self.otherAcountBtn.hidden = self.forgetPswBtn.hidden = self.nameLabel.hidden = self.headIcon.hidden = YES;
        }
            break;
        case ZLUnlockTypeValidatePsw: {
            self.otherAcountBtn.hidden = self.forgetPswBtn.hidden = self.nameLabel.hidden = self.headIcon.hidden = NO;
        }
        case ZLUnlockTypeClosePsw: {
            self.otherAcountBtn.hidden = self.forgetPswBtn.hidden = self.nameLabel.hidden = self.headIcon.hidden = NO;
        }
        case ZLUnlockTypeModifyPsw: {
            self.otherAcountBtn.hidden = self.forgetPswBtn.hidden = self.nameLabel.hidden = self.headIcon.hidden = NO;
        }
            break;
        default:
            break;
    }
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.unlockType == ZLUnlockTypeValidatePsw) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}
// 创建界面
- (void)setupMainUI {
    
    CGFloat maginX = 15;
    CGFloat magin = 5;
    CGFloat btnW = ([UIScreen mainScreen].bounds.size.width - maginX * 2 - magin * 2) / 3;
    CGFloat btnH = 30;
    
//    // 账户头像
//    UIImageView *headIcon = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 56) * 0.5, 30, 56, 56)];
//    headIcon.image = [UIImage imageNamed:@"gesture_headIcon"];
//    [self.view addSubview:headIcon];
    
    // 账户名
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 100) * 0.5, 50, 100, 20)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"绘制解锁图案";
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = RGB(102, 102, 102);
    [self.view addSubview:nameLabel];
    self.statusLabel = nameLabel;
    
    // 手势状态栏提示label
    UILabel *statusLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 200) * 0.5, 100, 200, 30)];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.text = @"请绘制手势密码";
    statusLabel.font = [UIFont systemFontOfSize:14];
    statusLabel.textColor = [UIColor redColor];
    [self.view addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    // 九宫格 手势密码页面
    ZLGestureLockView *gestureLockView = [[ZLGestureLockView alloc]initWithFrame:CGRectMake(0, getTop(statusLabel)+10, self.view.frame.size.width, self.view.frame.size.width)];
    gestureLockView.delegate = self;
    [self.view addSubview:gestureLockView];
    self.gestureLockView = gestureLockView;
    
    // 重新绘制按钮
    UIButton *resetPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetPswBtn.frame = CGRectMake(maginX, getTop(gestureLockView)+10, btnW, btnH);
    resetPswBtn.backgroundColor = [UIColor clearColor];
    [resetPswBtn setTitle:@"重新绘制" forState:UIControlStateNormal];
    resetPswBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [resetPswBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [resetPswBtn addTarget:self action:@selector(resetGesturePassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetPswBtn];
    self.resetPswBtn = resetPswBtn;
    
    // 忘记手势密码按钮
    UIButton *forgetPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPswBtn.frame = CGRectMake(SCREEN_WIDTH-btnW-20, getTop(gestureLockView)+10, btnW, btnH);
    forgetPswBtn.backgroundColor = resetPswBtn.backgroundColor;
    [forgetPswBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPswBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetPswBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [forgetPswBtn addTarget:self action:@selector(forgetGesturesPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPswBtn];
    self.forgetPswBtn = forgetPswBtn;
}

#pragma mark - private

//  创建手势密码
- (void)createGesturesPassword:(NSMutableString *)gesturesPassword {
    if (self.lastGesturePsw.length == 0) {
        if (gesturesPassword.length < 4) {
            self.statusLabel.text = @"至少连接四个点，请重新输入";
            [self shakeAnimationForView:self.statusLabel];
            return;
        }
        
        if (self.resetPswBtn.hidden == YES) {
            self.resetPswBtn.hidden = NO;
        }
        
        self.lastGesturePsw = gesturesPassword;
        self.statusLabel.text = @"请再次绘制手势密码";
        return;
    }
    
    if ([self.lastGesturePsw isEqualToString:gesturesPassword]) { // 绘制成功
        [self postRequest:gesturesPassword type:1];
    }else {
        self.statusLabel.text = @"与上一次绘制不一致，请重新绘制";
        [self shakeAnimationForView:self.statusLabel];
    }
}
// 验证手势密码
- (void)validateGesturesPassword:(NSMutableString *)gesturesPassword {
    if ([gesturesPassword isEqualToString:[ZLGestureLockViewController gesturesPassword]]) {
        if (self.unlockType ==ZLUnlockTypeValidatePsw) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else if (self.unlockType == ZLUnlockTypeModifyPsw) {
            self.unlockType = ZLUnlockTypeCreatePsw;
            self.statusLabel.text = @"请绘制新密码";
            self.forgetPswBtn.hidden = YES;
        }else if (self.unlockType == ZLUnlockTypeClosePsw){
            [self postRequest:gesturesPassword type:2];
        }
    } else {
        
//        if (errorCount - 1 == 0) { // 你已经输错五次了！ 退出重新登陆！
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"手势密码已失效" message:@"请重新登陆" delegate:self cancelButtonTitle:nil otherButtonTitles:@"重新登陆", nil];
//            [alertView show];
//            return;
//        }
        self.statusLabel.text = [NSString stringWithFormat:@"密码错误"];
        [self shakeAnimationForView:self.statusLabel];
    }
}

// 抖动动画
- (void)shakeAnimationForView:(UIView *)view {
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES]; // 平滑结束
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    
    [viewLayer addAnimation:animation forKey:nil];
}

#pragma mark - 按钮点击事件 Anction
// 点击其他账号登陆按钮
- (void)otherAccountLogin:(id)sender {
    NSLog(@"%s",__FUNCTION__);
}

// 点击重新绘制按钮
- (void)resetGesturePassword:(id)sender {
    self.lastGesturePsw = nil;
    self.statusLabel.text = @"请绘制手势密码";
    self.resetPswBtn.hidden = YES;
}

// 点击忘记手势密码按钮
- (void)forgetGesturesPassword:(id)sender {
    loading(@"");

    self.api = @"/api/user/forgetGesturesPwd.api";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        RDRequestModel *model = [RDRequest postWithParam:nil
                                                     api:self.api
                                                   error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error == nil) {
                [[RDUserInformation getInformation] cleanUserInfo];
                if (self.unlockType == ZLUnlockTypeValidatePsw) {
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }else {
                showMassage(model.Message);
            }
        });
    });
    
}


#pragma mark - ZLgestureLockViewDelegate
- (void)gestureLockView:(ZLGestureLockView *)lockView drawRectFinished:(NSMutableString *)gesturePassword {
    if (self.unlockType == ZLUnlockTypeCreatePsw) {
        [self createGesturesPassword:gesturePassword];
    }else{
        [self validateGesturesPassword:gesturePassword];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // 重新登陆
    NSLog(@"重新登陆");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)postRequest:(NSString *)passWord type:(int)type{
    loading(@"");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setObject:passWord forKey:@"gesturesPwd"];
        RDRequestModel *model = [RDRequest postWithParam:param
                                                     api:self.api
                                                   error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error == nil) {
                if (type ==1) {
                    [ZLGestureLockViewController addGesturesPassword:passWord];
                }else{
                    [RDUserInformation closeGestures];
                }
                [self.navigationController popToViewController:self.navigationController.childViewControllers[self.navigationController.childViewControllers.count-3] animated:YES];
            }else {
                showMassage(model.Message);
            }
        });
    });
}
@end
