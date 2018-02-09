//
//  MineSecondTableViewCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kMineSecondTableViewCell = @"MineSecondTableViewCell";
@interface MineSecondTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bottonView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rihgtImgView;
@property (weak, nonatomic) IBOutlet UIImageView *downImgView;

@end
