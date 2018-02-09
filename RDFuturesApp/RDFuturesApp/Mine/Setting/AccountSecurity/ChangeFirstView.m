//
//  ChangeFirstView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/4.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ChangeFirstView.h"

@implementation ChangeFirstView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel
{

    self.viewModel = (ChangeViewModel *)viewModel;
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
    [self addSubview:self.codeLabel];
    [self addSubview:self.codeTextfield];
    [self addSubview:self.passWordLabel];
    [self addSubview:self.passWordTextfield];
    [self addSubview:self.blueLabel];
    [self addSubview:self.commitButton];
    
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
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imgView.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf).with.offset(12);
        make.size.mas_offset(CGSizeMake(75, 30));
    }];
    
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.codeLabel.mas_bottom).with.offset(15);
        make.centerX.equalTo(weakSelf.codeLabel);
        make.size.mas_equalTo(weakSelf.codeLabel);
    }];
    
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.codeLabel);
        make.left.equalTo(weakSelf.codeLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf).with.offset(-8);
        make.height.equalTo(weakSelf.codeLabel);
//        make.height.equalTo()
    }];
    
    [self.passWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.passWordLabel);
        make.left.equalTo(weakSelf.passWordLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf).with.offset(-8);
        make.height.equalTo(weakSelf.passWordLabel);
    }];
    
    
    [self.blueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.passWordLabel.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-24, 25));
    }];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.blueLabel.mas_bottom).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-30);
        make.left.equalTo(weakSelf).with.offset(30);
        make.height.mas_equalTo(@40);
    }];
    
    [super updateConstraints];
}


-(UITextField *)codeTextfield{
//235 235 235
    if (!_codeTextfield) {
        _codeTextfield = [[UITextField alloc]init];
        _codeTextfield.borderStyle = UITextBorderStyleLine;
//        _codeTextfield.secureTextEntry =
        _codeTextfield.font = [UIFont rdSystemFontOfSize:13.0f];
        _codeTextfield.textColor = GRAYCOLOR2;
        _codeTextfield.layer.borderWidth = 1.0;
        
        _codeTextfield.layer.borderColor = GRAYKUANGCOLOR.CGColor;
    }
    return _codeTextfield;
}

-(UITextField *)passWordTextfield{
    
    if (!_passWordTextfield) {
        _passWordTextfield = [[UITextField alloc]init];
        _passWordTextfield.borderStyle = UITextBorderStyleLine;
        _passWordTextfield.font = [UIFont rdSystemFontOfSize:13.0f];
        _passWordTextfield.textColor = GRAYCOLOR2;
        _passWordTextfield.layer.borderWidth = 1.0;
        
        _passWordTextfield.layer.borderColor = GRAYKUANGCOLOR.CGColor;
    }
    return _passWordTextfield;
}
-(UIImageView *)imgView{

    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bang_icon"]];
        
    }
    return _imgView;
}
//头部标题
-(UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = GRAYCOLOR2;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont rdSystemFontOfSize:12.0f];
        _titleLabel.text = @"更换手机号需要重新认证,我们已向12222222发送了一条验证短信,请输入短信验证码";
    }
    return _titleLabel;
}
/*


 */
-(UIButton *)commitButton{

    if (!_commitButton) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_commitButton setBackgroundImage:[UIImage imageNamed:@"b_btn"] forState:UIControlStateNormal];
        [_commitButton setBackgroundImage:[UIImage imageNamed:@"b_btn"] forState:UIControlStateHighlighted];
        [_commitButton setTitle:@"提交验证" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitButton.titleLabel.font = [UIFont rdSystemFontOfSize:18.0f];
        
//        [_commitButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

//-(void)btnClick:(id)sender{
//
////    NSDictionary *
//    [self.viewModel.btnClick sendNext:@1];
//}

-(UILabel *)blueLabel{

    if (!_blueLabel) {
        _blueLabel = [[UILabel alloc]init];
        _blueLabel.textColor = BLUECOLOR;
        _blueLabel.text = @"验证短信已发送，请保持手机信号通畅";
        _blueLabel.textAlignment = NSTextAlignmentLeft;
        _blueLabel.font = [UIFont rdSystemFontOfSize:12.0f];
    }
    return _blueLabel;
}

-(UILabel *)codeLabel{

    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.textColor = [UIColor blackColor];
        _codeLabel.textAlignment = NSTextAlignmentLeft;
        _codeLabel.text = @"验证码";
        _codeLabel.font = [UIFont rdSystemFontOfSize:15.0f];
    }
    return _codeLabel;

}

-(UILabel *)passWordLabel{

    if (!_passWordLabel) {
        _passWordLabel = [[UILabel alloc]init];
        _passWordLabel.textColor = [UIColor blackColor];
        _passWordLabel.textAlignment = NSTextAlignmentLeft;
        _passWordLabel.text = @"登录密码";
        _passWordLabel.font = [UIFont rdSystemFontOfSize:15.0f];
    }
    
    return _passWordLabel;
}



@end
