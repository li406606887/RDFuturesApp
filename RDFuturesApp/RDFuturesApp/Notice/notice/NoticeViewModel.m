//
//  NoticeViewModel.m
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeViewModel.h"

@interface NoticeViewModel()

@property (nonatomic, assign) int currentPage;//页数

@end

@implementation NoticeViewModel
-(void)initialize{
    WS(weakself)
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (int i = 0 ; i<array.count; i++) {
            [data addObject:array[array.count-i-1]];
        }
       
        self.dataArray = data;
        
        
        [weakSelf.refreshUI sendNext:nil];
        [weakSelf.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        
        if (array) {
            NSMutableArray *data = [[NSMutableArray alloc] initWithArray:self.dataArray];
            for (int i=0; i<array.count; i++){
                [ data insertObject:array[i] atIndex:0];
            }
            self.dataArray = data;
            [weakSelf.refreshUI sendNext:nil];
            [weakSelf.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        }else{
            [weakSelf.refreshUI sendNext:nil];
            [weakSelf.refreshEndSubject sendNext:@(FooterRefresh_HasNoMoreData)];

        }
        
        
    }];
    
    
}

-(RACCommand *)refreshDataCommand{
    
    if (!_refreshDataCommand) {
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
                    [paramDic setObject:@"1" forKey:@"page_no"];
                    RDRequestModel * model = [RDRequest postHomeNoticeListWithParam:paramDic
                                                                              error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State isEqualToString:@"1"]) {
                                
                                [subscriber sendNext:model.Data];
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
    return _refreshDataCommand;
}

-(RACCommand *)nextPageCommand{
   
    WS(weakself)
    if (!_nextPageCommand) {
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                weakSelf.currentPage++;
                NSString *pageValue = [NSString stringWithFormat:@"%d",weakSelf.currentPage];
                NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
                [paramDic setObject:pageValue forKey:@"page_no"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    
                    RDRequestModel * model = [RDRequest postHomeNoticeListWithParam:paramDic
                                                                              error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State isEqualToString:@"1"]) {
                                [subscriber sendNext:model.Data];
                            }else{
                                weakSelf.currentPage--;
                                [subscriber sendNext:nil];
                                showMassage(model.Message)
                            }
                        }else{
                            weakSelf.currentPage--;
                            [subscriber sendNext:nil];  
                            [MBProgressHUD showError:promptString];
                        }
                        [subscriber sendCompleted];
                        
                    });
                });
                
                
                
                return nil;
            }];
            
        }];
        
    }
    return _nextPageCommand;
}
-(RACSubject *)refreshEndSubject{
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}


-(RACSubject *)refreshUI{
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}

-(RACSubject *)cellClickSubject{
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

-(int)currentPage{
    if (!_currentPage) {
        _currentPage = 1;
    }
    return _currentPage;
}
@end
