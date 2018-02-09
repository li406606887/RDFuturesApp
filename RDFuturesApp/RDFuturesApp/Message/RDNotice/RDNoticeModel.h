//
//  RDNoticeModel.h
//  RDFuturesApp
//
//  Created by user on 2017/5/12.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDNoticeModel : NSObject
@property(nonatomic,copy)NSString *createTime;//通知时间
@property(nonatomic,copy)NSString *content;//通知内容
@property(nonatomic,copy)NSString *image;//图标
@property(nonatomic,copy)NSString *sign;//标识 1开户流程
@property(nonatomic,copy)NSString *title;//标题

@end
