//
//  FinanceInfoModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinanceInfoModel : NSObject
@property(copy,nonatomic) NSString * year_income_id;
@property(copy,nonatomic) NSString * total_assets_id;
@property(copy,nonatomic) NSString * investment_purpose_id;
@property(copy,nonatomic) NSString * housing_ownership_id;
@property(copy,nonatomic) NSString * property_valuation;

//1、year_income_id					全年收入id
//2、total_assets_id					总资产净值id
//3、investment_purpose_id				投资目标id
//4、housing_ownership_id				住宅所有权id
//5、property_valuation				物业估值

@end
