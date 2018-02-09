//
//  ChangeSecondViewModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface ChangeSecondViewModel : BaseViewModel
@property (nonatomic,strong) RACSubject *codeClickSubject;
@property (nonatomic,strong) RACCommand *commitCommand;
@property (nonatomic,copy) NSString *codeStr;
@property (nonatomic,strong) NSString *phoneNumber;
@property (nonatomic,strong) RACSignal *commitBtnEnable;
@property (nonatomic,strong) RACSignal *codeLabelEnable;
@end
