//
//  ChangePhoneNumViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/26.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ChangePhoneNumViewController.h"
#import "ChangeViewModel.h"
#import "ChangeFirstView.h"
#import "ChangeNumSecondViewController.h"

@interface ChangePhoneNumViewController ()

@property(nonatomic,strong) ChangeViewModel * viewModel;
@property(nonatomic,strong) ChangeFirstView * firstView;

@end

@implementation ChangePhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更换手机号";
    
    [self.view addSubview:self.firstView];
    
    NSString * str = [NSString stringWithFormat:@"更换手机号需要重新认证,我们已向%@发送了一条验证短信,请输入短信验证码",self.phoneNum];
    self.firstView.titleLabel.text = str;
}

-(void)bindViewModel{

    
    @weakify(self);

    RAC(self.viewModel,codeStr) = self.firstView.codeTextfield.rac_textSignal;
    RAC(self.viewModel,passwordStr) = self.firstView.passWordTextfield.rac_textSignal;
    
//    RAC(self.viewModel, phoneNumber) = self.firstView.passWordLabel.rac_
    
    self.firstView.commitButton.rac_command = self.viewModel.commitCommand;
    
    RAC(self.firstView.commitButton,tintColor)= [self.viewModel.commitBtnEnable map:^id(id value) {
        return [value boolValue] ? [UIColor whiteColor] : GRAYCOLOR;
    }];
    
    [self.viewModel.commitBtnEnable subscribeNext:^(NSNumber *  value) {
        @strongify(self);
        self.firstView.commitButton.enabled = [value boolValue];
    }];
    
    [[self.viewModel.commitCommand executionSignals] subscribeNext:^(id x) {
       
        [x subscribeNext:^(id x) {
            @strongify(self);

//            NSLog(@"提交成功x=%@,去下一页",x);
            ChangeNumSecondViewController * CVC = [[ChangeNumSecondViewController alloc]init];
            [self.navigationController pushViewController:CVC animated:YES];
            
        }];
    }];
    
    [self.firstView.codeTextfield.rac_textSignal subscribeNext:^(NSString * x) {
        
        static NSInteger const maxLength = 6;
        if (x.length) {
            if (x.length>6) {
                @strongify(self);
                self.firstView.codeTextfield.text = [self.firstView.codeTextfield.text substringToIndex:maxLength];
            }
        }
        
    }];
    
    
    [self.firstView.passWordTextfield.rac_textSignal subscribeNext:^(NSString * x) {
       
        static NSInteger const maxLength = 20;
        if (x.length) {
            if (x.length > 20) {
                @strongify(self);
                self.firstView.passWordTextfield.text = [self.firstView.passWordTextfield.text substringToIndex:maxLength];
            }
        }
    }];
    
}
-(void)updateViewConstraints{

    WS(weakself)
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

-(ChangeFirstView *)firstView{

    if (!_firstView) {
        _firstView = [[ChangeFirstView alloc]initWithViewModel:self.viewModel];
        _firstView.backgroundColor = [UIColor whiteColor];
    }
    return _firstView;
}

-(ChangeViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[ChangeViewModel alloc]init];
        
    }
    return _viewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
