//
//  RDRequest+Account.m
//  RDFuturesApp
//
//  Created by user on 17/3/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest+Account.h"

@implementation RDRequest (Account)
//其他信息披露
+(RDRequestModel *)postOtherDataInfoWithParam:(NSDictionary*)data_dic
                                        error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setOtherDataInfo.api",HostUrlBak];
    
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
//提交账户选择信息
+(RDRequestModel *)postAccountChooseInfoWithParam:(NSDictionary*)data_dic
                                            error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setAccountChooseInfo.api",HostUrlBak];
    
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
//获取账户选择信息
+(RDRequestModel *)getAccountChooseInfoWithParam:(NSDictionary*)data_dic
                                            error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/getAccountChooseInfo.api",HostUrlBak];
    
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
//提交投资经验信息
+(RDRequestModel *)postInvestmentExperienceInfoWithParam:(NSDictionary*)data_dic
                                            error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setInvestmentExperienceInfo.api",HostUrlBak];
    
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
//获取投资经验信息
+(RDRequestModel *)getInvestmentExperienceInfoWithParam:(NSDictionary*)data_dic
                                                   error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/getInvestmentExperienceInfo.api",HostUrlBak];
    
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
//提交拍照确认信息
+(RDRequestModel *)postPhotoConfirmInfoWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error{
    
    
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setPhotoConfirmInfo.api",HostUrlBak];
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
//获取拍照确认信息
+(RDRequestModel *)getPhotoConfirmInfoWithParam:(NSDictionary*)data_dic
                                           error:(NSError* __autoreleasing*)error{
    
    
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/getPhotoConfirmInfo.api",HostUrlBak];
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

#pragma mark -----提交图片到服务器
+(RDRequestModel *)UploadImageWithApi:(NSString *)apiStr andParam:(NSDictionary*)data_dic
                        error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@%@",HostUrlBak,apiStr];
    __block RDRequestModel *model=nil;
    __block NSError *blockError = nil;

    [[RDRequest request] POSTUploadImageWithURLString:hostUrl
                                           parameters:data_dic
                                              success:^(RDRequest *request, id response) {
                                                  model = [RDRequestModel mj_objectWithKeyValues:response];
                        } failure:^(RDRequest *request, NSError *error) {
                            blockError = error;
                        }];
    
    
    if (blockError!=nil) {
        *error = blockError;
    }
    
    return model;
    
}

#pragma mark -----提交到服务器
+(RDRequestModel *)setWithApi:(NSString *)apiStr andParam:(NSDictionary*)data_dic
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

#pragma mark -----服务器获取数据
+(RDRequestModel *)getWithApi:(NSString *)apiStr andParam:(NSDictionary*)data_dic
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

//进度查询
+(RDRequestModel *)postSpeedInfoWithParam:(NSDictionary*)data_dic
                                                   error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/getSpeedInfo.api",HostUrlBak];
    
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
