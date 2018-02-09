//
//  AboutUsView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/26.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AboutUsView.h"

@implementation AboutUsView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    
    self.viewModel = (AboutUsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
    
}
-(void)layoutSubviews{
    
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    [self addSubview:self.logoImgView];
    [self addSubview:self.versionLabel];
    [self addSubview:self.whiteView];
    
    [self addSubview:self.updateLabel];
    [self addSubview:self.infoLabel];
    [self addSubview:self.privacyLabel];
    [self addSubview:self.contactLabel];
    [self addSubview:self.phoneLabel];
    
    [self addSubview:self.lineView];
    [self addSubview:self.lineView1];
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
    
}

-(void)updateConstraints{
    WS(weakself)
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(40);
        make.size.mas_offset(CGSizeMake(120, 120));
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.logoImgView);
        make.top.equalTo(weakSelf.logoImgView.mas_bottom).with.offset(8);
        make.size.mas_offset(CGSizeMake(250, 20));
    }];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf.logoImgView);
        make.top.equalTo(weakSelf.versionLabel.mas_bottom).with.offset(15);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 125));
    }];
    
    [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.whiteView).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(8);
        make.size.mas_offset(CGSizeMake(100, 20));
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.updateLabel);
        make.right.left.equalTo(weakSelf);
        make.height.equalTo(@30);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.updateLabel.mas_bottom).with.offset(10);
        make.centerX.equalTo(weakSelf.logoImgView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,1));
        
    }];
    
    [self.privacyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-16, 20));
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.privacyLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,1));
        make.centerX.equalTo(weakSelf.logoImgView);
    }];
    
    [self.contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.lineView1.mas_bottom).with.offset(12);
        make.left.equalTo(weakSelf).with.offset(8);
        make.size.mas_equalTo(weakSelf.updateLabel);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.lineView1.mas_bottom).with.offset(10);
        make.right.equalTo(weakSelf).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [super updateConstraints];
}

-(UIView *)whiteView{

    if (!_whiteView) {
        _whiteView = [[UIView alloc]init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

-(UIView *)lineView{

    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = LIGHTGRAYCOLOR;
    }

    return _lineView;
}
-(UIView *)lineView1{
    
    if (!_lineView1) {
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = LIGHTGRAYCOLOR;
    }
    return _lineView1;
}
-(UIImageView *)logoImgView
{
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc]init];
        _logoImgView.image = [UIImage imageNamed:@"new_logo"];
        _logoImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _logoImgView;
}

-(UILabel *)versionLabel{

    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc]init];
        _versionLabel.textColor = GRAYCOLOR;
        _versionLabel.font = [UIFont rdSystemFontOfSize:20.0f];
        _versionLabel.text = @"瑞达国际 V1.0.0";
        _versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLabel;
}

-(UILabel *)updateLabel{

    if (!_updateLabel) {
        _updateLabel = [[UILabel alloc]init];
        _updateLabel.textAlignment = NSTextAlignmentLeft;
        _updateLabel.text = @"版本更新";
        _updateLabel.textColor = [UIColor blackColor];
        _updateLabel.font = [UIFont rdSystemFontOfSize:15.0f];
        _updateLabel.backgroundColor = [UIColor whiteColor];
        
    }
    return _updateLabel;
}

-(UILabel *)infoLabel{

    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.textAlignment = NSTextAlignmentRight;
        _infoLabel.font = [UIFont rdSystemFontOfSize:15.0f];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.userInteractionEnabled = YES;
    }
    return _infoLabel;
}

-(UILabel *)privacyLabel{
    
    if (!_privacyLabel) {
        
        _privacyLabel = [[UILabel alloc]init];
        _privacyLabel.textAlignment = NSTextAlignmentLeft;
        _privacyLabel.text = @"免责及隐私声明";
        _privacyLabel.textColor = [UIColor blackColor];
        _privacyLabel.font = [UIFont rdSystemFontOfSize:15.0f];
        _privacyLabel.userInteractionEnabled = YES;
        _privacyLabel.tag = 1;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            
            NSString * str = [NSString stringWithFormat:@"%d",(int)tap.view.tag];
            [self.viewModel.labelClick sendNext:str];
        }];
        [_privacyLabel addGestureRecognizer:tap];
    }
    return _privacyLabel;
    
}

-(UILabel *)contactLabel{
    
    if (!_contactLabel) {
        _contactLabel = [[UILabel alloc]init];
        _contactLabel.text = @"联系我们";
        _contactLabel.textAlignment = NSTextAlignmentLeft;
        _contactLabel.textColor = [UIColor blackColor];
        _contactLabel.font = [UIFont rdSystemFontOfSize:15.0f];
    }
    return _contactLabel;
}

-(UILabel *)phoneLabel{

    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text = @"00852 2534 2000";
        _phoneLabel.textColor = BLUECOLOR;
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        _phoneLabel.font = [UIFont rdSystemFontOfSize:15.0f];
        _phoneLabel.userInteractionEnabled = YES;
        _phoneLabel.tag = 2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            
            NSString * str = [NSString stringWithFormat:@"%d",(int)tap.view.tag];
            [self.viewModel.labelClick sendNext:str];
        }];
        [_phoneLabel addGestureRecognizer:tap];
    }
    return _phoneLabel;
}

@end
