//
//  ChangeFirstView.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/4.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseView.h"
#import "ChangeViewModel.h"
@interface ChangeFirstView : BaseView

@property (nonatomic,strong) ChangeViewModel *viewModel;

@property (nonatomic,strong) UIImageView *imgView;//提示图片

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *codeLabel;

@property (nonatomic,strong) UITextField *codeTextfield;

@property (nonatomic,strong) UILabel *passWordLabel;

@property (nonatomic,strong) UITextField *passWordTextfield;

@property (nonatomic,strong) UILabel *blueLabel;

@property (nonatomic,strong) UIButton *commitButton;




@end
