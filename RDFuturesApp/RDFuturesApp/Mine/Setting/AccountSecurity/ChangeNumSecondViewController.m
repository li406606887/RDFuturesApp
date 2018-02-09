//
//  ChangeNumSecondViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ChangeNumSecondViewController.h"
#import "ChangeSecondView.h"
#import "ChangeSecondViewModel.h"
@interface ChangeNumSecondViewController ()
@property(nonatomic,strong) ChangeSecondViewModel * viewModel;
@property(nonatomic,strong) ChangeSecondView * secondView;
@property (assign, nonatomic) int count;
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation ChangeNumSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"更换手机号";
    
    [self.view addSubview:self.secondView];
    
}

-(void)bindViewModel {
    @weakify(self);
    //texfield值变化
    RAC(self.viewModel,codeStr) = self.secondView.codeTextField.rac_textSignal;
    RAC(self.viewModel,phoneNumber) = self.secondView.phoneTextField.rac_textSignal;
    
    self.secondView.commitBtn.rac_command = self.viewModel.commitCommand;
    
    RAC(self.secondView.commitBtn,tintColor)= [self.viewModel.commitBtnEnable map:^id(id value) {
        return [value boolValue] ? [UIColor whiteColor] : GRAYCOLOR;
    }];
    
    [self.viewModel.commitBtnEnable subscribeNext:^(NSNumber *value) {
        @strongify(self);
        self.secondView.commitBtn.enabled = [value boolValue];
    }];
    //提交请求完的信号
    [[self.viewModel.commitCommand executionSignals] subscribeNext:^(id x) {
         [x subscribeNext:^(NSString * x) {
            @strongify(self);
            if ([x isEqualToString:@"1"]) {
                showMassage(@"更改成功")
                [self saveNewPhone];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
         }];
    }];
    //只让codeTextfield输入6位
    [self.secondView.codeTextField.rac_textSignal subscribeNext:^(NSString * x) {
        static NSInteger const maxLength = 6;
        if (x.length) {
            if (x.length>6) {
                @strongify(self);
                self.secondView.codeTextField.text = [self.secondView.codeTextField.text substringToIndex:maxLength];
            }
        }
    }];
    //获取验证码点击信号
    [[self.viewModel.codeClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self getCodeBtnClick];
    }];
    
}
-(void)saveNewPhone {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.secondView.phoneTextField.text forKey:@"phoneNumber"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - 获取验证码
- (void)getCodeBtnClick {
    if (![NSString isMobileNumber:self.secondView.phoneTextField.text]) {
        showMassage(@"手机号格式有误")
        return;
    }
    if (self.count != 0) return;

    loading(@"")
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.secondView.phoneTextField.text forKey:@"phone"];
    [dic setObject:@"2" forKey:@"check_type"];//1 验证类型（1：需要判断账号是否存在如：找回密码 2：不需要如：注册 3：无所谓
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        RDRequestModel *model = [RDRequest postSendValidateCodeWithParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if ([model.State isEqualToString:@"1"]) {
                showMassage(model.Message);
                self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(buttonLoadSecond) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
                //开始循环
                [self.timer fire];
            }else if([model.State isEqualToString:@"2"]){
                showMassage(model.Message);
            }else{
                showMassage(@"请求失败");
            }
            
        });
    });
}

-(void)buttonLoadSecond {
    self.count++;
    if (60-self.count>0) {
        [self.secondView.sendCodeLabel setText:[NSString stringWithFormat:@"%d秒",60-self.count]];
        [self.secondView.sendCodeLabel setUserInteractionEnabled:NO];
    }else{
        [self.timer invalidate];
        self.timer = nil;
        self.count = 0;
        [self.secondView.sendCodeLabel setText:@"获取验证码"];
        [self.secondView.sendCodeLabel setUserInteractionEnabled:YES];
    }
}

-(void)updateViewConstraints {
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

-(ChangeSecondView *)secondView {
    if (!_secondView) {
        _secondView = [[ChangeSecondView alloc]initWithViewModel:self.viewModel];
        _secondView.backgroundColor = [UIColor whiteColor];
    }
    return _secondView;
}
-(ChangeSecondViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ChangeSecondViewModel alloc]init];
        
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
