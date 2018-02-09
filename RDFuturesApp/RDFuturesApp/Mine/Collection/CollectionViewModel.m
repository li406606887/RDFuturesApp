//
//  CollectionViewModel.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/26.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "CollectionViewModel.h"
#import "CollectionModel.h"

@interface CollectionViewModel ()

@property (nonatomic, assign)NSInteger currentPage;

@end

@implementation CollectionViewModel

-(void)initialize{
    
    WS(weakself)
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray   * array) {
        
        if (weakSelf.dataArray.count != 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        
        for (NSDictionary * dic in array) {
            CollectionModel * model = [CollectionModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        [self.refreshUI sendNext:nil];
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
    }];
    
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray * array) {
        
        for (NSDictionary * dic in array) {
            CollectionModel * model = [CollectionModel mj_objectWithKeyValues:dic];
            
            [weakSelf.dataArray addObject:model];
        }
        
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];
    
    
}

/*
 
 /api/user/getMyCollect.api
 
 *请求参数*
 
 1、pageNo               收藏的页码
 
 *返回参数*
 
 1、noticeId				 收藏圈子id
 2、title                收藏圈子的标题
 3、collectTime          收藏的时间
 4、imageUrl				 图片url
 5、contentUrl			 收藏的内容详情url
 
 */

-(RACCommand *)nextPageCommand{
    
    if (!_nextPageCommand) {
        @weakify(self);
        _nextPageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                @strongify(self);
                self.currentPage ++;
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                    [dic setObject:[NSString stringWithFormat:@"%ld",(long)_currentPage] forKey:@"pageNo"];
                    
                    [RDRequest postMineWithApi:@"/api/user/getMyCollect.api" andParam:dic success:^(RDRequestModel *model) {
                        
                        if ([model.State intValue]==1) {
                            if ([model.Data isKindOfClass:[NSArray class]]) {
                                NSArray * arr = model.Data;
                                if (arr.count == 0) {
                                    self.currentPage --;
                                    showMassage(@"暂无数据")
                                }
                            }
                            
                            [subscriber sendNext:model.Data];
                        }
                        
                        [subscriber sendCompleted];
                        
                        
                    } failure:^(NSError *error) {
                        @strongify(self);
                        self.currentPage --;
                        [subscriber sendCompleted];
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
                    [dic setObject:[NSString stringWithFormat:@"%ld",(long)_currentPage] forKey:@"pageNo"];
                    
                    RDRequestModel * model = [RDRequest getWithApi:@"/api/user/getMyCollect.api" andParam:dic error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                
                                [subscriber sendNext:model.Data];
                            }
                            else{
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
    return _refreshDataCommand;
}

-(NSInteger)currentPage{
    
    if (!_currentPage) {
        _currentPage = 1;
    }
    return _currentPage;
}

-(RACSubject *)cellClick{
    
    if (!_cellClick) {
        _cellClick = [RACSubject subject];
    }
    return _cellClick;
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
@end
