//
//  MineFirstTableViewCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kMineFirstTableViewCell = @"MineFirstTableViewCell";
@interface MineFirstTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightImgView;


@end
