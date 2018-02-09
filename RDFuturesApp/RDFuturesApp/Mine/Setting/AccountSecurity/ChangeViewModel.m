//
//  ChangeViewModel.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/4.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ChangeViewModel.h"

@implementation ChangeViewModel


-(RACSignal *)commitSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        loading(@"")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error ;
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            [param setObject:_passwordStr forKey:@"password"];
            [param setObject:_codeStr forKey:@"validate_code"];
            
            RDRequestModel * model = [RDRequest setWithApi:@"/api/user/changePhone.api" andParam:param error:&error];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                hiddenHUD;
                if (error==nil) {
                    if ([model.State isEqualToString:@"1"]) {
                        [subscriber sendNext:@1];
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
    
}


-(instancetype)init {
    if (self = [super init]) {
        
        RACSignal * codeStrLengthSig = [RACObserve(self, codeStr) map:^id(NSString * value) {
            if (value.length >=5) {
                return @(YES);
            }
            return @(NO);
        }];
        
        RACSignal * passwordStrLengthSig = [RACObserve(self, passwordStr) map:^id(NSString * value) {
            if (value.length>=6) {
                return @(YES);
            }
            return @(NO);
        }];
        
        _commitBtnEnable = [RACSignal combineLatest:@[codeStrLengthSig,passwordStrLengthSig] reduce:^id{
            
            return @([_codeStr boolValue] && [_passwordStr boolValue]);
        }];
        
        _commitCommand = [[RACCommand alloc]initWithEnabled:_commitBtnEnable signalBlock:^RACSignal *(id input) {
            
            return [self commitSignal];
        }];
    }
    return self;
}


-(RACSubject *)btnClick{

    if (!_btnClick) {
        _btnClick = [RACSubject subject];
    }
    return _btnClick;
}
@end
