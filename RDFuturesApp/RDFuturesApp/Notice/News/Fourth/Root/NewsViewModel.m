//
//  NewsViewModel.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsViewModel.h"
#import "NewsListModel.h"

@implementation NewsViewModel

-(void)initialize {
    @weakify(self)
    [self.getFifthDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable x) {
        @strongify(self)
        if (x.count<1) {
            [self.refreshFirstSubject sendNext:@"0"];
        }else{
            for (NSDictionary *dic in x) {
                NewsListModel *model = [NewsListModel mj_objectWithKeyValues:dic];
                [self.firstDataArray addObject:model];
            }
            [self.refreshFirstSubject sendNext:@"1"];
        }
    }];
    [self.getSecondDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable x) {
        @strongify(self)
        if (x.count<1) {
            [self.refreshSecondSubject sendNext:@"0"];
        }else{
            for (NSDictionary *dic in x) {
                NewsListModel *model = [NewsListModel mj_objectWithKeyValues:dic];
                [self.secondDataArray addObject:model];
            }
            [self.refreshSecondSubject sendNext:@"1"];
        }
    }];
    [self.getThirdDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable x) {
        @strongify(self)
        if (x.count<1) {
            [self.refreshThirdSubject sendNext:@"0"];
        }else{
            for (NSDictionary *dic in x) {
                NewsListModel *model = [NewsListModel mj_objectWithKeyValues:dic];
                [self.thirdDataArray addObject:model];
            }
            [self.refreshThirdSubject sendNext:@"1"];
        }
    }];
    [self.getFourthDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable x) {
        @strongify(self)
        if (x.count<1) {
            [self.refreshFourthSubject sendNext:@"0"];
        }else{
            for (NSDictionary *dic in x) {
                NewsListModel *model = [NewsListModel mj_objectWithKeyValues:dic];
                [self.fourthDataArray addObject:model];
            }
            [self.refreshFourthSubject sendNext:@"1"];
        }
    }];
    [self.getFifthDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable x) {
        @strongify(self)
        if (x.count<1) {
            [self.refreshFifthSubject sendNext:@"0"];
        }else{
            for (NSDictionary *dic in x) {
                NewsListModel *model = [NewsListModel mj_objectWithKeyValues:dic];
                [self.fifthDataArray addObject:model];
            }
            [self.refreshFifthSubject sendNext:@"1"];
        }
    }];
    [self.getSixthDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable x) {
        @strongify(self)
        if (x.count<1) {
            [self.refreshSixthSubject sendNext:@"0"];
        }else{
            for (NSDictionary *dic in x) {
                NewsListModel *model = [NewsListModel mj_objectWithKeyValues:dic];
                [self.sixthDataArray addObject:model];
            }
            [self.refreshSixthSubject sendNext:@"1"];
        }
    }];
    [self.getSeventhDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable x) {
        @strongify(self)
        if (x.count<1) {
            [self.refreshSeventhSubject sendNext:@"0"];
        }else{
            for (NSDictionary *dic in x) {
                NewsListModel *model = [NewsListModel mj_objectWithKeyValues:dic];
                [self.seventhDataArray addObject:model];
            }
            [self.refreshSeventhSubject sendNext:@"1"];
        }
    }];
    [self.getEighthDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable x) {
        @strongify(self)
        if (x.count<1) {
            [self.refreshEighthSubject sendNext:@"0"];
        }else{
            for (NSDictionary *dic in x) {
                NewsListModel *model = [NewsListModel mj_objectWithKeyValues:dic];
                [self.eighthDataArray   addObject:model];
            }
            [self.refreshEighthSubject sendNext:@"1"];
        }
    }];
}

-(RACCommand *)getFirstDataCommand {
    if (!_getFirstDataCommand) {
        _getFirstDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"108" forKey:@"channelId"];
                    [dic setObject:input forKey:@"page"];
                    RDRequestModel * model = [RDRequest getNewsListWithApi:@"/api/news/list.api" andParam:dic error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                [subscriber sendNext:model.Data];
                            }else {
                                showMassage(model.Message)
                                [self.refreshFirstSubject sendNext:@"0"];
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                            [self.refreshFirstSubject sendNext:@"0"];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getFirstDataCommand;
}

-(RACCommand *)getSecondDataCommand {
    if (!_getSecondDataCommand) {
        _getSecondDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"108" forKey:@"channelId"];
                    [dic setObject:@"1" forKey:@"page"];
                    RDRequestModel * model = [RDRequest getNewsListWithApi:@"/api/news/list.api" andParam:dic error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                [subscriber sendNext:model.Data];
                            }else {
                                showMassage(model.Message)
                                [subscriber sendNext:nil];
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                            [subscriber sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getSecondDataCommand;
}

-(RACCommand *)getThirdDataCommand {
    if (!_getThirdDataCommand) {
        _getThirdDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"108" forKey:@"channelId"];
                    [dic setObject:@"1" forKey:@"page"];
                    RDRequestModel * model = [RDRequest getNewsListWithApi:@"/api/news/list.api" andParam:dic error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                [subscriber sendNext:model.Data];
                            }else {
                                showMassage(model.Message)
                                [subscriber sendNext:nil];
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                            [subscriber sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getThirdDataCommand;
}

-(RACCommand *)getFourthDataCommand {
    if (!_getFourthDataCommand) {
        _getFourthDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"108" forKey:@"channelId"];
                    [dic setObject:@"1" forKey:@"page"];
                    RDRequestModel * model = [RDRequest getNewsListWithApi:@"/api/news/list.api" andParam:dic error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                [subscriber sendNext:model.Data];
                            }else {
                                showMassage(model.Message)
                                [subscriber sendNext:nil];
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                            [subscriber sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getFourthDataCommand;
}

-(RACCommand *)getFifthDataCommand {
    if (!_getFifthDataCommand) {
        _getFifthDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"108" forKey:@"channelId"];
                    [dic setObject:@"1" forKey:@"page"];
                    RDRequestModel * model = [RDRequest getNewsListWithApi:@"/api/news/list.api" andParam:dic error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                [subscriber sendNext:model.Data];
                            }else {
                                showMassage(model.Message)
                                [subscriber sendNext:nil];
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                            [subscriber sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getFifthDataCommand;
}

-(RACCommand *)getSixthDataCommand {
    if (!_getSixthDataCommand) {
        _getSixthDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"108" forKey:@"channelId"];
                    [dic setObject:@"1" forKey:@"page"];
                    RDRequestModel * model = [RDRequest getNewsListWithApi:@"/api/news/list.api" andParam:dic error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                [subscriber sendNext:model.Data];
                            }else {
                                showMassage(model.Message)
                                [subscriber sendNext:nil];
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                            [subscriber sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getSixthDataCommand;
}

-(RACCommand *)getSeventhDataCommand {
    if (!_getSeventhDataCommand) {
        _getSeventhDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"108" forKey:@"channelId"];
                    [dic setObject:@"1" forKey:@"page"];
                    RDRequestModel * model = [RDRequest getNewsListWithApi:@"/api/news/list.api" andParam:dic error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                [subscriber sendNext:model.Data];
                            }else {
                                showMassage(model.Message)
                                [subscriber sendNext:nil];
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                            [subscriber sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getSeventhDataCommand;
}

-(RACCommand *)getEighthDataCommand {
    if (!_getEighthDataCommand) {
        _getEighthDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"108" forKey:@"channelId"];
                    [dic setObject:@"1" forKey:@"page"];
                    RDRequestModel * model = [RDRequest getNewsListWithApi:@"/api/news/list.api" andParam:dic error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                [subscriber sendNext:model.Data];
                            }else {
                                showMassage(model.Message)
                                [subscriber sendNext:nil];
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                            [subscriber sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getEighthDataCommand;
}

-(RACSubject *)refreshFirstSubject {
    if (!_refreshFirstSubject) {
        _refreshFirstSubject = [RACSubject subject];
    }
    return _refreshFirstSubject;
}

-(NSMutableArray *)firstDataArray {
    if (!_firstDataArray) {
        _firstDataArray = [[NSMutableArray alloc] init];
    }
    return _firstDataArray;
}

-(RACSubject *)refreshSecondSubject {
    if (!_refreshSecondSubject) {
        _refreshSecondSubject = [RACSubject subject];
    }
    return _refreshSecondSubject;
}

-(NSMutableArray *)secondDataArray {
    if (!_secondDataArray) {
        _secondDataArray = [[NSMutableArray alloc] init];
    }
    return _secondDataArray;
}

-(RACSubject *)refreshThirdSubject {
    if (!_refreshThirdSubject) {
        _refreshThirdSubject = [RACSubject subject];
    }
    return _refreshThirdSubject;
}

-(NSMutableArray *)thirdDataArray {
    if (!_thirdDataArray) {
        _thirdDataArray = [[NSMutableArray alloc] init];
    }
    return _thirdDataArray;
}

-(RACSubject *)refreshFourthSubject {
    if (!_refreshFourthSubject) {
        _refreshFourthSubject = [RACSubject subject];
    }
    return _refreshFourthSubject;
}

-(NSMutableArray *)fourthDataArray {
    if (!_fourthDataArray) {
        _fourthDataArray = [[NSMutableArray alloc] init];
    }
    return _fourthDataArray;
}

-(RACSubject *)refreshFifthSubject {
    if (!_refreshFifthSubject) {
        _refreshFifthSubject = [RACSubject subject];
    }
    return _refreshFifthSubject;
}

-(NSMutableArray *)fifthDataArray {
    if (!_fifthDataArray) {
        _fifthDataArray = [[NSMutableArray alloc] init];
    }
    return _fifthDataArray;
}

-(RACSubject *)refreshSixthSubject {
    if (_refreshSixthSubject) {
        _refreshSixthSubject = [RACSubject subject];
    }
    return _refreshSixthSubject;
}

-(NSMutableArray *)sixthDataArray {
    if (!_sixthDataArray) {
        _sixthDataArray = [[NSMutableArray alloc] init];
    }
    return _sixthDataArray;
}

-(RACSubject *)refreshSeventhSubject {
    if (!_refreshSeventhSubject) {
        _refreshSeventhSubject = [RACSubject subject];
    }
    return _refreshSeventhSubject;
}

-(NSMutableArray *)seventhDataArray {
    if (!_seventhDataArray) {
        _seventhDataArray = [[NSMutableArray alloc] init];
    }
    return _seventhDataArray;
}

-(RACSubject *)refreshEighthSubject {
    if (!_refreshEighthSubject) {
        _refreshEighthSubject = [RACSubject subject];
    }
    return _refreshEighthSubject;
}

-(NSMutableArray *)eighthDataArray {
    if (!_eighthDataArray) {
        _eighthDataArray = [[NSMutableArray alloc] init];
    }
    return _eighthDataArray;
}

-(RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

-(RACSubject *)didEndScrollSubject{
    if (!_didEndScrollSubject) {
        _didEndScrollSubject = [RACSubject subject];
    }
    return _didEndScrollSubject;
}

-(RACSubject *)titleClickSubject{
    if (!_titleClickSubject) {
        _titleClickSubject = [RACSubject subject];
    }
    return _titleClickSubject;
}

@end
