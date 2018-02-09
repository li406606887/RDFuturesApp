//
//  AutographViewController.m
//  RDFuturesApp
//
//  Created by user on 17/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AutographViewController.h"
#import "PPSSignatureView.h"


#define kAutographHeight (SCREEN_WIDTH-30)*1.15
#define kButtonWidth  (SCREEN_WIDTH-65)*0.5

@interface AutographViewController ()
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)PPSSignatureView *autographView;
@property(nonatomic,strong)UIButton *eliminate;//清除按钮
@property(nonatomic,strong)UIButton *nextStep;//下一步
@property(nonatomic,strong)UIImageView *nextStepBg;//下一步
@property(nonatomic,strong)UIButton *dissButton;//关闭按钮
@end

@implementation AutographViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"签名"];
   
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.autographView];
    [self.view addSubview:self.eliminate];
    [self.view addSubview:self.nextStepBg];
    [self.view addSubview:self.nextStep];
    [self.view addSubview:self.dissButton];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate

{
    
    return NO;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations

{
    
    return UIInterfaceOrientationMaskLandscape;
    
}


-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}
-(void)bindViewModel{
    
}

-(void)eraseView{
    [self.autographView erase];
}
-(void)nextStepClick{
    WS(weakself)
    NSData* imgData = UIImageJPEGRepresentation(self.autographView.signatureImage, 1.0f);
    
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *imageString = [NSString stringWithFormat:@"data:image/jpg;base64,%@",encodedImageStr];

    NSMutableDictionary *paramData = [[NSMutableDictionary alloc] init];
    [paramData setObject:self.model.accountAccessId forKey:@"accountAccessId"];
    [paramData setObject:imageString forKey:@"signatureImage"];
    loading(@"正在上传签名");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        RDRequestModel * model = [RDRequest postDepositSignatureWithParam:paramData
                                                                error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                if ([model.State isEqualToString:@"1"]) {
                    [weakSelf dismissViewControllerAnimated:NO completion:^{
                        if (weakSelf.AutographBlock){
                            weakSelf.AutographBlock(YES);
                        }
                    }];
                }else{
                    showMassage(model.Message)
                }
            }else{
                [MBProgressHUD showError:promptString];
            }
           
        });
    });

    
}
-(void)dissmissViewController{
    [self dismissViewControllerAnimated:NO completion:nil];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(PPSSignatureView *)autographView{
    if (!_autographView) {
        _autographView = [[PPSSignatureView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [_autographView commonInit];
        [_autographView setBackgroundColor:[UIColor clearColor]];
        
    }
    return _autographView;
}
-(UIButton *)eliminate{
    if (!_eliminate) {
        _eliminate = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eliminate setTitle:@"重签" forState:UIControlStateNormal];
        [_eliminate setFrame:CGRectMake(15, getTop(self.autographView)+10, kButtonWidth, 40)];
        [_eliminate addTarget:self action:@selector(eraseView) forControlEvents:UIControlEventTouchUpInside];
        _eliminate.layer.borderColor = [RGB(40, 146, 255) CGColor];
        _eliminate.layer.borderWidth = 0.5f;
        _eliminate.layer.masksToBounds = YES;
        _eliminate.layer.cornerRadius =3;
        [_eliminate setTitleColor:RGB(40, 146, 255) forState:UIControlStateNormal];
    }
    return _eliminate;
}
-(UIButton *)nextStep{
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextStep setTitle:@"完成" forState:UIControlStateNormal];
        [_nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStep setFrame:CGRectMake(getLeft(self.eliminate)+35, getTop(self.autographView)+10, kButtonWidth, 40)];
        [_nextStep addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
        _nextStep.layer.masksToBounds = YES;
        _nextStep.layer.cornerRadius =3;
    }
    return _nextStep;
}
-(UIImageView *)nextStepBg{
    if (!_nextStepBg) {
        _nextStepBg = [[UIImageView alloc] initWithFrame:CGRectMake(getLeft(self.eliminate)+35, getTop(self.autographView)+10, kButtonWidth, 40)];
        [_nextStepBg setImage:[UIImage imageNamed:@"b_btn"]];
    }
    return _nextStepBg;
}
-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.5-150, 10, 300, 30)];
        label.text = [NSString stringWithFormat:@"请在此空白区域签写您的姓名:%@",self.model.chinese_name];
        label.font = [UIFont rdSystemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [_titleView addSubview:label];
        [_titleView setBackgroundColor:[UIColor whiteColor]];
    }
    return _titleView;
}
-(UIButton *)dissButton{
    if (!_dissButton) {
        _dissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dissButton setTitle:@"x" forState:UIControlStateNormal];
        [_dissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dissButton.titleLabel setFont:[UIFont rdSystemFontOfSize:20]];
        [_dissButton setFrame:CGRectMake(10, 0, 30, 40)];
        [_dissButton addTarget:self action:@selector(dissmissViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dissButton;
}
@end
