//
//  HomeViewModel.h
//  RDFuturesApp
//
//  Created by user on 17/3/1.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"
#import "RDCommon.h"

@interface HomeViewModel : BaseViewModel

@property(nonatomic,strong)RACSubject *cellClickSubject;//cell 被点击

@property(nonatomic,strong)RACSubject *itemclickSubject;//itemView 被点击

@property(nonatomic,strong)RACSubject *imageclickSubject;//滚动图片 被点击

@property(nonatomic,strong)RACSubject *refreshUI;//刷新UI

@property(nonatomic,strong)RACCommand *refreshDataCommand;//刷新首页广告数据

@property(nonatomic,strong)RACSubject *refreshEndSubject;//刷新结束

@property(nonatomic,strong)NSMutableArray *dataArray;//数据数组

@property(nonatomic,strong)RACCommand *refreshAccountCommand;//获取是否完成开户

@property(nonatomic,strong)RACSubject *accountSubject;//

@property(nonatomic,strong)RACCommand *refreshMessageStateCommand;//获取首页消息状态

@property(nonatomic,strong)RACSubject *refreshMessageStateSubject;//刷新首页消息状态

@property(nonatomic,strong)RACCommand *refreshAnnouncementStateCommand;//获取首页公告消息状态

@property(nonatomic,strong)RACSubject *refreshAnnouncementStateSubject;//刷新首页公告图片
@end
