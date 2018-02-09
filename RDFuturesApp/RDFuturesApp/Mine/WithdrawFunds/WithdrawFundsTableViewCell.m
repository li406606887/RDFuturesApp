//
//  WithdrawFundsTableViewCell.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "WithdrawFundsTableViewCell.h"



@interface WithdrawFundsTableViewCell()
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UITextField *contentField;
@end


@implementation WithdrawFundsTableViewCell

-(void)setupViews{
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.contentField];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{
    WS(weakself)
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.size.mas_offset(CGSizeMake(150, 15));
    }];
    
    [self.contentField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.title.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
        make.height.mas_offset(45);
    }];
    
    [super updateConstraints];
}
-(void)setPlaceholder:(NSString *)placeholder{
    _contentField.placeholder = placeholder;
}

-(void)setTitleStr:(NSString *)titleStr{
    self.title.text = titleStr;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(UITextField *)contentField{
    if (!_contentField) {
        _contentField = [[UITextField alloc] init];
        _contentField.layer.borderColor = [RGB(210, 210, 210) CGColor];
        _contentField.font = [UIFont rdSystemFontOfSize:14];
        _contentField.layer.borderWidth = 0.5f;
        _contentField.leftViewMode = UITextFieldViewModeAlways;
        UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,10,26)];
        leftView.backgroundColor = [UIColor clearColor];
        _contentField.leftView = leftView;
        WS(weakself)
        [[_contentField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(id x){
            //x是textField对象
            UITextField *field = (UITextField *)x;
            if (weakSelf.textFieldBlock) {
                weakSelf.textFieldBlock(field.text);
            }
        }];
    }
    return _contentField;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        [_title setTextColor:RGB(68, 68, 68)];
        _title.font = [UIFont rdSystemFontOfSize:15];
    }
    return _title;
}

@end
