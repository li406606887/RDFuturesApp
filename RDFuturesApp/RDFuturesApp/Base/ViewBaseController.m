//
//  ViewBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"
#import "BondViewController.h"
#import "LoginViewController.h"
#import "RDProfileViewController.h"
#import "ContactUsViewController.h"
#import "NavigationBaseController.h"
#import "BreedRulesViewController.h"
#import "LastTradingDayViewController.h"
#import "LoginViewController.h"
#import "BankInformationViewController.h"
#import "OpenAccountFirstViewController.h"
#import "ProgressViewController.h"
#import "AboutUsViewController.h"
#import "CompanyNoticeViewController.h"
#import "InfoFeedBackViewController.h"
#import "HelpCenterViewController.h"
#import "BillViewController.h"
#import "BusinessHandlingViewController.h"
#import "MagicBoxViewController.h"



@interface ViewBaseController ()
@property(nonatomic,weak) UIButton *leftItemBtn;
@end

@implementation ViewBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationBar];
    
    self.view.backgroundColor= DEFAULT_BG_COLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)setTitle:(NSString *)title {
    [self.leftItemBtn setTitle:title forState:UIControlStateNormal];
}
//是否旋转
-(BOOL)shouldAutorotate{
    return NO;
}
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void) setUpNavigationBar {
    [self.navigationController.navigationBar setBarTintColor:RGB(255, 165, 33)];//设置导航栏的背景颜色
    //    self.navigationController.navigationBar.alpha = 0;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationItem.leftBarButtonItem = [self leftButton];//设置导航栏左边按钮
    self.navigationItem.rightBarButtonItem = [self rightButton];//设置导航栏右边按钮
    
    self.navigationItem.titleView = [self centerView];//设置titel
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (UIBarButtonItem *)leftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [btn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.leftItemBtn = btn;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (UIBarButtonItem *)rightButton {
    return nil;
}

- (UIView *)centerView {
    return [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_navigation_image"]];
}

- (void)actionOnTouchBackButton:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideTabbar:(BOOL)hidden {
    self.tabBarController.tabBar.hidden = hidden;//隐藏导航栏
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    ViewBaseController *vc = [super allocWithZone:zone];
    @weakify(vc);
    [[vc rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(vc)
        [vc addChildView];
        [vc bindViewModel];
    }];
    
    [[vc rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(vc)
        [vc layoutNavigation];
        [vc getNewData];
    }];
    
    return vc;
}




-(void)addChildView{
    
}
-(void)bindViewModel{
    
}
-(void)getNewData{
    
}
-(void)layoutNavigation{
    
}
+(CGSize)textForFont:(int)font andMAXSize:(CGSize)size andText:(NSString*)text
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    
    return rect.size;
}
-(void)pushMagicBox{
    
    MagicBoxViewController * MVC = [[MagicBoxViewController alloc]init];
    [self.navigationController pushViewController:MVC animated:YES];

}
-(void)pushBusinessBandling{

    BusinessHandlingViewController * BVC = [[BusinessHandlingViewController alloc]init];
    [self.navigationController pushViewController:BVC animated:YES];
}
-(void)pushBills{

    BillViewController * BVC = [[BillViewController alloc]init];
    [self.navigationController pushViewController:BVC animated:YES];
}
-(void)pushHelpCenter{
    
    HelpCenterViewController * HVC = [[HelpCenterViewController alloc]init];
    [self.navigationController pushViewController:HVC animated:YES];
}
-(void)pushInfoFeedBack{
    
    InfoFeedBackViewController * IVC = [[InfoFeedBackViewController alloc]init];
    [self.navigationController pushViewController:IVC animated:YES];
}
-(void)pushCompanyNotice{

    CompanyNoticeViewController * CVC = [[CompanyNoticeViewController alloc]init];
    [self.navigationController pushViewController:CVC animated:YES];
}
-(void)pushProgress{
    
    ProgressViewController * PVC = [[ProgressViewController alloc]init];
    [self.navigationController pushViewController:PVC animated:YES];
}
-(void)puchContactUs{
        ContactUsViewController *contactUs = [[ContactUsViewController alloc] init];
        [self.navigationController pushViewController:contactUs animated:YES];
//    AboutUsViewController * AVC = [[AboutUsViewController alloc]init];
//    [self.navigationController pushViewController:AVC animated:YES];
}
-(void)puchLastTradingDay{
    LastTradingDayViewController *lastDay = [[LastTradingDayViewController alloc] init];
    [self.navigationController pushViewController:lastDay animated:YES];
}
-(void)puchBond{
    BondViewController *bond = [[BondViewController alloc] init];
    [self.navigationController pushViewController:bond animated:YES];
}
-(void)puchBankInformation{
    BankInformationViewController *bankInfor = [[BankInformationViewController alloc] init];
    [self.navigationController pushViewController:bankInfor animated:YES];
}
-(void)puchBreedRules{
    BreedRulesViewController *breedRules = [[BreedRulesViewController alloc] init];
    [self.navigationController pushViewController:breedRules animated:YES];
}
-(void)puchRDProfile{
    RDProfileViewController *profile = [[RDProfileViewController alloc] init];
    [self.navigationController pushViewController:profile animated:YES];
}
-(void)puchOpenfirst{
    OpenAccountFirstViewController *main = [[OpenAccountFirstViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}

-(void)puchLogin{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    
}

@end
