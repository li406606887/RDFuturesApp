//
//  WithdrawFundsViewModel.h
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface WithdrawFundsViewModel : BaseViewModel
@property(nonatomic,strong)RACSubject *nextStepClickSubject;//下一步
@property(nonatomic,strong)RACCommand *sumbitWithdrawFundsCommand;//提交提取资金
//@property(nonatomic,strong)NSMutableDictionary* dataDictionary;//数据
@end
