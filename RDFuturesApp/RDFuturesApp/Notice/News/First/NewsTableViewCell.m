//
//  NewsTableViewCell.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/19.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(NewsListModel *)model{

    if (!model) {
        return;
    }
    
    _model = model;
    self.timeLabel.text = _model.releaseDate;
    self.titleLabel.text = _model.title;
    NSURL * url = [NSURL URLWithString:_model.imageUrl];
    [self.imgView sd_setImageWithURL:url];
}

-(void)layoutSubviews{
    

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15);
        make.left.equalTo(self.contentView).with.offset(15);
        make.right.equalTo(self.contentView).with.offset(-15);
        make.height.mas_offset(20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(15);
        make.right.equalTo(self.contentView).with.offset(-15);
        make.height.equalTo(@20);
        
    }];

//    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).with.offset(10);
//        make.left.equalTo(self.contentView).with.offset(10);
//        make.size.mas_offset(CGSizeMake(120, 95));
//        
//    }];
//    
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.contentView).with.offset(-5);
//        make.right.equalTo(self.contentView).with.offset(-8);
//        make.size.mas_offset(CGSizeMake(150, 20));
//        
//    }];
//    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.equalTo(self.contentView).with.offset(8);
//        make.left.equalTo(self.imgView.mas_right).with.offset(8);
////        make.bottom.equalTo(self.timeLabel.mas_top).with.offset(-5);
//        make.right.equalTo(self.contentView.mas_right).with.offset(-8);
//        make.height.equalTo(@55);
//        
//    }];
    
    [super layoutSubviews];
}

-(UIImageView *)imgView{

    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
}

-(UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont rdSystemFontOfSize:16.f];
        _titleLabel.textColor = RGB(51, 51, 51);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)timeLabel{

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont rdSystemFontOfSize:13.f];
        _timeLabel.textColor = RGB(132, 131, 131);
        
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
