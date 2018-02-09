//
//  PopCollectionView.h
//  RDFuturesApp
//
//  Created by user on 2017/5/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseView.h"
#import "NoticeModel.h"
#import "NoticeCollectionViewModel.h"

@interface PopCollectionView : BaseView
@property(nonatomic,assign)NoticeModel *model;
@property(nonatomic,assign)BOOL isCollect;
@property(nonatomic,strong)NoticeCollectionViewModel *viewModel;
@end
                 
