//
//  RDRequest+Home.h
//  RDFuturesApp
//
//  Created by user on 17/3/20.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest.h"
#import "RDRequestModel.h"
#import "HomeModel.h"
#import "HomeScrollModel.h"

@interface RDRequest (Home)

//获取首页广告轮播图
+(RDRequestModel *)postAdvListWithParam:(NSDictionary*)data_dic
                                      error:(NSError* __autoreleasing*)error;
//首页公告
+(RDRequestModel *)postHomeNoticeListWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error;
//获取瑞达通知列表
+(RDRequestModel *)postInfomListWithParam:(NSDictionary*)data_dic
                                     error:(NSError* __autoreleasing*)error;
//检查是否有未读通知
+(RDRequestModel *)postCheckNewInformWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error;
//获取省市区
+(NSArray * )postRegionsListWithWithParam:(NSDictionary*)param Error:(NSError* __autoreleasing*)error andMessage:(NSString *)message;
//提交城市信息
+(NSArray * )postWitnessCityWithParam:(NSDictionary*)param Error:(NSError* __autoreleasing*)error andMessage:(NSString *)message;
//提交收藏
+(RDRequestModel *)postMyCollectWithParam:(NSDictionary*)data_dic
                                    error:(NSError* __autoreleasing*)error;
//检查是否收藏
+(RDRequestModel *)postCheckCollectWithParam:(NSDictionary*)data_dic
                                       error:(NSError* __autoreleasing*)error;
//首页广告加载
+(RDRequestModel *)postOpenAdvListWithParam:(NSDictionary*)data_dic
                                      error:(NSError* __autoreleasing*)error;
//提交api服务申请详情
+(RDRequestModel *)postApplySignatureWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error;
//检查是否有未读公告
+(RDRequestModel *)postCheckNewCompanyNoticeWithParam:(NSDictionary*)data_dic
                                                error:(NSError* __autoreleasing*)error;
@end
