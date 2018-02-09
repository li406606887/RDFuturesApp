//
//  AdvertisementModel.h
//  RDFuturesApp
//
//  Created by user on 2017/5/24.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertisementModel : NSObject
@property(nonatomic,copy)NSString *skip_type;//跳转方式（1：内部 2：外部链接）
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *adv_id;
@property(nonatomic,copy)NSString *skip_url;
@end
