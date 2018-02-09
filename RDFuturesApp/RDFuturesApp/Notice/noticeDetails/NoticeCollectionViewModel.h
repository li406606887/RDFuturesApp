//
//  NoticeCollectionViewModel.h
//  RDFuturesApp
//
//  Created by user on 2017/5/19.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface NoticeCollectionViewModel : BaseViewModel
@property(nonatomic,copy)RACSubject *refreshUI;
@property(nonatomic,copy)RACSubject *refreshStyle;
@property(nonatomic,copy)RACCommand *collectionClickCommand;//api/user/checkCollect.api
@property(nonatomic,copy)RACCommand *reloadClollectionStyleCommand;//加载收藏状态
@end
