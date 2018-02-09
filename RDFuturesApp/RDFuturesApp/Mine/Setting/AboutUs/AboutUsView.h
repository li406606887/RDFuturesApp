//
//  AboutUsView.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/26.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseView.h"
#import "AboutUsViewModel.h"
@interface AboutUsView : BaseView

@property (nonatomic, strong) AboutUsViewModel * viewModel;
@property (nonatomic, strong) UIImageView * logoImgView;
@property (nonatomic, strong) UILabel * versionLabel;//版本
@property (nonatomic, strong) UILabel * updateLabel;
@property (nonatomic, strong) UILabel * infoLabel;
@property (nonatomic, strong) UILabel * privacyLabel;//隐私声明label
@property (nonatomic, strong) UILabel * contactLabel;
@property (nonatomic, strong) UILabel * phoneLabel;//号码

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIView *lineView1;

@property (nonatomic,strong) UIView *whiteView;

@end
