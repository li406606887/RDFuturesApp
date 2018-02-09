//
//  RegisterViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/1.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RegisterViewController.h"
#import "RDRequest+Login_register.h"
#import "SelectAreaViewController.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextfield;
@property (weak, nonatomic) IBOutlet UITextField *phoneCoderTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *verificationCode;
@property (weak, nonatomic) IBOutlet UILabel *verificationCodeLabel;

@property (weak, nonatomic) IBOutlet UILabel *areaLabel;//区号
@property (strong, nonatomic)NSString * areaNumStr;
@property (assign, nonatomic) int count;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"注册";
    
    _areaLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushSelectArea)];
    [self.areaLabel addGestureRecognizer:tap];
    _areaNumStr = @"86";
}
-(void)pushSelectArea{

    SelectAreaViewController * SVC = [[SelectAreaViewController alloc]init];
    SVC.backblock = ^(NSString * areStr,NSString * numStr){
    
        _areaLabel.text = [NSString stringWithFormat:@"%@ %@",areStr,numStr];
        _areaNumStr = [numStr substringFromIndex:1];//
    };
    [self.navigationController pushViewController:SVC animated:YES];

}
#pragma mark - 获取验证码
- (IBAction)getCoderBtnClick:(id)sender {
    if (![NSString isMobileNumber:self.phoneNumTextfield.text]) {
        showMassage(@"手机号格式有误")
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.phoneNumTextfield.text forKey:@"phone"];
    [dic setObject:@"2" forKey:@"check_type"];//1 验证类型
    loading(@"");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        RDRequestModel *model = [RDRequest postSendValidateCodeWithParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            [MBProgressHUD hideHUDForView:nil];

            if (error==nil) {
                if ([model.State intValue]==1) {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(buttonLoadSecond) userInfo:nil repeats:YES];
                    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
                    //开始循环
                    [self.timer fire];
                }
                showMassage(model.Message);
            }
        });
    });
}
-(void)buttonLoadSecond{
    
    self.count++;
    if (60-self.count>0) {
        [self.verificationCodeLabel setText:[NSString stringWithFormat:@"%dS",60-self.count]];
        [self.verificationCode setUserInteractionEnabled:NO];
    }else{
        [self.timer invalidate];
        self.timer= nil;
        self.count = 0;
        [self.verificationCodeLabel setText:@"获取验证码"];
        [self.verificationCode setUserInteractionEnabled:YES];
    }
    
}
#pragma mark - 注册
- (IBAction)registerBtnClick:(id)sender {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.phoneNumTextfield.text forKey:@"phone"];
    [dic setObject:self.passWordTextfield.text forKey:@"password"];
    [dic setObject:self.phoneCoderTextfield.text forKey:@"validate_code"];
    [dic setObject:self.areaNumStr forKey:@"area_code"];

    loading(@"注册中");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel *model = [RDRequest postRegisterWithParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                if ([model.State isEqualToString:@"1"]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                showMassage(model.Message);

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
