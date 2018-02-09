//
//  AccountSecurityViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/25.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AccountSecurityViewController.h"
#import "AccountSecurityFirstCell.h"
#import "AccountSecuritySecondCell.h"
#import "ChangePhoneNumViewController.h"
#import "SetGesturesViewController.h"
#import "TestViewController.h"
#import "PromptView.h"

@interface AccountSecurityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic,strong) NSString * phoneNumStr;
@property (nonatomic,strong) NSString * idStr;
@property (nonatomic,weak) UILabel *stateLabel;
@end

@implementation AccountSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    _phoneNumStr = [userdefault objectForKey:@"phoneNumber"];
    _idStr = [userdefault objectForKey:@"customer_id"];

    self.title = @"账户安全";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:kAccountSecurityFirstCell bundle:nil] forCellReuseIdentifier:kAccountSecurityFirstCell];
    [self.tableView registerNib:[UINib nibWithNibName:kAccountSecuritySecondCell bundle:nil] forCellReuseIdentifier:kAccountSecuritySecondCell];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self titleArray];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.stateLabel.text = [[RDUserInformation getInformation].gesturesStatus intValue]==1? @"已设置": @"未设置";
}
-(NSArray *)titleArray{
    
    if (!_titleArray) {
        _titleArray = @[@"客户号",@"手机号",@"邮箱"];
    }
    return _titleArray;
}

-(void)loadPromptView{


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountSecurityFirstCell * firstCell = [tableView dequeueReusableCellWithIdentifier:kAccountSecurityFirstCell];
    AccountSecuritySecondCell * secondCell = [tableView dequeueReusableCellWithIdentifier:kAccountSecuritySecondCell];
    firstCell.separatorInset = UIEdgeInsetsMake(0,15, 0, 15);
    secondCell.separatorInset = UIEdgeInsetsMake(0,15, 0, 15);
    WS(weakself)
    switch (indexPath.row) {
        case 0: {
            firstCell.leftLabel.text = _titleArray[0];
            firstCell.rightLabel.text = _idStr;
            return firstCell;
        }
            break;
        case 1: {
            secondCell.titleLabel.text = _titleArray[1];
            NSMutableString * str1 = [[NSMutableString alloc]initWithString:_phoneNumStr];
            [str1 replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            secondCell.phoneLabel.text = str1;
            secondCell.bBlock = ^() {
                [weakSelf alertView];
            };
            return secondCell;
        }
            break;
        case 2: {
            firstCell.leftLabel.text = _titleArray[2];
            firstCell.rightLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
            return firstCell;
        }
            break;
        default:
            break;
    }
    return nil;
}

-(void)alertView {
    WS(weakself)
    NSString * str = [NSString stringWithFormat:@"您正在更换认证手机号,发送验证短信到\n%@",self.phoneNumStr];
    NSMutableString * str1 = [[NSMutableString alloc]initWithString:str];
    [str1 replaceCharactersInRange:NSMakeRange(22, 4) withString:@"****"];
    PromptView * pView = [[PromptView alloc]initWithTitleString:@"提示" SubTitleString:str1];
    [pView show];
    pView.goonBlock = ^{
        
        [weakSelf pushNextVC];
        
    };
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    @weakify(self)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        SetGesturesViewController *setGestures = [[SetGesturesViewController alloc] init];
        setGestures.navTitle = @"";
        setGestures.type = YES;
        [self.navigationController pushViewController:setGestures animated:YES];
    }];
    [footSectionView addGestureRecognizer:tap];
    
    [footSectionView setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 20, 23)];
    [imageIcon setImage:[UIImage imageNamed:@"Mine_Safe_Lock"]];
    [imageIcon setContentMode:UIViewContentModeScaleToFill];
    [footSectionView addSubview:imageIcon];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(getLeft(imageIcon)+5, 10, 150, 15)];
    [title setText:@"手势解锁"];
    [title setTextColor:RGB(51, 51, 51)];
    [title setFont:[UIFont systemFontOfSize:15]];
    [footSectionView addSubview:title];
    UILabel *titleDetails = [[UILabel alloc] initWithFrame:CGRectMake(getLeft(imageIcon)+5, getTop(title)+3, 150, 15)];
    [titleDetails setText:@"设置后可保护隐私信息"];
    [titleDetails setTextColor:RGB(102, 102, 102)];
    [titleDetails setFont:[UIFont systemFontOfSize:12]];
    [footSectionView addSubview:titleDetails];
    
    UILabel *state = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 0, 50, 50)];
    [state setText:@"未设置"];
    [state setTextColor:RGB(68, 68, 68)];
    [state setTextAlignment:NSTextAlignmentRight];
    [state setFont:[UIFont systemFontOfSize:15]];
    [footSectionView addSubview:state];
    self.stateLabel = state;
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-25, 14, 13   , 23)];
    [arrow setImage:[UIImage imageNamed:@"Mine_right_arrow"]];
    [footSectionView addSubview:arrow];
    return footSectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

-(void)pushNextVC {
    loading(@"正在发送")
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_phoneNumStr forKey:@"phone"];
    [dic setObject:@"3" forKey:@"check_type"];//1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        RDRequestModel *model = [RDRequest postSendValidateCodeWithParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                ChangePhoneNumViewController * CVC = [[ChangePhoneNumViewController alloc]init];
                CVC.phoneNum = _phoneNumStr;
                [self.navigationController pushViewController:CVC animated:YES];
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
