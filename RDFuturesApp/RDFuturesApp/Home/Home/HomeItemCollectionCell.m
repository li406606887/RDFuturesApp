//
//  HomeItemCollectionCell.m
//  RDFuturesApp
//
//  Created by user on 17/4/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "HomeItemCollectionCell.h"


@interface HomeItemCollectionCell()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation HomeItemCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.imageView];
        [self.bgView addSubview:self.titleLabel];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}


-(void)setTitle:(NSString *)title{
    if (title.length>0) {
        self.titleLabel.text = title;

    }
}
-(void)setIcon:(NSString *)icon{
    if (icon.length>0) {
        [self.imageView setImage:[UIImage imageNamed:icon]];
    }
}


-(void)updateConstraints{
    WS(weakself)
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).with.offset(-3);
        make.right.equalTo(weakSelf).with.offset(-3);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf).with.offset(-10);
        make.size.mas_offset(CGSizeMake(32, 32));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.imageView.mas_bottom).offset(7.5);
        make.height.mas_offset(20);
    }];
    [super updateConstraints];
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.shadowColor = RGB(0, 0, 0).CGColor;
        _bgView.layer.shadowOpacity = 0.12f;
        _bgView.layer.shadowRadius = 2.f;
        _bgView.layer.shadowOffset = CGSizeMake(2, 2);
        _bgView.backgroundColor = [UIColor whiteColor];        
    }
    return _bgView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setBackgroundColor:[UIColor clearColor]];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:RGB(51, 51, 51)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setFont:[UIFont rdSystemFontOfSize:15]];
        
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}
@end
