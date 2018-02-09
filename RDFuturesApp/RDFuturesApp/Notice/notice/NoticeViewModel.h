//
//  NoticeViewModel.h
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface NoticeViewModel : BaseViewModel
@property(nonatomic,strong)RACSubject *refreshEndSubject;//刷新结束

@property(nonatomic,strong)RACSubject *refreshUI;//刷新UI

@property(nonatomic,strong)RACSubject *cellClickSubject;//cell 被点击

@property(nonatomic,strong)RACCommand *refreshDataCommand;//刷新数据

@property(nonatomic,strong)RACCommand *nextPageCommand;//下一页

@property(nonatomic,strong)NSMutableArray *dataArray;//数据数组


@end
