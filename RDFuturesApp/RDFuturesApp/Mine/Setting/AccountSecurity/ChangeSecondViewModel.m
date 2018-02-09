//
//  ChangeSecondViewModel.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ChangeSecondViewModel.h"

@implementation ChangeSecondViewModel

-(RACSignal *)commitSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error ;
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            [param setObject:_phoneNumber forKey:@"newPhone"];
            [param setObject:_codeStr forKey:@"validate_code"];
            RDRequestModel * model = [RDRequest setWithApi:@"/api/user/newPhoneValidation.api" andParam:param error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
//                hiddenHUD;
                if (error == nil) {
                    if ([model.State isEqualToString:@"1"]) {
                        [subscriber sendNext:@"1"];
                    }
                    showMassage(model.Message);
                }else{
                    [MBProgressHUD showError:promptString];
                }
                [subscriber sendNext:@"2"];
                [subscriber sendCompleted];
            });
            
        });
        return nil;
    }];
}

-(instancetype)init {
    if (self = [super init]) {
        RACSignal * codeStrLengthSig = [RACObserve(self, codeStr) map:^id(NSString * value) {
            if (value.length >=5) {
                return @(YES);
            }
            return @(NO);
        }];
        
        RACSignal * phoneNumStrLengthSig = [RACObserve(self, phoneNumber) map:^id(NSString * value) {
            if (value.length == 11) {
                return @(YES);
            }
            return @(NO);
        }];
        
        _commitBtnEnable = [RACSignal combineLatest:@[codeStrLengthSig,phoneNumStrLengthSig] reduce:^id{
            return @([_codeStr boolValue] && [_phoneNumber boolValue]);
        }];
        
        
        _commitCommand = [[RACCommand alloc]initWithEnabled:_commitBtnEnable signalBlock:^RACSignal *(id input) {
            return [self commitSignal];
        }];
        
    }
    return self;
}


-(RACSubject *)codeClickSubject {
    if (!_codeClickSubject) {
        _codeClickSubject = [RACSubject subject];
    }
    return _codeClickSubject;
}
@end
