//
//  ChangeViewModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/4.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface ChangeViewModel : BaseViewModel

@property (nonatomic,copy) NSString *codeStr;
@property (nonatomic,copy) NSString *passwordStr;
@property (nonatomic,strong) NSString *phoneNumber;
@property (nonatomic,strong) RACSignal *commitBtnEnable;
@property (nonatomic,strong) RACCommand *commitCommand;
@property (nonatomic,strong) RACSubject *btnClick;
@end
