//
//  ChangeSecondView.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseView.h"
#import "ChangeSecondViewModel.h"

@interface ChangeSecondView : BaseView


@property (nonatomic,strong) ChangeSecondViewModel *viewModel;

@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *areaLabel;//所属地区

@property (nonatomic,strong) UILabel *phoneLabel;

@property (nonatomic,strong) UILabel *codeLabel;

@property (nonatomic,strong) UIButton *areaButton;//选择地区button

@property (nonatomic,strong) UITextField *phoneTextField;//

@property (nonatomic,strong) UILabel *sendCodeLabel;//发送验证码btn

@property (nonatomic,strong) UITextField *codeTextField;

@property (nonatomic,strong) UIButton *commitBtn;//提交按钮

@end
