//
//  MessageTableViewCell.m
//  RDFuturesApp
//
//  Created by user on 17/5/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleText;
@property(nonatomic,strong)UILabel *subtitle;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *prompt;//提示
@property(nonatomic,strong)UIView *line;
@end

@implementation MessageTableViewCell

-(void)setupViews{
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.prompt];
    [self.contentView addSubview:self.titleText];
    [self.contentView addSubview:self.subtitle];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.line];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setBackgroundColor:[UIColor clearColor]];
}

-(void)updateConstraints{
    WS(weakself)
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).with.offset(7.5);
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.size.mas_offset(CGSizeMake(35, 35));
    }];
    [self.prompt mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(weakSelf.contentView).with.offset(11);
        make.left.equalTo(weakSelf.contentView).with.offset(44);
        make.size.mas_offset(CGSizeMake(10, 10));
    }];
    [self.titleText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.contentView).with.offset(20);
        make.centerY.equalTo(weakSelf.icon);
        make.left.equalTo(weakSelf.icon.mas_right).with.offset(15);
        make.size.mas_offset(CGSizeMake(150, 25));
    }];
//    [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.titleText.mas_bottom).with.offset(8);
//        make.left.equalTo(weakSelf.icon.mas_right).with.offset(10);
//        make.size.mas_offset(CGSizeMake(150,  13.5));
//    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).with.offset(15);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
        make.size.mas_offset(CGSizeMake(120, 35));
    }];
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [super updateConstraints];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = RGB(210, 210, 210);
    }
    return _line;
}
-(void)setModel:(MessageModel *)model{
    if (model) {
        _model = model;
        self.icon.image = [UIImage imageNamed:model.image];
        self.titleText.text = model.titleText;
        self.subtitle.text = model.subtitle;
        self.time.text = model.time;
        self.prompt.hidden = !model.is_new_inform;
    }
}
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

-(UILabel *)titleText{
    if (!_titleText) {
        _titleText = [[UILabel alloc] init];
        _subtitle.font = [UIFont rdSystemFontOfSize:20];
    }
    return _titleText;
}
-(UILabel *)subtitle{
    if (!_subtitle) {
        _subtitle = [[UILabel alloc] init];
        _subtitle.font = [UIFont rdSystemFontOfSize:12];
        _subtitle.textAlignment = NSTextAlignmentLeft;
    }
    return _subtitle;
}
-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont rdSystemFontOfSize:12];
        _time.textAlignment = NSTextAlignmentRight;
    }
    return _time;
}
-(UILabel *)prompt{
    if (!_prompt) {
        _prompt = [[UILabel alloc] init];
        _prompt.font = [UIFont rdSystemFontOfSize:10];
        _prompt.layer.masksToBounds = YES;
        _prompt.layer.cornerRadius = 5.3f;
        _prompt.backgroundColor = RGB(226, 12, 32);
        
    }
    return _prompt;
}
@end
