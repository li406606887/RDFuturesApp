//
//  SettingViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/24.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "SettingViewController.h"
#import "AccountSecurityViewController.h"
#import "AboutUsViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
  
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray * titleArray;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"设置";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [self titleArray];
    
}
-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"账户安全",@"关于我们"];
    }
    return _titleArray;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            AccountSecurityViewController * AVC = [[AccountSecurityViewController alloc]init];
            [self.navigationController pushViewController:AVC animated:YES];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

#pragma mark -- 退出登录
- (IBAction)LogOutBtnClick:(id)sender {
    
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
                   
//                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
//                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
//                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phoneNumber"];
//                  
//                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [[RDUserInformation getInformation] cleanUserInfo];
                    
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    weakSelf.tabBarController.selectedIndex = 0;

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
