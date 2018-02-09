//
//  HomeItemCollectionCell.h
//  RDFuturesApp
//
//  Created by user on 17/4/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface HomeItemCollectionCell : BaseCollectionViewCell
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;
@property (nonatomic,strong) UIView *bgView;//背景
@end
