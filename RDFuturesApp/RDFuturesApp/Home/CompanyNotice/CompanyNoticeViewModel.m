//
//  CompanyNoticeViewModel.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "CompanyNoticeViewModel.h"
#import "CompanyNoticeModel.h"
@implementation CompanyNoticeViewModel

-(void)initialize{

    WS(weakself)
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray * array) {
        
        if (weakSelf.dataArray.count != 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        
        for (NSDictionary *dic in array) {
            CompanyNoticeModel * model = [CompanyNoticeModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        [self.refreshUI sendNext:nil];
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
    }];
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray * array) {
        
            if (array.count < 1) {
                showMassage(@"暂无数据")
                [self.refreshEndSubject sendNext:@(FooterRefresh_HasNoMoreData)];

                return ;
            }
            
        
        for (NSDictionary *dic in array) {
            CompanyNoticeModel * model = [CompanyNoticeModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
    }];
    
}

-(RACCommand *)nextPageCommand{
    
    if (!_nextPageCommand) {
        @weakify(self)
        _nextPageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               
                self.currentPage ++;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   
                    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                    [dic setObject:[NSString stringWithFormat:@"%ld",(long)_currentPage] forKey:@"page_no"];
                    
                    [RDRequest postMineWithApi:@"/api/companyNotice/list.api" andParam:dic success:^(RDRequestModel *model) {
                        if ([model.State intValue]==1) {
                            [subscriber sendNext:model.Data];
                        }else{
                            self.currentPage --;

                            showMassage(@"请求失败")
                        }
                        
                        [subscriber sendCompleted];
                        
                    } failure:^(NSError *error) {
                        @strongify(self)
                        self.currentPage --;
                        [subscriber sendCompleted];
                        showMassage(@"请求失败")

                    }];
                    
                });
                
                return nil;
            }];
        }];
    }
    return _nextPageCommand;
}

-(RACCommand *)refreshDataCommand{

    if (!_refreshDataCommand) {
        _refreshDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSError * error;
                    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                    _currentPage = 1;
                    [dic setObject:[NSString stringWithFormat:@"%ld",(long)_currentPage] forKey:@"page_no"];
                    
                    RDRequestModel * model = [RDRequest getWithApi:@"/api/companyNotice/list.api" andParam:dic error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        if (error == nil) {
                            NSLog(@"%@",model.Data);
                            [subscriber sendNext:model.Data];
                            [subscriber sendCompleted];
                        }else showMassage(@"网络请求失败")
                    });
                });
                
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;

}

-(NSInteger)currentPage{

    if (!_currentPage) {
        _currentPage = 1;
    }
    return _currentPage;
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

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(RACSubject *)cellClick{

    if (!_cellClick) {
        _cellClick = [RACSubject subject];
    }
    return _cellClick;
}

@end
