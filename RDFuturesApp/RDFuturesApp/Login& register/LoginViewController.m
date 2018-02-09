//
//  LoginViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/1.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "LoginViewController.h"
#import "RDRequest+Login_register.h"
#import "ForgetPassWordViewController.h"
#import "RegisterViewController.h"
#import "JPUSHService.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextfield;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    
    self.title = @"登录";

}

-(UIBarButtonItem *)rightButton{
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    btn.imageEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 5);
    [btn.titleLabel setFont:[UIFont rdSystemFontOfSize:16]];
//    [btn setImage:[UIImage imageNamed:@"icon_navigationbar_message"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(puchRegister) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
-(void)puchRegister{
    RegisterViewController * RVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RVC animated:YES];
    
}
#pragma mark - 登录
- (IBAction)LoginBtnClick:(id)sender{
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
    }];
    
    if (![NSString isMobileNumber:self.phoneNumTextfield.text]) {
        showMassage(@"手机号格式有误")
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:self.phoneNumTextfield.text forKey:@"phone"];
    [dic setObject:self.passWordTextfield.text forKey:@"password"];
    
    NSString *registrationID = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"registrationID"]];
    [dic setObject:registrationID forKey:@"pushToken"];
    loading(@"登录中");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        RDRequestModel *model = [RDRequest postLoginWithParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            [MBProgressHUD hideHUDForView:nil];
            if (error==nil) {
                if ([model.State isEqualToString:@"1"]) {
                    NSString *userid = [NSString stringWithFormat:@"%@",[model.Data objectForKey:@"user_id"]];
                    NSString *token =[NSString stringWithFormat:@"%@",[model.Data objectForKey:@"token"]];
                    [[NSUserDefaults standardUserDefaults] setObject:[model.Data objectForKey:@"gesturesStatus"] forKey:@"gesturesStatus"];
                    [[NSUserDefaults standardUserDefaults] setObject:[model.Data objectForKey:@"gesturesPwd"] forKey:@"gesturesPwd"];
                    NSLog(@"1-2-3");
                    [[RDUserInformation getInformation] PostUserInformationDataWithUserId:userid andtoken:token andPhoneNumber:self.phoneNumTextfield.text];
                    if (self.isFinishFixPassWord) {
                        MineViewController * MVC = [[MineViewController alloc]init];
                        UIViewController *target = nil;
                        for (UIViewController * controller in self.navigationController.viewControllers) { //遍历
                            if ([controller isKindOfClass:[MVC class]]) { //这里判断是否为你想要跳转的页面
                                target = controller;
                            }
                        }
                        if (target){
                            [self.navigationController popToViewController:target animated:YES]; //跳转
                        }
                    }else [self.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    showMassage(model.Message);
                }
            }else{
                [MBProgressHUD showError:promptString];
            }
        });
    });
}
-(UIBarButtonItem *)leftButton{
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [btn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];//设置左边按钮的图片
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [btn addTarget:self action:@selector(exitBack) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];

}
-(void)exitBack{
     [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 忘记密码
- (IBAction)forgetPassWordBtnClick:(id)sender {
    
    
    ForgetPassWordViewController * FVC = [[ForgetPassWordViewController alloc]init];
    
    [self.navigationController pushViewController:FVC animated:YES];
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
