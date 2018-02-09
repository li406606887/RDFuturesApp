//
//  ForgetSecondViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ForgetSecondViewController.h"
#import "NewPassWordViewController.h"

@interface ForgetSecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSTimer *codeTimer;
@property (assign) int codeTimerCount;
@end

@implementation ForgetSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"密码找回";
    self.topLabel.text = [NSString stringWithFormat:@"短信验证码已发送至%@",self.phoneStr];
    [self codeTimerStart];
    
}

- (void)codeTimerStart
{
    if (self.codeTimer) {
        return;
    }
    
    self.codeTimerCount = 60;
    _timeLabel.userInteractionEnabled = NO;
    _timeLabel.text = [NSString stringWithFormat:@"%d秒后可重新获取验证码",self.codeTimerCount--];

    self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(codeTimerDo) userInfo:nil repeats:YES];
}
- (void)codeTimerDo
{
    if (self.codeTimerCount >= 0) {
       _timeLabel.text = [NSString stringWithFormat:@"%d秒后可重新获取验证码",self.codeTimerCount--];
    } else {
        [self codeTimerStop];
    }
}
- (void)codeTimerStop
{
    if (self.codeTimer) {
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        
        _timeLabel.text = [NSString stringWithFormat:@"重新发送验证码"];
        
        _timeLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(againSendCode)];
        [_timeLabel addGestureRecognizer:tap];
    }
}
//再次发送
-(void)againSendCode{

    WS(weakself)
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.phoneStr forKey:@"phone"];
    [dic setObject:@"1" forKey:@"check_type"];//1 验证类型（1：找回密码 2：注册 3：开户）
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel *model = [RDRequest postSendValidateCodeWithParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error==nil) {
                showMassage(model.Message);
                if ([model.Message isEqualToString:@"成功"]) {
                    
                    [weakSelf codeTimerStart];
                }
                
            }
            
        });
    });

}
//提交验证码
- (IBAction)commitBtnClick:(id)sender {
    
    if (self.codeTextField.text.length < 6) {
        
        showMassage(@"格式错误")
        return;
    }
    
    
    //验证验证码
    /*
     ###4、验证码验证
     
     /api/user/checkCode.api
    
    
    1、phone					手机号
    2、validate_code			验证码
     */
    loading(@"")
    WS(weakself)
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.phoneStr forKey:@"phone"];
    [dic setObject:self.codeTextField.text forKey:@"validate_code"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel *model = [RDRequest postCheckValidateCodeWithParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD
            if (error==nil) {
                if ([model.State isEqualToString:@"1"]) {
                    
                    NewPassWordViewController * NVC = [[NewPassWordViewController alloc]init];
                    
                    NVC.phoneStr = self.phoneStr;
                    NVC.codeStr = self.codeTextField.text;
                    [weakSelf.navigationController pushViewController:NVC animated:YES];
                    
                }else{
                    showMassage(model.Message);
                }
                
            }else{
                [MBProgressHUD showError:promptString];
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
