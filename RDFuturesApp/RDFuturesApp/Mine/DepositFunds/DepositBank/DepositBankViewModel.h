//
//  DepositBankViewModel.h
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface DepositBankViewModel : BaseViewModel
@property(nonatomic,strong)RACSubject *nextStepClickSubject;

@property(nonatomic,strong)RACCommand *sumbitDepositBankCommand;

@end
