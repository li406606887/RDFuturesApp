//
//  WithdrawFundsViewModel.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "WithdrawFundsViewModel.h"
#import "AutographModel.h"

@implementation WithdrawFundsViewModel
-(void)initialize{
    WS(weakself)
    [self.sumbitWithdrawFundsCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        [weakSelf.nextStepClickSubject sendNext:x];

    }];


}
-(RACSubject *)nextStepClickSubject{
    if (!_nextStepClickSubject) {
        
        _nextStepClickSubject = [RACSubject subject];
    }
    return _nextStepClickSubject;
}
-(RACCommand *)sumbitWithdrawFundsCommand{
    if (!_sumbitWithdrawFundsCommand) {
        _sumbitWithdrawFundsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                loading(@"");
                NSMutableDictionary *paramData = (NSMutableDictionary*)input;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    RDRequestModel * model = [RDRequest postExtractingMoneyWithParam:paramData
                                                                              error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error==nil) {
                            if ([model.State isEqualToString:@"1"]) {
                                NSDictionary *dictionary = model.Data;
                                AutographModel *autographModel = [AutographModel mj_objectWithKeyValues:dictionary];
                                [subscriber sendNext:autographModel];
                            }else{
                                showMassage(model.Message)
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                        }
                        [subscriber sendCompleted];
                    });
                });
                
                
                
                return nil;
            }];
            
        }];
        
    }
    return _sumbitWithdrawFundsCommand;
}
//-(void)setDataDictionary:(NSMutableDictionary *)dataDictionary{
//    _dataDictionary = dataDictionary;
//}
@end
