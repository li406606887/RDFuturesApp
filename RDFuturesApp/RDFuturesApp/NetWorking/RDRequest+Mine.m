//
//  RDRequest+Mine.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest+Mine.h"

@implementation RDRequest (Mine)
//提取资金
+(RDRequestModel *)postExtractingMoneyWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setExtractingMoney.api",HostUrlBak];
    
    __block RDRequestModel *model;
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
//存入瑞达银行账号信息
+(RDRequestModel *)postDepositAccountWithParam:(NSDictionary*)data_dic
                                          error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setDepositAccount.api",HostUrlBak];
    
    __block RDRequestModel *model;
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
//存入资金信息
+(RDRequestModel *)postDepositMoneyWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setDepositMoney.api",HostUrlBak];
    
    __block RDRequestModel *model;
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
//存取款签名图片
+(RDRequestModel *)postDepositSignatureWithParam:(NSDictionary*)data_dic
                                       error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setDepositSignature.api",HostUrlBak];
    
    __block RDRequestModel *model;
    __block NSError *blockError = nil;
    [[RDRequest request] POSTUploadImageWithURLString:hostUrl
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
+(void)postMineWithApi:(NSString *)apiStr andParam:(NSDictionary *)data_dic
               success:(void (^)(RDRequestModel *model))success
               failure:(void (^)(NSError * error))failure{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@%@",HostUrlBak,apiStr];
    __block RDRequestModel *model=nil;
    __block NSError *blockError = nil;
    
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          
                          
                          model = [RDRequestModel mj_objectWithKeyValues:response];
                          success(model);
                      }
                      failure:^(RDRequest *request, NSError *error) {
                          blockError = error;
                          failure(error);
                      }];
    
}

+(RDRequestModel *)postWithParam:(NSDictionary*)data_dic api:(NSString *)api error:(NSError* __autoreleasing*)error {
    NSString *hostUrl = [NSString stringWithFormat:@"%@%@",HostUrlBak,api];
    
    __block RDRequestModel *model;
    __block NSError *blockError = nil;
    [[RDRequest request] POSTUploadImageWithURLString:hostUrl
                                           parameters:data_dic
                                              success:^(RDRequest *request, id response) {
                                                  model = [RDRequestModel mj_objectWithKeyValues: response];
                                                  if ([model.State intValue]!=1) {
                                                      blockError = [[NSError alloc] init];
                                                  }
                                              }
                                              failure:^(RDRequest *request, NSError *error) {
                                                  blockError = error;
                                                  model = [[RDRequestModel alloc] init];
                                                  model.Message = @"网路错误";
                                              }];
    
    if (blockError!=nil) {
        *error = blockError;
    }
    return model;
}
@end
