//
//  HomeTableViewCell.m
//  RDFuturesApp
//
//  Created by user on 17/5/2.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *yellowView;
@end

@implementation HomeTableViewCell


-(void)setupViews{
    
    [self.contentView addSubview:self.bgView];
    
    [self.bgView addSubview:self.icon];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.yellowView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    [super updateConstraints];
    WS(weakself)
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(-3);
        make.right.equalTo(weakSelf).with.offset(0);
    }];
    
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.bgView);
        make.left.equalTo(weakSelf.bgView);
        make.right.equalTo(weakSelf.bgView);
        make.height.mas_equalTo(3);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bgView);
        make.left.equalTo(weakSelf.bgView).with.offset(35);
        make.size.mas_offset(CGSizeMake(79, 67));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bgView);
        make.left.equalTo(weakSelf.icon.mas_right).with.offset(0);
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-2);
        make.height.offset(75);
    }];
}
-(UIView *)yellowView{

    if (!_yellowView) {
        _yellowView = [[UIView alloc]init];
        _yellowView.backgroundColor = RGB(255, 170, 0);
    }
    return _yellowView;
}
-(UIView *)bgView{

    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.shadowColor = RGB(0, 0, 0).CGColor;
        _bgView.layer.shadowOpacity = 0.11f;
        _bgView.layer.shadowRadius = 3.f;
        _bgView.layer.shadowOffset = CGSizeMake(3, 3);
        _bgView.backgroundColor = [UIColor whiteColor];
        
        _bgView.layer.cornerRadius = 3;

    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.minimumLineHeight = 24;//最低行高
        CGFloat font = SCREEN_WIDTH == 320 ? 12:fifteenFontSize;
        CGFloat bigFont = SCREEN_WIDTH == 320 ? 16.0: 20.0;
        NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont rdSystemFontOfSize:font],NSForegroundColorAttributeName:RGB(51, 51, 51)};
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:@"随时随地五分钟完成\n开户资料提交、极速开户、安全便捷" attributes:attributes];
        [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:bigFont] range:NSMakeRange(0, 9)];
        _titleLabel.attributedText = attributed;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"Speed_OpenAcount"];
    }
    return _icon;
}


@end
