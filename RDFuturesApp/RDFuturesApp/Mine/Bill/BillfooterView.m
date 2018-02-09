//
//  BillfooterView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BillfooterView.h"

@implementation BillfooterView


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightView];
    [self addSubview:self.leftView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
}

-(void)updateConstraints{
    
    WS(weakself)
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
//        make.center.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(110, 25));
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.titleLabel);
        make.left.equalTo(weakSelf.titleLabel.mas_right).with.offset(3);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_equalTo(1);
//        make.height.equalTo(@2);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.titleLabel);
        make.right.equalTo(weakSelf.titleLabel.mas_left).with.offset(-3);
        make.left.equalTo(weakSelf).with.offset(15);
        make.height.mas_equalTo(1);
//        make.height.equalTo(@2);
    }];
    
    [super updateConstraints];
}

-(UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"已展示全部账单";
        _titleLabel.font = [UIFont rdSystemFontOfSize:15.0f];
        _titleLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0f];
    }
    
    return _titleLabel;
    
}

-(UIView *)rightView{

    if (!_rightView) {
        _rightView = [[UIView alloc]init];
        _rightView.backgroundColor = [UIColor colorWithRed:96.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0];
    }
    return _rightView;

}

-(UIView *)leftView{

    if (!_leftView) {
        _leftView = [[UIView alloc]init];
        _leftView.backgroundColor = [UIColor colorWithRed:96.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0];
    }
    return _leftView;

}

@end
