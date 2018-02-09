


//
//  NoticeCollectionViewModel.m
//  RDFuturesApp
//
//  Created by user on 2017/5/19.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeCollectionViewModel.h"

@implementation NoticeCollectionViewModel

-(void)initialize{
    
    [self.reloadClollectionStyleCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [self.refreshUI sendNext:[NSString stringWithFormat:@"%@",x]];
    }];
    [self.collectionClickCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [self.refreshStyle sendNext:nil];
    }];
}
-(RACSubject *)refreshUI{
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
-(RACSubject *)refreshStyle{
    if (!_refreshStyle) {
        _refreshStyle = [RACSubject subject];
    }
    return _refreshStyle;
}
-(RACCommand *)collectionClickCommand{
    if (!_collectionClickCommand) {
        _collectionClickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                loading(@"");
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:input forKey:@"noticeId"];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    RDRequestModel * model = [RDRequest postMyCollectWithParam:dic error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error==nil) {
                            if ([model.State isEqualToString:@"1"]) {
                                [subscriber sendNext:nil];
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
    return _collectionClickCommand;
}
-(RACCommand *)reloadClollectionStyleCommand{
    if (!_reloadClollectionStyleCommand) {
        _reloadClollectionStyleCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                loading(@"");
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:input forKey:@"noticeId"];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    
                    RDRequestModel * model = [RDRequest postCheckCollectWithParam:dic error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error==nil) {
                            if ([model.State isEqualToString:@"1"]) {
                                
                                [subscriber sendNext:model.Data[@"isCollect"]];
                            }else{
                                
                                showMassage(model.Message)
                            }
                        }else{
                            showMassage(promptString)
                        }
                        [subscriber sendCompleted];
                        
                    });
                });
                
                
                
                return nil;
            }];
            
        }];
        
    }
    return _reloadClollectionStyleCommand;
}
@end
