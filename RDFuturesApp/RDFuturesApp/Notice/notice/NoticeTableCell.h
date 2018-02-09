//
//  NoticeTableCell.h
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "NoticeModel.h"
#import "NoticeViewModel.h"

@interface NoticeTableCell : BaseTableViewCell
@property(nonatomic,strong) NoticeModel *model;
@property(nonatomic,strong) NSArray *array;
@property(nonatomic,strong) NoticeViewModel *viewModel;

@end
