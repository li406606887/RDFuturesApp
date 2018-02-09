//
//  OpenAccountFirstViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/2.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "OpenAccountFirstViewController.h"
#import "LoginViewController.h"
#import "OtherInforViewController.h"
#import "IdPhotoViewController.h"
#import "BankCardInfoViewController.h"
#import "ContactInfoViewController.h"
#import "FinanceInfoViewController.h"
#import "ExperienceViewController.h"
#import "WitnessCityViewController.h"
#import "CommitInfoViewController.h"
#import "ProgressViewController.h"
#import "OpenAccountViewController.h"

#import "ChooseIDViewController.h"
#import "DerivativeViewController.h"

@interface OpenAccountFirstViewController ()
@property(nonatomic,strong)NSArray *arrayControllers;
@property(nonatomic,strong)NSMutableArray *stateControllers;


@property(nonatomic,assign)int step;
@end

@implementation OpenAccountFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"开户";
    [self getStepStatus];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - 下一步
- (IBAction)nextClick:(id)sender {
    
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [defult objectForKey:@"user_id"];
    NSString * isFinishAccount =[[NSUserDefaults standardUserDefaults] objectForKey:@"isFinishAccount"];
    
    if (![isFinishAccount isEqualToString:@"8"]) {
        
    }else{
        showMassage(@"您的账号已完成开户")
        return;
    }
    
    if (user_id!=nil) {
        if (self.step==11) {
            ProgressViewController *fifteenth = [[ProgressViewController alloc] init];
            fifteenth.loadType = @"1";
            [self.navigationController pushViewController:fifteenth animated:YES];

        }else{
            if (self.step == 0 || self.step == 1) {
                
                OpenAccountViewController *openAccount = [[OpenAccountViewController alloc] init];
                [self.navigationController pushViewController:openAccount animated:YES];
                
            }else{
                for (int i = 0; i <self.step-1; i++) {
                    [self.navigationController pushViewController:self.arrayControllers[i] animated:NO];
                }
            }
        }
    }else{
        
        [self puchLogin];
    }
    
}
//-(UIBarButtonItem *)leftButton{
//    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [btn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];//设置左边按钮的图片
//    [btn addTarget:self action:@selector(dissMissViewController) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
//    return [[UIBarButtonItem alloc] initWithCustomView:btn];;
//}

#pragma mark - 去登录
- (IBAction)goLoginClick:(id)sender {
    LoginViewController * LVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:LVC animated:YES];
}
-(void)dissMissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getStepStatus{
    
    loading(@"");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        RDRequestModel * model = [RDRequest getWithApi:@"/api/account/getStepStatus.api" andParam:nil error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if ([model.State isEqualToString:@"1"]) {
                self.step = [[NSString stringWithFormat:@"%@",[model.Data objectForKey:@"step_num"]] intValue];
                //("1":"开户文件","2":"身份信息","3":"银行卡验证","4":"联系信息","5":"财务信息","6":"投资经验","7":"衍生产品认知","8":"其他资料","9":"见证信息","10":"提交信息","11":"完成")
                for (int i = 0; i<self.step; i++) {
                       self.stateControllers[i] = @"1";
                }
            }
            
        });
        
    });
    
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(NSArray *)arrayControllers{
    if (!_arrayControllers) {
        OpenAccountViewController * first = [[OpenAccountViewController alloc]init];
        first.loadType = self.stateControllers[0];
        ChooseIDViewController * second = [[ChooseIDViewController alloc]init];
        second.loadType = self.stateControllers[1];
        BankCardInfoViewController *third = [[BankCardInfoViewController alloc] init];
        third.loadType = self.stateControllers[2];
        ContactInfoViewController * fouth = [[ContactInfoViewController alloc]init];
        fouth.loadType = self.stateControllers[3];
        FinanceInfoViewController *fifth = [[FinanceInfoViewController alloc] init];
        fifth.loadType = self.stateControllers[4];
        ExperienceViewController *sixth = [[ExperienceViewController alloc] init];
        sixth.loadType = self.stateControllers[5];
        DerivativeViewController * Seventh = [[DerivativeViewController alloc]init];
        Seventh.loadType = self.stateControllers[6];
        OtherInforViewController * Eighth = [[OtherInforViewController alloc]init];
        Eighth.loadType = self.stateControllers[7];
        WitnessCityViewController *ninth = [[WitnessCityViewController alloc] init];
        ninth.loadType = self.stateControllers[8];
        CommitInfoViewController *tenth = [[CommitInfoViewController alloc] init];
        tenth.loadType = self.stateControllers[9];
        
        _arrayControllers = [NSArray arrayWithObjects:first,second, third, fouth,fifth,sixth,Seventh,Eighth,ninth,tenth,nil];
        
        

    }
    return _arrayControllers;
}
-(NSMutableArray *)stateControllers{
    if (!_stateControllers) {
        _stateControllers = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    }
    return _stateControllers;
}
@end
