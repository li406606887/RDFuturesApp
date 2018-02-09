//
//  RDRequest+Home.m
//  RDFuturesApp
//
//  Created by user on 17/3/20.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest+Home.h"
#import "ZMBAddressItem.h"

@implementation RDRequest (Home)

+(RDRequestModel *)postBaidu{
    
    [[RDRequest request] POST:@"https://www.baidu.com"
                   parameters:nil
                      success:^(RDRequest *request, id response) {
                          
                      }
                      failure:^(RDRequest *request, NSError *error) {
                          
                      }];

    return nil;
}

//获取首页广告轮播图
+(RDRequestModel *)postAdvListWithParam:(NSDictionary*)data_dic
                                      error:(NSError* __autoreleasing*)error{
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/home/getAdvList.api",HostUrlBak];
    __block NSError *blockError = nil;
    __block RDRequestModel *model;
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                          [dic setObject:[response objectForKey:@"Code"] forKey:@"Code"];
                          [dic setObject:[response objectForKey:@"Message"] forKey:@"Message"];
                          [dic setObject:[response objectForKey:@"State"] forKey:@"State"];
                          NSMutableArray *array = [response objectForKey:@"Data"];
                          NSMutableArray *modelArray =[[NSMutableArray alloc] init];
                          for (NSDictionary *dic in array) {
                              HomeScrollModel *model = [HomeScrollModel mj_objectWithKeyValues:dic];
                              [modelArray addObject:model];
                          }
                          
                          [dic setObject:modelArray forKey:@"Data"];
                          model = [RDRequestModel mj_objectWithKeyValues:dic];
                      }
                      failure:^(RDRequest *request, NSError *error) {
                          blockError = error;
                          
                      }];
    
    if (blockError!=nil) {
        *error = blockError;
    }
    return model;
}
//首页公告
+(RDRequestModel *)postHomeNoticeListWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/home/getNoticeList.api",HostUrlBak];
    
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

//检查是否收藏
+(RDRequestModel *)postCheckCollectWithParam:(NSDictionary*)data_dic
                                    error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/user/checkCollect.api",HostUrlBak];
    
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


//提交收藏
+(RDRequestModel *)postMyCollectWithParam:(NSDictionary*)data_dic
                                    error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/user/setMyCollect.api",HostUrlBak];
    
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

#pragma mark ----- 获取省市区

+(NSArray * )postRegionsListWithWithParam:(NSDictionary*)param Error:(NSError* __autoreleasing*)error andMessage:(NSString *)message{
    

    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/sys/getRegionsList.api",HostUrlBak];
    
    __block NSArray *shengArr = nil;
    __block NSString *blockMessage=nil;
    __block NSError *blockError = nil;
    
    [[RDRequest request] POST:hostUrl parameters:param success:^(RDRequest *request, id response) {
        
        blockMessage = [NSString stringWithFormat:@"%@",[response objectForKey:@"Message"]];
        
        NSArray * array = [NSArray arrayWithArray:[response objectForKey:@"Data"]];
        
        NSMutableArray * modelArr = [NSMutableArray array];
        for (NSDictionary * dict in array)
        {
            
            ZMBAddressItem * shengItem = [ZMBAddressItem mj_objectWithKeyValues:dict];
            [modelArr addObject:shengItem];
        }
        shengArr = modelArr;
        
    } failure:^(RDRequest *request, NSError *error) {
        blockError = error;
    }];
    
    if (blockMessage!=nil) {
        message = blockMessage;
    }
    if (blockError!=nil) {
        *error = blockError;
    }
    return shengArr;

}
#pragma mark -----提交见证城市信息

+(NSArray * )postWitnessCityWithParam:(NSDictionary*)param Error:(NSError* __autoreleasing*)error andMessage:(NSString *)message{
    
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setWitnessCityInfo.api",HostUrlBak];
    
    __block NSArray *returnArr = nil;
    __block NSString *blockMessage=nil;
    __block NSError *blockError = nil;
    
    [[RDRequest request] POST:hostUrl parameters:param success:^(RDRequest *request, id response) {
        
        blockMessage = [NSString stringWithFormat:@"%@",[response objectForKey:@"Message"]];
        
        returnArr = [NSArray arrayWithArray:[response objectForKey:@""]];
        
    } failure:^(RDRequest *request, NSError *error) {
        blockError = error;
    }];
    
    if (blockMessage!=nil) {
        message = blockMessage;
    }
    if (blockError!=nil) {
        *error = blockError;
    }
    return returnArr;
    
}
//瑞达通知信息
+(RDRequestModel *)postInfomListWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/getInfomList.api",HostUrlBak];
    
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

//检查是否有未读通知
+(RDRequestModel *)postCheckNewInformWithParam:(NSDictionary*)data_dic
                                    error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/user/checkNewInform.api",HostUrlBak];
    
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
//检查是否有未读通知
+(RDRequestModel *)postCheckNewCompanyNoticeWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/user/checkNewCompanyNotice.api",HostUrlBak];
    
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
//首页广告加载
+(RDRequestModel *)postOpenAdvListWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/home/getOpenAdvList.api",HostUrlBak];
    
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
//提交api服务申请详情
+(RDRequestModel *)postApplySignatureWithParam:(NSDictionary*)data_dic
                                           error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/apply/setApply.api",HostUrlBak];
    
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


@end
