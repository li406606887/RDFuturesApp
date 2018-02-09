//
//  RDUserInformation.m
//  RDFuturesApp
//
//  Created by user on 17/3/24.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDUserInformation.h"

@implementation RDUserInformation

+(RDUserInformation*)getInformation{
    static RDUserInformation *userInfor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userInfor = [[RDUserInformation alloc] init];

    });
    
    return userInfor;
}
//转utf8格式
+ (NSString *)transString:(NSString *)string{

    //1
//    NSString *utf_8_tureName =  [string  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //2
//    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    
//    return str;
    
    return string;
}
//转bsae64方法
+ (NSString *)transBase64WithImage:(UIImage *)image{

    NSData* imgData = UIImageJPEGRepresentation(image, 0.1f);
    
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *string = [NSString stringWithFormat:@"data:image/png;base64,%@",encodedImageStr];
    
    return string;
}

-(void)PostUserInformationDataWithUserId:(NSString *)userid andtoken:(NSString*)token andPhoneNumber:(NSString *)phoneNumber {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userid forKey:@"user_id"];
    [defaults setObject:token forKey:@"token"];
    [defaults setObject:phoneNumber forKey:@"phoneNumber"];
}
//
-(NSMutableDictionary *)getUserInformationData{
    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [infoDictionary setObject:[defaults objectForKey:@"user_id"] forKey:@"user_id"];
    [infoDictionary setObject:[defaults objectForKey:@"token"] forKey:@"token"];
    
    
    return infoDictionary;
}
-(NSMutableDictionary *)postDataDictionary:(BOOL)state{
    NSMutableDictionary *dic;
    if (state == YES) {
        dic = [self getUserInformationData];

    }
    NSMutableDictionary *infoDictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    NSString *version_no = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [infoDictionary setObject:version_no forKey:@"version_no"];
    
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [infoDictionary setObject:app_Version forKey:@"version"];
    
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [infoDictionary setObject:uuid forKey:@"uuid"];
    [infoDictionary setObject:@"2" forKey:@"platform"];
    
    
    return infoDictionary;
}
-(BOOL)getLoginState{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [userDefaults objectForKey:@"user_id"];
    NSString *token = [userDefaults objectForKey:@"token"];
    if (user_id.length<1||token.length<1) {
        return NO;
    }
    return YES;
}
-(BOOL)advertisementClick{
    if (!_advertisementClick) {
        _advertisementClick = NO;
    }
    return _advertisementClick;
}

-(void)cleanUserInfo{
    NSString * str  = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString * str1  = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString * str2  = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    if (str.length > 0 && str1.length >0 && str2.length > 0) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phoneNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [RDUserInformation closeGestures];
}

+(void)closeGestures {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"gesturesPwd"];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"gesturesStatus"];
}

-(NSString *)gesturesPwd {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"gesturesPwd"];
}

-(NSString *)gesturesStatus {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"gesturesStatus"];
}
@end
