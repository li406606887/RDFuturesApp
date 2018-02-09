//
//  CompanyNoticeCell.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "CompanyNoticeCell.h"

@implementation CompanyNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgview.layer.cornerRadius = 6;
    _bgview.layer.masksToBounds = YES;
}
-(void)setModel:(CompanyNoticeModel *)model{

    if (!model) {
        return;
    }
    
    _model = model;
    
    self.timeLabel.text = _model.create_time;
    self.titleLabel.text = _model.title;
    self.contentLabel.text = _model.digest;
    
//    1、title                			公司公告标题
//    2、digest						公司公告摘要
//    3、content_url					公司公告详情路径
//    4、create_time					发布时间
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
