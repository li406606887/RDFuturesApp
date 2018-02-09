//
//  MAChooseModel.h
//  RDFuturesApp
//
//  Created by user on 2017/5/16.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAChooseModel : NSObject
@property(nonatomic,copy)NSString *currency;//币种
@property(nonatomic,copy)NSString *depositWays;//存入方式
@property(nonatomic,copy)NSString *holdBankType;//持有银行类型（1: 香港银行， 2:大陆银行  3:境外银行
@property(nonatomic,copy)NSString *holdBank;//选择的银行
@property(nonatomic,copy)NSString *holdCardNum;//银行卡号
@property(nonatomic,copy)NSString *depositAmount;//存入金额
@property(nonatomic,copy)NSString *depositAmountCapital;//提取金额
@end
