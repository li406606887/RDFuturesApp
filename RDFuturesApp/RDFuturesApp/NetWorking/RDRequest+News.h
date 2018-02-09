//
//  RDRequest+News.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest.h"

@interface RDRequest (News)

+(void)postNewsWithApi:(NSString *)apiStr andParam:(NSDictionary *)data_dic
               success:(void (^)(RDRequestModel *model))success
               failure:(void (^)(NSError * error))failure;

+(RDRequestModel *)getNewsListWithApi:(NSString *)apiStr andParam:(NSDictionary*)data_dic
                        error:(NSError* __autoreleasing*)error;
@end
