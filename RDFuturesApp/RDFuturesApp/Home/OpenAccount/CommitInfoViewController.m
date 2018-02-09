//
//  CommitInfoViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "CommitInfoViewController.h"
#import "ProgressViewController.h"
#import "RDRequest+Login_register.h"
@interface CommitInfoViewController ()
//@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;//获取验证码按钮
@property (weak, nonatomic) IBOutlet UILabel *getCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextfield;//手机号
@property (weak, nonatomic) IBOutlet UITextField *codeTextfield;//验证码
@property (assign, nonatomic) int count;
@property (weak, nonatomic) NSTimer *timer;
@end

@implementation CommitInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交";
    
    self.getCodeLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getCodeBtnClick)];
    [self.getCodeLabel addGestureRecognizer:tap];
}


#pragma mark - 获取验证码
- (void)getCodeBtnClick{
    if (![NSString isMobileNumber:self.phoneTextfield.text]) {
        showMassage(@"手机号格式有误")
        return;
    }
    loading(@"")
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.phoneTextfield.text forKey:@"phone"];
    [dic setObject:@"3" forKey:@"check_type"];//1 验证类型（1：需要判断账号是否存在如：找回密码 2：不需要如：注册 3：无所谓
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel *model = [RDRequest postSendValidateCodeWithParam:dic error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if ([model.State isEqualToString:@"1"]) {
                showMassage(model.Message);
                NSLog(@"验证码返回=%@",model.Message);
                self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(buttonLoadSecond) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
                //开始循环
                [self.timer fire];
            }else{
                showMassage(@"请求失败");
            }
            
        });
    });
}
-(void)buttonLoadSecond {
    self.count++;
    if (60-self.count>0) {
        [self.getCodeLabel setText:[NSString stringWithFormat:@"%d秒",60-self.count]];
        [self.getCodeLabel setUserInteractionEnabled:NO];
    }else{
        [self.timer invalidate];
        self.timer = nil;
        self.count = 0;
        [self.getCodeLabel setText:@"获取验证码"];
        [self.getCodeLabel setUserInteractionEnabled:YES];
    }
}
#pragma mark - 提交
/*
 ###27、确认并提交信息
 
 /api/account/confirmInfo.api*

请求参数*

1、confirm_phone				确认的手机号码
2、validate_code				验证码
 */
- (IBAction)commitBtnClick:(id)sender {
    if (![NSString isMobileNumber:self.phoneTextfield.text]) {
        showMassage(@"手机号格式有误")
        return;
    }
    if (_codeTextfield.text.length == 0) {
        showMassage(@"验证码未填写");
        return;
    }
 
    loading(@"正在提交数据");
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[NSString stringWithFormat:@"%@",_phoneTextfield.text] forKey:@"confirm_phone"];
    [dic setObject:[NSString stringWithFormat:@"%@",_codeTextfield.text] forKey:@"validate_code"];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        RDRequestModel * model = [RDRequest setWithApi:@"/api/account/confirmAccountInfo.api" andParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                NSLog(@"%@",model.Message);
                
                if ([model.Message isEqualToString:@"成功"]) {
                    //成功
                    ProgressViewController * PVC = [[ProgressViewController alloc]init];
                    [self.navigationController pushViewController:PVC animated:YES];
                }
            }else{
                showMassage(@"请求失败");
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
