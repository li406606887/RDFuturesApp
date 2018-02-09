



//
//  RDNoticeViewModel.m
//  RDFuturesApp
//
//  Created by user on 2017/5/12.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDNoticeViewModel.h"
#import "RDNoticeModel.h"
#import "JPUSHService.h"

@implementation RDNoticeViewModel

-(void)initialize{
    WS(weakself)
    [self.reloadDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if (self.dateArray.count<1) {
            NSArray *array = (NSArray *)x;
            for (NSDictionary *dic  in array) {
                RDNoticeModel *model = [RDNoticeModel mj_objectWithKeyValues:dic];
                if ([model.sign isEqualToString:@"1"]) {
                    model.content = [model.content stringByAppendingString:@"^点此可查看开户进度。"];
                }
                [self.dateArray addObject:model];
            }
        }else{
        }
        [weakSelf.refreshUI sendNext:nil];

    }];
    
}

-(RACCommand *)reloadDataCommand{
    if (!_reloadDataCommand) {
        _reloadDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                loading(@"");
                self.page++;
                NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
                [dataDictionary setValue:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    RDRequestModel * model = [RDRequest postInfomListWithParam:dataDictionary error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error ==nil) {
                            if ([model.State isEqualToString:@"1"]) {
                                [JPUSHService setBadge:0];
                                [subscriber sendNext:model.Data];
                            }else{
                                self.page--;
                            }
                        }else{
                            self.page--;

                            [MBProgressHUD showError:promptString];
                        }
                       
                        
                        [subscriber sendCompleted];

                    });
                    
                    
                    
                });
                return nil;
            }];
            
        }];
        
    }
    return _reloadDataCommand;
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


-(int)page{
    if (!_page) {
        _page = 0;
    }
    return _page;
}
-(NSMutableArray *)dateArray{
    if (!_dateArray) {
        _dateArray = [[NSMutableArray alloc] init];
    }
    return _dateArray;
}
@end
