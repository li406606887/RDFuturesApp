//
//  NotificationModel.h
//  RDFuturesApp
//
//  Created by user on 2017/5/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationModel : NSObject
@property(nonatomic,copy)NSString *skip_type;//1内列 2外列
@property(nonatomic,copy)NSString *out_url;//外列连接
@property(nonatomic,copy)NSString *inward_id;//内列跳转方式 1是消息  3是账单
@property(nonatomic,copy)NSString *msg_type;//消息类型 2是新设备登录

@end
