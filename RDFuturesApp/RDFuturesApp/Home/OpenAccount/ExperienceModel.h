//
//  ExperienceModel.h
//  RDFuturesApp
//
//  Created by user on 17/3/30.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExperienceModel : NSObject
@property(nonatomic,copy) NSString *shares_id;
@property(nonatomic,copy) NSString *trading_id;
@property(nonatomic,copy) NSString *bear_card_id;
@property(nonatomic,copy) NSString *derivative_id;
@property(nonatomic,copy) NSString *futures_id;
@property(nonatomic,copy) NSString *options_id;
@property(nonatomic,copy) NSString *precious_metal_id;
@property(nonatomic,copy) NSString *investment_other_id;




/*
 1、shares_id						股票时间id
 2、trading_id					杠杆式外汇交易时间id
 3、bear_card_id					牛熊证时间id
 4、derivative_id					衍生权证时间id
 5、futures_id					期货时间id
 6、options_id					期权时间id
 7、precious_metal_id				贵金属时间id
 8、investment_other_id			其他时间id
 */
@end
