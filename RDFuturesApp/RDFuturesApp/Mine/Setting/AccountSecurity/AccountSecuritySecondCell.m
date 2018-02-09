//
//  AccountSecuritySecondCell.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/27.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AccountSecuritySecondCell.h"

@implementation AccountSecuritySecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)changeBtnClick:(UIButton *)sender {
    
    if (self.changeButton) {
        self.bBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
