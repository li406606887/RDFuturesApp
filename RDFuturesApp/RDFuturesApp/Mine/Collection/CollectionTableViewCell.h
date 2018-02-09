//
//  CollectionTableViewCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/25.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"
static NSString * const kCollectionTableViewCell = @"CollectionTableViewCell";

@interface CollectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,strong) CollectionModel *model;

@end
