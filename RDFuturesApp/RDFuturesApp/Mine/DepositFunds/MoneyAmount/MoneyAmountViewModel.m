

//
//  MoneyAmountViewModel.m
//  RDFuturesApp
//
//  Created by user on 17/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MoneyAmountViewModel.h"

@implementation MoneyAmountViewModel

-(void)initialize{
WS(weakself)
    [self.sumbitMoneyAmountCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       
        [weakSelf.nextStepClickSubject sendNext:[NSString stringWithFormat:@"%@",x]];
        
    }];
}
-(RACSubject *)nextStepClickSubject{
    if (!_nextStepClickSubject) {
        
        _nextStepClickSubject = [RACSubject subject];
    }
    return _nextStepClickSubject;
}

-(RACSubject *)textFiledEditEnd{
    if (!_textFiledEditEnd) {
        
        _textFiledEditEnd = [RACSubject subject];

    }
    return _textFiledEditEnd;
}
-(RACCommand *)sumbitMoneyAmountCommand{
    if (!_sumbitMoneyAmountCommand) {
        _sumbitMoneyAmountCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
           return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               loading(@"");
               NSMutableDictionary *paramData = (NSMutableDictionary*)input;
               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   NSError *error;
                   RDRequestModel * model = [RDRequest postDepositMoneyWithParam:paramData error:&error];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       hiddenHUD;
                       if (error==nil) {
                           if ([model.State isEqualToString:@"1"]) {
                               NSDictionary *dataDictionary = model.Data;
                               NSString *accountAccessId = [NSString stringWithFormat:@"%@",[dataDictionary objectForKey:@"accountAccessId"]];
                               [subscriber sendNext:accountAccessId];
                           }else{
                               showMassage(model.Message);
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
    return _sumbitMoneyAmountCommand;
}
@end
