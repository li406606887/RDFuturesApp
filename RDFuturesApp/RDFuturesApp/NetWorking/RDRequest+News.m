//
//  RDRequest+News.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest+News.h"

@implementation RDRequest (News)

+(void)postNewsWithApi:(NSString *)apiStr andParam:(NSDictionary *)data_dic
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

#pragma mark -----服务器获取数据
+(RDRequestModel *)getNewsListWithApi:(NSString *)apiStr andParam:(NSDictionary*)data_dic
                                error:(NSError* __autoreleasing*)error{
    
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@%@",HostUrlBak,apiStr];
    __block RDRequestModel *model=nil;
    __block NSError *blockError = nil;
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          
                          model = [RDRequestModel mj_objectWithKeyValues:response];
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
