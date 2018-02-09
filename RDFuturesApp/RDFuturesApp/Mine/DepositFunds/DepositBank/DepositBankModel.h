//
//  DepositBankModel.h
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepositBankModel : NSObject
@property(nonatomic,copy)NSString *bankIndex;//银行标识
@property(nonatomic,copy)NSString *inBankNum;//银行号码
@property(nonatomic,copy)NSString *accountAccessId;//订单号
@end
