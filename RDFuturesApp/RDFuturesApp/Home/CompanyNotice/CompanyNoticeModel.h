//
//  CompanyNoticeModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/14.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyNoticeModel : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *digest;
@property (nonatomic,strong) NSString *content_url;
@property (nonatomic,strong) NSString *create_time;

//1、title                			公司公告标题
//2、digest						公司公告摘要
//3、content_url					公司公告详情路径
//4、create_time					发布时间
@end
