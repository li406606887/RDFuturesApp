//
//  NewPassWordViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewPassWordViewController.h"
#import "LoginViewController.h"

@interface NewPassWordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@end

@implementation NewPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码找回";
    
}

- (IBAction)loginBtnClick:(id)sender {
    
//    if ([_codeStr boolValue] || [_phoneStr boolValue]) {
//        return;
//    }
    
    loading(@"正在请求数据");
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];

    [dic setObject:self.phoneStr forKey:@"phone"];
    [dic setObject:self.passwordTextfield.text forKey:@"password"];
    [dic setObject:self.codeStr forKey:@"validate_code"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest getWithApi:@"/api/user/fandPassword.api" andParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                NSLog(@"%@",model.Data);
                
                if ([model.State intValue]==1) {
                    NSDictionary *dic = model.Data;
                   NSString *user_id = [NSString stringWithFormat:@"%@",dic[@"user_id"]];
                   NSString *token = [NSString stringWithFormat:@"%@",dic[@"token"]];
                    [[RDUserInformation getInformation] PostUserInformationDataWithUserId:user_id andtoken:token andPhoneNumber:self.phoneStr];
                    
                    LoginViewController *LVC = [[LoginViewController alloc]init];
                    LVC.isFinishFixPassWord = YES;
                    [weakSelf.navigationController pushViewController:LVC animated:YES];
//                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }
                
            }else{
                [MBProgressHUD showError:@"请求失败"];
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
