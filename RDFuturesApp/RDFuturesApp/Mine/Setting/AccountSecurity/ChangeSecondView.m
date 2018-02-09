//
//  ChangeSecondView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ChangeSecondView.h"

@implementation ChangeSecondView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{

    self.viewModel = (ChangeSecondViewModel *)viewModel;
    return [super initWithViewModel:viewModel];

}

-(void)layoutSubviews{


}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{

    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.areaLabel];
    [self addSubview:self.areaButton];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.sendCodeLabel];
    [self addSubview:self.codeLabel];
    [self addSubview:self.codeTextField];
    [self addSubview:self.commitBtn];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
}

-(void)updateConstraints{

    WS(weakself)
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(12);
        make.left.equalTo(weakSelf).with.offset(12);
        make.size.mas_offset(CGSizeMake(35, 35));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(12);
        make.left.equalTo(weakSelf.imgView.mas_right).with.offset(5);
        make.right.equalTo(weakSelf).with.offset(-8);
        make.height.equalTo(@35);
    }];
    
    
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imgView.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf).with.offset(12);
        make.size.mas_offset(CGSizeMake(75, 30));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.areaLabel.mas_bottom).with.offset(15);
        make.centerX.equalTo(weakSelf.areaLabel);
        make.size.mas_equalTo(weakSelf.areaLabel);
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneLabel.mas_bottom).with.offset(15);
        make.centerX.equalTo(weakSelf.phoneLabel);
        make.size.mas_equalTo(weakSelf.phoneLabel);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.codeLabel.mas_bottom).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-30);
        make.left.equalTo(weakSelf).with.offset(30);
        make.height.mas_equalTo(@40);
    }];
    
    [self.areaButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.areaLabel);
        make.right.equalTo(weakSelf).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [self.sendCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.phoneLabel);
        make.right.equalTo(weakSelf).with.offset(-8);
        make.size.mas_equalTo(weakSelf.areaLabel);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.phoneLabel);
        make.right.equalTo(weakSelf.sendCodeLabel.mas_left).with.offset(-3);
        make.left.equalTo(weakSelf.phoneLabel.mas_right).with.offset(-3);
        make.height.mas_equalTo(weakSelf.areaLabel.mas_height);
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.codeLabel);
        make.left.equalTo(weakSelf.codeLabel.mas_right).with.offset(-3);
        make.height.mas_equalTo(weakSelf.areaLabel.mas_height);
        make.width.mas_equalTo(weakSelf.phoneTextField.mas_width);

    }];
    
    [super updateConstraints];
}





-(UIButton *)commitBtn{
    
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"b_btn"] forState:UIControlStateNormal];
        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"b_btn"] forState:UIControlStateHighlighted];
        [_commitBtn setTitle:@"提交验证" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = [UIFont rdSystemFontOfSize:18.0f];
    }
    return _commitBtn;
}


-(UILabel *)sendCodeLabel{

    if (!_sendCodeLabel) {
        _sendCodeLabel = [[UILabel alloc]init];
        _sendCodeLabel.backgroundColor = [UIColor whiteColor];
        _sendCodeLabel.text = @"发送验证码";
        _sendCodeLabel.textColor = BLUECOLOR;
        _sendCodeLabel.font = [UIFont rdSystemFontOfSize:15.0f];
        _sendCodeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            [self.viewModel.codeClickSubject sendNext:nil];
        }];
        [_sendCodeLabel addGestureRecognizer:tap];
    }
    return _sendCodeLabel;
}

-(UITextField *)codeTextField{

    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc]init];
        _codeTextField.borderStyle = UITextBorderStyleLine;
        _codeTextField.font = [UIFont rdSystemFontOfSize:13.0f];
        _codeTextField.textColor = GRAYCOLOR2;
        _codeTextField.layer.borderWidth = 1.0;
        
        _codeTextField.layer.borderColor = GRAYKUANGCOLOR.CGColor;
    }
    return _codeTextField;

}

-(UITextField *)phoneTextField{
    
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.borderStyle = UITextBorderStyleLine;
        _phoneTextField.font = [UIFont rdSystemFontOfSize:13.0f];
        _phoneTextField.textColor = GRAYCOLOR2;
        _phoneTextField.layer.borderWidth = 1.0;
        
        _phoneTextField.layer.borderColor = GRAYKUANGCOLOR.CGColor;
    }
    return _phoneTextField;
}

-(UILabel *)codeLabel{
    
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.textColor = GRAYCOLOR2;
        _codeLabel.text = @"短信验证";
        _codeLabel.font = [UIFont rdSystemFontOfSize:15.0f];
        _codeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _codeLabel;

}

-(UILabel *)phoneLabel{

    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = GRAYCOLOR2;
        _phoneLabel.text = @"手机号码";
        _phoneLabel.font = [UIFont rdSystemFontOfSize:15.0f];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _phoneLabel;
}

-(UIButton *)areaButton{

    if (!_areaButton) {
        
        _areaButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_areaButton setBackgroundColor:[UIColor whiteColor]];
        [_areaButton setTitle:@"中国大陆 +86" forState:UIControlStateNormal];
        [_areaButton setTitleColor:GRAYCOLOR2 forState:UIControlStateNormal];
        _areaButton.titleLabel.font = [UIFont rdSystemFontOfSize:15.0f];
    }
    return _areaButton;
}
-(UILabel *)areaLabel{

    if (!_areaLabel) {
        _areaLabel = [[UILabel alloc]init];
        _areaLabel.textColor = GRAYCOLOR2;
        _areaLabel.text = @"所属地区";
        _areaLabel.font = [UIFont rdSystemFontOfSize:15.0f];
        _areaLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _areaLabel;
}

-(UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"验证通过，请更换手机号";
        _titleLabel.font = [UIFont rdSystemFontOfSize:12.0f];
        _titleLabel.textColor = GRAYCOLOR2;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(UIImageView *)imgView{

    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mine_tick_icon"]];
    }
    return _imgView;
}

@end
