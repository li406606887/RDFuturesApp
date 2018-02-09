//
//  RDRequest+Login_register.m
//  RDFuturesApp
//
//  Created by user on 17/3/22.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest+Login_register.h"

@implementation RDRequest (Login_register)
//登录
+(RDRequestModel *)postLoginWithParam:(NSDictionary*)data_dic
                                error:(NSError* __autoreleasing*)error{
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/user/login.api",HostUrlBak];

    __block RDRequestModel *model=nil;
    __block NSError *blockError = nil;
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          model = [RDRequestModel mj_objectWithKeyValues: response];
                      }
                      failure:^(RDRequest *request, NSError *error) {
                          
                          blockError = error;
                          
                      }];
    
    if (blockError!=nil) {
        *error = blockError;
    }
    return model;
}

//注册
+(RDRequestModel *)postRegisterWithParam:(NSDictionary*)data_dic
                                   error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/user/register.api",HostUrlBak];

    __block RDRequestModel *model=nil;
    __block NSError *blockError = nil;
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          
                          
                          model = [RDRequestModel mj_objectWithKeyValues: response];
                      }
                      failure:^(RDRequest *request, NSError *error) {
                          blockError = error;
                          
                      }];
    
    if (blockError!=nil) {
        *error = blockError;
    }
    return model;
}

//找回密码
+(RDRequestModel *)postFindPasswordWithParam:(NSDictionary*)data_dic
                                       error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/user/fandPassword.api",HostUrlBak];
    //    [MBProgressHUD showMessage:@"" toView:self];
    __block RDRequestModel * model;
    __block NSError *blockError = nil;
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          
                          model = [RDRequestModel mj_objectWithKeyValues: response];

                      }
                      failure:^(RDRequest *request, NSError *error) {
                          blockError = error;
                          
                      }];
    
    if (blockError!=nil) {
        *error = blockError;
    }
    return model;
}

//发送验证码
+(RDRequestModel *)postSendValidateCodeWithParam:(NSDictionary*)data_dic
                                     error:(NSError* __autoreleasing*)error{

    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/user/sendValidateCode.api",HostUrlBak];
    __block RDRequestModel * model;
    __block NSError *blockError = nil;

    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          
                          model = [RDRequestModel mj_objectWithKeyValues: response];
                      }
                      failure:^(RDRequest *request, NSError *error) {
                          blockError = error;
                          
                      }];
   
    if (blockError!=nil) {
        *error = blockError;
    }
    return model;
}
//验证验证码
+(RDRequestModel *)postCheckValidateCodeWithParam:(NSDictionary*)data_dic
                                           error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/user/checkCode.api",HostUrlBak];
    __block RDRequestModel * model;
    __block NSError *blockError = nil;
    
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          
                          model = [RDRequestModel mj_objectWithKeyValues: response];
                      }
                      failure:^(RDRequest *request, NSError *error) {
                          blockError = error;
                          
                      }];
    
    if (blockError!=nil) {
        *error = blockError;
    }
    return model;
}



@end
