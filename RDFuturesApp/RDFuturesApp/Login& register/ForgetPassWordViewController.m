//
//  ForgetPassWordViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ForgetPassWordViewController.h"
#import "ForgetSecondViewController.h"
@interface ForgetPassWordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end

@implementation ForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.;
    self.title = @"密码找回";
    
    
}


- (IBAction)getCodeClick:(id)sender {
    
    if (![NSString isMobileNumber:self.phoneTextField.text]) {
        showMassage(@"手机号格式有误")
        return;
    }
    WS(weakself)
    loading(@"")
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.phoneTextField.text forKey:@"phone"];
    [dic setObject:@"1" forKey:@"check_type"];//1 验证类型（1：找回密码 2：注册 3：开户）
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel *model = [RDRequest postSendValidateCodeWithParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                if ([model.State intValue]==1) {
                    
                    ForgetSecondViewController * FVC = [[ForgetSecondViewController alloc]init];
                    FVC.phoneStr = weakSelf.phoneTextField.text;
                    [weakSelf.navigationController pushViewController:FVC animated:YES];
                    
                }
                
            }
            
        });
    });
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
