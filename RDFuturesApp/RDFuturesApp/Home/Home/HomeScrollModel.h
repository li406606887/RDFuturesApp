//
//  HomeScrollModel.h
//  RDFuturesApp
//
//  Created by user on 17/3/22.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeScrollModel : NSObject
@property(nonatomic,copy)NSString *adv_id;//广告ID
@property(nonatomic,copy)NSString *image;//广告图片
@property(nonatomic,copy)NSString *name;//广告名称
@property(nonatomic,copy)NSString *skip_type;//跳转方式（1：内部 2：外部链接）
@property(nonatomic,copy)NSString *skip_url;//外部链接
@property(nonatomic,copy)NSString *within_sign;//内部跳转标识
@end
