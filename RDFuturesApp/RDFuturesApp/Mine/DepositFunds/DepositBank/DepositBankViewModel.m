


//
//  DepositBankViewModel.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "DepositBankViewModel.h"
#import "AutographModel.h"

@implementation DepositBankViewModel


-(void)initialize{
    WS(weakself)
    [self.sumbitDepositBankCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        [weakSelf.nextStepClickSubject sendNext:x];
    }];
}

-(RACSubject *)nextStepClickSubject{
    if (!_nextStepClickSubject) {
        _nextStepClickSubject = [RACSubject subject];
        
    }
    return _nextStepClickSubject;
}
-(RACCommand *)sumbitDepositBankCommand{
    
    if (!_sumbitDepositBankCommand) {
        WS(weakself)
        _sumbitDepositBankCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                loading(@"");
                NSMutableDictionary *paramData = (NSMutableDictionary*)input;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    RDRequestModel * model = [RDRequest postDepositAccountWithParam:paramData
                                                                              error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error!=nil) {
                            [MBProgressHUD showError:promptString];
                        }else{
                            if ([model.State isEqualToString:@"1"]) {
                                NSDictionary *dataDictionary = model.Data;
                                AutographModel *model = [AutographModel mj_objectWithKeyValues:dataDictionary];
                                [weakSelf.nextStepClickSubject sendNext:model];
                            }else{
                                showMassage(model.Message)
                            }
                        }
                        [subscriber sendCompleted];
                        
                    });
                });
                
                
                
                return nil;
            }];
            
        }];
        
    }
    return _sumbitDepositBankCommand;
}
@end
