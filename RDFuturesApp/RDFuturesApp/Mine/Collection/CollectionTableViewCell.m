//
//  CollectionTableViewCell.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/25.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "CollectionTableViewCell.h"

@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}





#pragma mark - 重写set
-(void)setModel:(CollectionModel *)model{

    if (!model) {
        return;
    }
    
    _model = model;
    self.timeLabel.text = _model.collectTime;
    self.titleLabel.text = _model.title;
    NSURL * url = [NSURL URLWithString:_model.imageUrl];
    [self.imgView sd_setImageWithURL:url];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
