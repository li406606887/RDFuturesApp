//
//  MineViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/2.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MineViewController.h"
#import "SettingViewController.h"
#import "BillViewController.h"
#import "CollectionViewController.h"
#import "MineFirstTableViewCell.h"
#import "MineSecondTableViewCell.h"
#import "DepositFundsViewController.h"
#import "WithdrawFundsViewController.h"
#import "PeronalInfoViewController.h"
#import "ChooseIDViewController.h"
#import "HelpCenterViewController.h"
#import "OnlineServiceViewController.h"
#import "WitnessCityViewController.h"
#import "LoginViewController.h"
#import "AboutUsViewController.h"
#import "AccountSecurityViewController.h"
#import "MessageViewController.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isShare;
    int click;
    NSString * username;              // 用户昵称
    NSURL * user_img;              //头像
    NSString * customer_id;         	  // 客户号
    NSString * email; //邮箱
    BOOL isFinishAccount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (nonatomic, strong)NSArray * titleImgArray;
@property (nonatomic, strong)NSArray * titleArray;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *customerID;
@property (nonatomic,strong) UIButton * messageButton;
@end

@implementation MineViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![[RDUserInformation getInformation] getLoginState]) {
        
        self.tabBarController.selectedIndex = 0;
    } else{
        [self getPersonalInfo];
        self.messageButton.selected  = [[RDUserInformation getInformation].messageState intValue]==1 ? YES:NO;
        [self isAccount];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleArray];
    [self titleImgArray];
    [self loadTableView];
    [self headViewSet];
    click = 1;
    
    
}
- (UIBarButtonItem *)rightButton
{
    return [[UIBarButtonItem alloc] initWithCustomView:self.messageButton];
}
-(UIButton *)messageButton{
    if (!_messageButton) {
        _messageButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_messageButton setImage:[UIImage imageNamed:@"icon_navigationbar_message"] forState:UIControlStateNormal];//设置左边按钮的图片
        [_messageButton setImage:[UIImage imageNamed:@"icon_navigationbar_message_select"] forState:UIControlStateSelected];//设置左边按钮的图片
        [_messageButton addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    }
    return _messageButton;
}
-(void)actionOnTouchBackButton:(id)sender{
    if(![[RDUserInformation getInformation] getLoginState]){
        [self puchLogin];
        return ;
    }
    MessageViewController *message = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:message animated:YES];
}
- (IBAction)logoutBtnClick:(id)sender {
    
    loading(@"正在提交数据");
    WS(weakself)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest setWithApi:@"/api/user/logout.api" andParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                
                if ([model.State isEqualToString:@"1"]) {
                    //成功
                    [[RDUserInformation getInformation] cleanUserInfo];
                    
                    weakSelf.tabBarController.selectedIndex = 0;
                    
                }
                
            }else{
                [MBProgressHUD showError:@"请求失败"];
            }
        });
        
    });
    
}
-(UIBarButtonItem *)leftButton{
    return nil;
}
-(void)getPersonalInfo{
    
    __weak __typeof(self)weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest getWithApi:@"/api/user/getPersonalData.api" andParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if ([model.State isEqualToString:@"1"]) {
                
                username = [NSString stringWithFormat:@"%@",model.Data[@"username"]];
                weakSelf.nickName.text = username;
                
                customer_id = [NSString stringWithFormat:@"%@",model.Data[@"customer_id"]];
                weakSelf.customerID.text = [NSString stringWithFormat:@"客户号 %@",customer_id];
                
                email = [NSString stringWithFormat:@"%@",model.Data[@"email"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"email"];
                [[NSUserDefaults standardUserDefaults] setObject:customer_id forKey:@"customer_id"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                user_img = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.Data[@"user_img"]]];
                [weakSelf.headImage sd_setImageWithURL:user_img placeholderImage:[UIImage imageNamed:@"head_icon"]];
                
                [weakSelf.tableView.mj_header endRefreshing];
            }else{
                
                [weakSelf.tableView.mj_header endRefreshing];
            }
            
        });
    });
}

-(void)loadTableView{
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionFooterHeight = 0;
    _tableView.sectionHeaderHeight = 15;
    [_tableView registerNib:[UINib nibWithNibName:kMineFirstTableViewCell bundle:nil] forCellReuseIdentifier:kMineFirstTableViewCell];
    [_tableView registerNib:[UINib nibWithNibName:kMineSecondTableViewCell bundle:nil] forCellReuseIdentifier:kMineSecondTableViewCell];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    WS(weakself)
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getPersonalInfo];
    }];
    isShare = NO;
    
}
#pragma mark -  加载头视图
-(void)headViewSet
{
    //用户头像
    self.headImgView.userInteractionEnabled = YES;
    self.headImgView.layer.cornerRadius = 30;//设置圆形
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.image = [UIImage imageNamed:@"head_icon"];//默认logo
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushPersonalInfo)];
    [self.tableView.tableHeaderView addGestureRecognizer:tap];
}
//个人资料
-(void)pushPersonalInfo{
    
    PeronalInfoViewController * PVC = [[PeronalInfoViewController alloc]init];
    PVC.username = username;
    PVC.user_img = user_img;
    PVC.customer_id = customer_id;
    WS(weakself)
    PVC.popBlock = ^(NSString * str,NSURL * imageUrl){
        _nickName.text = str;
        username = str;
        user_img = imageUrl;
        [self.headImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"head_icon"]];
        
        [weakSelf getPersonalInfo];
        
    };
    [self.navigationController pushViewController:PVC animated:YES];
}

#pragma mark - tableView代理
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 7.5)];
    bgview.backgroundColor = RGB(230, 230, 230);
    return bgview;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 7.5)];
    bgview.backgroundColor = RGB(230, 230, 230);
    return bgview;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 2;
}

-(void)isAccount{
    
    //    speed_status			进度状态（0：未开户  1：资料审核 2：资料审核完成（见证客户中）							 3：资料审核失败  4：见证客户完成（客服回访中） 5：见证客户失败 6：客服回访完成 	7：客服回访失败 8：开户成功  9：开户失败）
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
                
            }else{
                
            }
        });
    });
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:{
                CollectionViewController * COVC = [[CollectionViewController alloc]init];
                [self.navigationController pushViewController:COVC animated:YES];
            }
                break;
                
            case 1:
            {
                //帮助中心
                HelpCenterViewController * HVC = [[HelpCenterViewController alloc]init];
                [self.navigationController pushViewController:HVC animated:YES];
            }
                break;
                
            case 2:
            {
                OnlineServiceViewController *CVC = [[OnlineServiceViewController alloc]init];
                [self.navigationController pushViewController:CVC animated:YES];
            }
                
                break;
            default:
                break;
        }
        
    }else{
        
        switch (indexPath.row) {
            case 0:
            {
                AccountSecurityViewController * ACVC = [[AccountSecurityViewController alloc]init];
                [self.navigationController pushViewController:ACVC animated:YES];
            }
                break;
                
            case 1:
            {
                AboutUsViewController * AVC = [[AboutUsViewController alloc]init];
                [self.navigationController pushViewController:AVC animated:YES];
            }
                break;
                
                
            default:
                break;
        }
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMineFirstTableViewCell];
    MineSecondTableViewCell * secondCell = [tableView dequeueReusableCellWithIdentifier:kMineSecondTableViewCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    if (indexPath.section == 0) {
        
        cell.titleLabel.text = _titleArray[indexPath.row];
        cell.imgView.image = [UIImage imageNamed:_titleImgArray[indexPath.row]];
        
    }else{
        cell.titleLabel.text = _titleArray[indexPath.row+3];
        cell.imgView.image = [UIImage imageNamed:_titleImgArray[indexPath.row+3]];
    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
            break;
            
        default:
            break;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        CGFloat h = isShare ? 145 : 50;
        return h;
    }
    return 50;
}

- (NSArray *)titleImgArray
{
    if (!_titleImgArray) {
        _titleImgArray = @[@"Mine_collection_icon",@"Mine_help_icon",@"Mine_service_icon",@"Mine_account_icon",@"Mine_aboutus_icon"];
    }
    return _titleImgArray;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"我的收藏",@"帮助中心",@"我的客服",@"账户安全",@"关于我们"];
    }
    return _titleArray;
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
