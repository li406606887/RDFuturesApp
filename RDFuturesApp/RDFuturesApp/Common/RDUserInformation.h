//
//  RDUserInformation.h
//  RDFuturesApp
//
//  Created by user on 17/3/24.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDUserInformation : NSObject
+(RDUserInformation*)getInformation;

@property(nonatomic,copy)NSString *messageState;//消息状态
@property(nonatomic,copy)NSString *gesturesStatus;//手势状态 0是关闭 1是开启
@property(nonatomic,copy)NSString *gesturesPwd;//手势密码
@property(nonatomic,strong)NSDate *leaveTime;//手势密码
@property(nonatomic,assign)BOOL advertisementClick;

-(BOOL)getLoginState;//获取登录状态
-(void)cleanUserInfo;//本地清除信息退出登录
+(void)closeGestures;//关闭手势密码
-(void)PostUserInformationDataWithUserId:(NSString *)userid andtoken:(NSString*)token andPhoneNumber:(NSString *)phoneNumber;

-(NSMutableDictionary *)postDataDictionary:(BOOL)state;
+(NSString *)transString:(NSString *)string;
+(NSString *)transBase64WithImage:(UIImage *)image;
@end

