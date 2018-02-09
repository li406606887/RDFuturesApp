//
//  RDRequest+Mine.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest.h"

@interface RDRequest (Mine)


+(void)postMineWithApi:(NSString *)apiStr andParam:(NSDictionary *)data_dic
               success:(void (^)(RDRequestModel *model))success
               failure:(void (^)(NSError * error))failure;

+(RDRequestModel *)postDepositMoneyWithParam:(NSDictionary*)data_dic
                                       error:(NSError* __autoreleasing*)error;

+(RDRequestModel *)postExtractingMoneyWithParam:(NSDictionary*)data_dic
                                          error:(NSError* __autoreleasing*)error;
//存取款签名图片
+(RDRequestModel *)postDepositSignatureWithParam:(NSDictionary*)data_dic
                                           error:(NSError* __autoreleasing*)error;
//存入瑞达银行账号信息
+(RDRequestModel *)postDepositAccountWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error;
//api
+(RDRequestModel *)postWithParam:(NSDictionary*)data_dic api:(NSString *)api error:(NSError* __autoreleasing*)error;
@end
