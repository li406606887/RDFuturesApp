//
//  RDRequest+Account.h
//  RDFuturesApp
//
//  Created by user on 17/3/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest.h"

@interface RDRequest (Account)

+(RDRequestModel *)postOtherDataInfoWithParam:(NSDictionary*)data_dic
                                        error:(NSError* __autoreleasing*)error;
//提交账户选择
+(RDRequestModel *)postAccountChooseInfoWithParam:(NSDictionary*)data_dic
                                  error:(NSError* __autoreleasing*)error;
//获取账户选择
+(RDRequestModel *)getAccountChooseInfoWithParam:(NSDictionary*)data_dic
                                           error:(NSError* __autoreleasing*)error;
//提交投资经验信息
+(RDRequestModel *)postInvestmentExperienceInfoWithParam:(NSDictionary*)data_dic
                                                   error:(NSError* __autoreleasing*)error;
//获取投资经验信息
+(RDRequestModel *)getInvestmentExperienceInfoWithParam:(NSDictionary*)data_dic
                                                  error:(NSError* __autoreleasing*)error;
//提交拍照确认信息
+(RDRequestModel *)postPhotoConfirmInfoWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error;
//获取拍照确认信息
+(RDRequestModel *)getPhotoConfirmInfoWithParam:(NSDictionary*)data_dic
                                          error:(NSError* __autoreleasing*)error;
//进度查询
+(RDRequestModel *)postSpeedInfoWithParam:(NSDictionary*)data_dic
                                    error:(NSError* __autoreleasing*)error;

//上传开户图片
+(RDRequestModel *)UploadImageWithApi:(NSString *)apiStr andParam:(NSDictionary*)data_dic
                                error:(NSError* __autoreleasing*)error;
#pragma mark -----提交到服务器
+(RDRequestModel *)setWithApi:(NSString *)apiStr andParam:(NSDictionary*)data_dic
                        error:(NSError* __autoreleasing*)error;
#pragma mark -----服务器获取数据
+(RDRequestModel *)getWithApi:(NSString *)apiStr andParam:(NSDictionary*)data_dic
                        error:(NSError* __autoreleasing*)error;
@end
