

//
//  SaveCompletedViewController.m
//  RDFuturesApp
//
//  Created by user on 17/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "SaveCompletedViewController.h"

@interface SaveCompletedViewController ()
@property(nonatomic,strong)UIImageView *completedLogo;
@property(nonatomic,strong)UILabel *completedLabel;
@property(nonatomic,strong)UIButton *completedButton;
@property(nonatomic,strong)UIImageView *completedButtonBg;
@end

@implementation SaveCompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"完成"];
    [self.view addSubview:self.completedLabel];
    [self.view addSubview:self.completedLogo];
    [self.view addSubview:self.completedButtonBg];
    [self.view addSubview:self.completedButton];
    
    [self updateViewConstraints];
}

-(void)updateViewConstraints{
WS(weakself)
    [self.completedLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(97);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_offset(CGSizeMake(87, 87));
    }];
    
    [self.completedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.completedLogo.mas_bottom).with.offset(35);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 15));
    }];
    
    [self.completedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.completedLabel.mas_bottom).with.offset(50);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
    }];
    
    [self.completedButtonBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.completedLabel.mas_bottom).with.offset(50);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
    }];
    
    
    [super updateViewConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)completedClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UIButton *)completedButton{
    if (!_completedButton) {
        _completedButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_completedButton setTitle:@"完成" forState:UIControlStateNormal];
        [_completedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_completedButton addTarget:self action:@selector(completedClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completedButton;
}

-(UIImageView *)completedButtonBg{
    if (!_completedButtonBg) {
        _completedButtonBg = [[UIImageView alloc] init];
        [_completedButtonBg setImage:[UIImage imageNamed:@"b_btn"]];
    }
    return _completedButtonBg;
}
-(UIImageView *)completedLogo{
    if (!_completedLogo) {
        _completedLogo = [[UIImageView alloc] init];
        [_completedLogo setImage:[UIImage imageNamed:@"Deposit_completed"]];
        
    }
    return _completedLogo;
}
-(UILabel *)completedLabel{
    if (!_completedLabel) {
        _completedLabel = [[UILabel alloc] init];
        [_completedLabel setTextAlignment:NSTextAlignmentCenter];
        if (self.prompt==promptTypeWitdrawFunds) {
            _completedLabel.text = @"提款申请已提交，请耐心等待";
        }else if (self.prompt==promptTypeApiService){
            _completedLabel.text = @"API申请已提交，请在尽快提交认证副本";
            self.title = @"API服务申请";
        }else _completedLabel.text = @"存款申请已提交，请在尽快完成存款转入";
        
    }
    return _completedLabel;
}
@end
