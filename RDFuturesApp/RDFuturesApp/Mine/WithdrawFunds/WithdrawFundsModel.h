//
//  WithdrawFundsModel.h
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawFundsModel : NSObject
@property(nonatomic,copy)NSString *currency;//币种标识
@property(nonatomic,copy)NSString *extractingAmount;//提取金额
@property(nonatomic,copy)NSString *holdBankType;//银行类型
@property(nonatomic,copy)NSString *receiveBank;//收款银行
@property(nonatomic,copy)NSString *receiver;//收款人
@property(nonatomic,copy)NSString *receiveCardNum;//银行账号
@property(nonatomic,copy)NSString *bankAddress;//银行地址
@property(nonatomic,copy)NSString *interRemittanceCode;//国际汇款编码
@property(nonatomic,copy)NSString *extractingAmountCapital;//提款金额(大写）
@end
