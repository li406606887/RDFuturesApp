//
//  MAChooseTableViewCell.h
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MAChooseTableViewCell : BaseTableViewCell

@property(nonatomic,strong)NSString *title;


@property(nonatomic,strong)NSArray *titleArray;


@property(nonatomic,strong)UILabel *contentText;


@property(nonatomic,strong) void (^chooseCellBlock)(NSString *value);



@end

