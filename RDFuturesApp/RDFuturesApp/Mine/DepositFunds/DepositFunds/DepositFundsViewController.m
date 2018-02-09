
//
//  DepositFundsViewController.m
//  RDFuturesApp
//
//  Created by user on 17/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "DepositFundsViewController.h"
#import "DepositMethodViewController.h"


#define CellID  @"DepositFundsCell"


@interface DepositFundsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *imageArray;

@end

@implementation DepositFundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.table];
    [self setTitle:@"存入资金"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.textLabel.font = [UIFont rdSystemFontOfSize:fourteenFontSize];
    cell.textLabel.textColor = RGB(68, 68, 68);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section; {
    
    return @"选择币种";
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DepositMethodViewController *depositMethod = [[DepositMethodViewController alloc] init];
    depositMethod.currency = [NSString stringWithFormat:@"%d",(int)indexPath.row+1];
    [self.navigationController pushViewController:depositMethod animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"港币",@"美元",@"离岸人民币",@"欧元",@"英镑", nil];
    }
    return _titleArray;
}
-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithObjects:@"DepositFounds_HK",@"DepositFounds_Dollar",@"DepositFounds_RMB",@"DepositFounds_Euro",@"DepositFounds_Pound", nil];
    }
    return _imageArray;
}
-(UITableView *)table{
    if(!_table){
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    }
    return _table;
}
@end
