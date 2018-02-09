//
//  RDRequest+Login_register.h
//  RDFuturesApp
//
//  Created by user on 17/3/22.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest.h"

@interface RDRequest (Login_register)
//登录
+(RDRequestModel *)postLoginWithParam:(NSDictionary*)data_dic
                              error:(NSError* __autoreleasing*)error;

//注册
+(RDRequestModel *)postRegisterWithParam:(NSDictionary*)data_dic
                                   error:(NSError* __autoreleasing*)error ;
//找回密码
+(RDRequestModel *)postFindPasswordWithParam:(NSDictionary*)data_dic
                             error:(NSError* __autoreleasing*)error ;
//发送验证码
+(RDRequestModel *)postSendValidateCodeWithParam:(NSDictionary*)data_dic
                             error:(NSError* __autoreleasing*)error ;
//验证验证码
+(RDRequestModel *)postCheckValidateCodeWithParam:(NSDictionary*)data_dic
                                            error:(NSError* __autoreleasing*)error;
@end
