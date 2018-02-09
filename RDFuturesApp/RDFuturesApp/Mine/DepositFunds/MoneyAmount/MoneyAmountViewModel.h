//
//  MoneyAmountViewModel.h
//  RDFuturesApp
//
//  Created by user on 17/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface MoneyAmountViewModel : BaseViewModel
@property(nonatomic,strong)RACSubject *nextStepClickSubject;
@property(nonatomic,strong)RACCommand *sumbitMoneyAmountCommand;//提交数据信息
@property(nonatomic,strong)RACSubject *textFiledEditEnd;

@end
