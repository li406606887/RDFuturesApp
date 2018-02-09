//
//  HomeViewController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "HomeView.h"
#import "HomeViewModel.h"
#import "HomeScrollView.h"
#import "MessageViewController.h"
#import "DepositFundsViewController.h"
#import "WithdrawFundsViewController.h"
#import "AdvertisementViewController.h"
#import "OnlineServiceViewController.h"
#import "OtherInforViewController.h"
#import "AdvertisementModel.h"
#import "SubscribeViewController.h"
#import "WitnessCityViewController.h"
#import "GuidanceView.h"
#import "NavigationBaseController.h"
#import "ZLGestureLockViewController.h"

@interface HomeViewController ()
{
    
    BOOL isFinishAccount;
}
@property(nonatomic,strong)HomeView *mainView;
@property(nonatomic,strong)HomeViewModel *homeviewModel;
@property (nonatomic,strong)UIButton * messageButton;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadBaiDu];
    
    [self.view addSubview:self.mainView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadingAdvertisementController];
    
    //是否第一次启动
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        //第一次启动
        GuidanceView * Gview = [[GuidanceView alloc]initWithGuidanceOfClick];
        [Gview show];
        Gview.goonBlock = ^(){
            [self loadingAdvertisementController];
        };
    }else{
        [self loadingGesturesViewController];
    }
    


}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[RDUserInformation getInformation] getLoginState]) {
        [self.homeviewModel.refreshMessageStateCommand execute:nil];
        [self.homeviewModel.refreshAnnouncementStateCommand execute:nil];
    }
}

-(void)loadingGesturesViewController {
    if ([[RDUserInformation getInformation].gesturesStatus intValue]==1) {
        ZLGestureLockViewController *viewController = [[ZLGestureLockViewController alloc] initWithUnlockType:ZLUnlockTypeValidatePsw];
        NavigationBaseController *base = [[NavigationBaseController alloc] initWithRootViewController:viewController];
        [self presentViewController:base animated:NO completion:^{
            [self loadingAdvertisementController];
        }];
    }else{
        [self loadingAdvertisementController];
    }
}

-(void)loadingAdvertisementController{
    WS(weakself)
     NSString *firstAdvertisement = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstAdvertisement"];
    if(firstAdvertisement.length<3){
        return;
    }
    if ([RDUserInformation getInformation].advertisementClick==YES) {
        NSMutableDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"Advertisement_data"];
        AdvertisementModel *model = [AdvertisementModel mj_objectWithKeyValues:dictionary];
        switch ([model.skip_type intValue]) {
            case 1:
            {
                
            }
                break;
            case 2:
            {
                SubscribeViewController *homeAdvertisement = [[SubscribeViewController alloc] init];
                homeAdvertisement.web_url = model.skip_url;
                homeAdvertisement.titleName = @"广告";
                [weakSelf.navigationController pushViewController:homeAdvertisement animated:YES];
            }
                break;
                
                
            default:
                break;
        }
        
    }
   

}


-(void)loadBaiDu{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [webView loadRequest:request];
}


-(void)bindViewModel{
    WS(weakself)
    [[self.homeviewModel.accountSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * x) {//开户状态
        [[NSUserDefaults standardUserDefaults] setObject:x forKey:@"isFinishAccount"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        isFinishAccount = [x isEqualToString:@"2"] ? YES: NO;
        if(![[RDUserInformation getInformation] getLoginState]){
            [weakSelf puchLogin];
        }else if(!isFinishAccount) {
            showMassage(@"您尚未完成开户");
        }else{
            DepositFundsViewController * DVC = [[DepositFundsViewController alloc]init];
            [self.navigationController pushViewController:DVC animated:YES];
        }
    }];
    

    [[self.homeviewModel.itemclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        int index= [x intValue];
        switch (index) {
            case 0:
                [weakSelf puchRDProfile];//瑞达简介
                break;
            case 1://（1：资料审核 2：完成 3：失败 4：未开户）
                [weakSelf kefu];
                break;
            case 2:
                [weakSelf puchContactUs];//联系我们
                break;
            case 3://                业务办理
                [weakSelf pushBusinessBandling];
                break;
            case 4://                百宝箱
                [weakSelf pushMagicBox];
                break;
            case 5://账单查询
            {
                if(![[RDUserInformation getInformation] getLoginState]){
                    [weakSelf puchLogin];
                }else{
                    [weakSelf pushBills];
                }
            }
                break;
            case 6://公司公告
            {
                if(![[RDUserInformation getInformation] getLoginState]){
                    [weakSelf puchLogin];
                }else{
                    [weakSelf pushCompanyNotice];
                }
            }
                break;
            case 7://帮助信息
                [weakSelf pushHelpCenter];

                break;
            case 8://信息反馈
                [weakSelf pushInfoFeedBack];

                break;

            default:
                break;
        }
        
    }];
    
    [[self.homeviewModel.imageclickSubject takeUntil:self.rac_willDeallocSignal]  subscribeNext:^(id x) {
       
        HomeScrollModel *model  = (HomeScrollModel*)x;
        switch ([model.skip_type intValue]) {
            case 1:{
                switch ([model.within_sign intValue]) {
                    case 1:
                   
                        break;
                        
                    default:
                        break;
                }
            }
                break;
            case 2:{
                
                SubscribeViewController *sub = [[SubscribeViewController alloc] init];
                sub.web_url = model.skip_url;
                sub.titleName = model.name;
                [self.navigationController pushViewController:sub animated:YES];
            }
                break;
            default:
                break;
        }
        
    }];
    [[self.homeviewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal]  subscribeNext:^(id x) {
        if(![[RDUserInformation getInformation] getLoginState]){
            [weakSelf puchLogin];
        }else{
            //先判断是否开户完成
            [weakSelf isAccount];
        }
    }];
    
    [_homeviewModel.refreshMessageStateSubject subscribeNext:^(id  _Nullable x) {
        
        weakSelf.messageButton.selected  = [x intValue]==1 ? YES:NO;
        [RDUserInformation getInformation].messageState = [NSString stringWithFormat:@"%@",x];
    }];

}
-(void)isAccount{
    WS(weakself)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest getWithApi:@"/api/account/getQueryAccount.api" andParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([model.State intValue]==1) {
                NSString * str = [NSString stringWithFormat:@"%@",model.Data[@"speed_status"]];
                NSLog(@"开户state=%@",model.Data);
                if ([str isEqualToString:@"8"]) {
                    isFinishAccount = YES;
                }else isFinishAccount = NO;
                [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"isFinishAccount"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [weakSelf puchOpenfirst];
            }else{
                showMassage(@"请求失败")
            }
        });
    });
    
}
-(void)kefu{
    OnlineServiceViewController *online = [[OnlineServiceViewController alloc] init];
    [self.navigationController pushViewController:online animated:YES];
}
-(void)addChildView{
}


-(void)updateViewConstraints{
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    [super updateViewConstraints];
}

-(UIBarButtonItem *)leftButton {
    return nil;
}

- (UIBarButtonItem *)rightButton {
    return [[UIBarButtonItem alloc] initWithCustomView:self.messageButton];
}

-(UIButton *)messageButton {
    if (!_messageButton) {
        _messageButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_messageButton setImage:[UIImage imageNamed:@"icon_navigationbar_message"] forState:UIControlStateNormal];//设置左边按钮的图片
        [_messageButton setImage:[UIImage imageNamed:@"icon_navigationbar_message_select"] forState:UIControlStateSelected];//设置左边按钮的图片
        [_messageButton addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    }
    return _messageButton;
}

-(void)actionOnTouchBackButton:(id)sender {
    if(![[RDUserInformation getInformation] getLoginState]){
        [self puchLogin];
        return ;
    }
    MessageViewController *message = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:message animated:YES];
}

-(HomeView *)mainView {
    if (!_mainView) {
        _mainView = [[HomeView alloc] initWithViewModel:self.homeviewModel];
    }
    return _mainView;
}
-(HomeViewModel *)homeviewModel{
    if (!_homeviewModel) {
        _homeviewModel = [[HomeViewModel alloc] init];
       
    }
    return _homeviewModel;
}


@end
