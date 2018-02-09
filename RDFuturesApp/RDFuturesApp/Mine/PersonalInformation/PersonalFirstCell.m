//
//  PersonalFirstCell.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "PersonalFirstCell.h"

@implementation PersonalFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imgView.layer.cornerRadius = 25;
    _imgView.layer.masksToBounds = YES;
    _imgView.image = [UIImage imageNamed:@"head_icon"];//写死
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
