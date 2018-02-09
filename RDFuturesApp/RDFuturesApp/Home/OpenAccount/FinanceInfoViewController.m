//
//  FinanceInfoViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/7.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "FinanceInfoViewController.h"
#import "PullDownCell.h"
#import "ChooseBankView.h"
#import "ExperienceViewController.h"
#import "FinanceInfoModel.h"

@interface FinanceInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString * firstStr;//第一个cell选择后的字符串
    NSString * secondStr;
    NSString * thirdStr;
    NSString * fourthStr;

    
    NSArray * titleArray;//左边栏位数据源

    int year_income_id;				//全年收入id
    int total_assets_id;					//总资产净值id
    int investment_purpose_id;//			投资目的id
    int housing_ownership_id;//			住宅所有权id
    
    
    
    NSArray * dataArr;//弹框数据源
    
    /*
     1、year_income_id					全年收入id
     2、total_assets_id					总资产净值id
     3、investment_purpose_id				投资目标id
     4、housing_ownership_id				住宅所有权id
     5、property_valuation				物业估值
     */
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UITextField *property_valuationTextfield;

@end

@implementation FinanceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"财务信息";
    
    [self loadTableView];
    
    [self titleArray];


    year_income_id = total_assets_id = investment_purpose_id =
     housing_ownership_id  = 0;
    
    [self dataArr];
    
    if ([self.loadType intValue] == 1) {
        [self getInfo];
    }

}

-(void)getInfo{
    
    loading(@"正在请求数据");
    
    //    __weak __typeof(self)weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest setWithApi:@"/api/account/getFinanceInfo.api" andParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                
                NSDictionary * infoDic = [NSDictionary dictionary];
                infoDic = model.Data;
                FinanceInfoModel * model = [FinanceInfoModel mj_objectWithKeyValues:infoDic];

                NSLog(@"%@",infoDic);
//                _property_valuationTextfield.text = [NSString stringWithFormat:@"%@",model.property_valuation];

                if ([model.year_income_id intValue]>0) {
                    year_income_id = [model.year_income_id intValue];
                    firstStr = dataArr[0][year_income_id -1];
                }
                if ([model.total_assets_id intValue]>0) {
                    total_assets_id = [model.total_assets_id intValue];
                    secondStr = dataArr[1][total_assets_id - 1];
                }
                if ([model.investment_purpose_id intValue]>0) {
                    investment_purpose_id = [model.investment_purpose_id intValue];
                    thirdStr = dataArr[2][investment_purpose_id - 1];
                }
                
//                if ([model.housing_ownership_id intValue]>0) {
//                    housing_ownership_id = [model.housing_ownership_id intValue];
//                    fourthStr = dataArr[3][housing_ownership_id - 1];
//                }

                [_tableView  reloadData];
            }else{
                [MBProgressHUD showError:@"请求失败"];
            }
        });
        
    });
    
}


- (NSArray *)dataArr{
    
    if (!dataArr) {
        
        dataArr = @[
          @[@"20万港币以下",@"20-50万港币",@"50-100万港币",@"100万港币以上"],
          @[@"50万港币以下",@"50-100万港币",@"100-500万港币",@"500万港币以上"],
          @[@"资本增值",@"对冲",@"投机",@"其他"],
          @[@"自置",@"租用",@"按揭"]
          ];
    }
    return dataArr;
}
- (NSArray *)titleArray{

    if (!titleArray) {
        titleArray = @[@"全年收入",@"总资产净值",@"投资目的"];
    }
    return titleArray;
}

#pragma mark - 加载tableView
-(void)loadTableView{
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:[UINib nibWithNibName:kPullDownCell bundle:nil] forCellReuseIdentifier:kPullDownCell];
}
#pragma mark - tableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self chooseViewWithIndex:0 andArray:dataArr[0]];//弹出框
            break;
        case 1:
            [self chooseViewWithIndex:1 andArray:dataArr[1]];
            break;
        case 2:
            [self chooseViewWithIndex:2 andArray:dataArr[2]];
            break;
        case 3:
            [self chooseViewWithIndex:3 andArray:dataArr[3]];
            break;

            
        default:
            break;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PullDownCell * cell = [tableView dequeueReusableCellWithIdentifier:kPullDownCell];
    cell.titleLabel.text = titleArray[indexPath.row];
    
    //数据显示
    switch (indexPath.row) {
        case 0:
            cell.contentLabel.text = firstStr;
            break;
        case 1:
            cell.contentLabel.text = secondStr;
            break;
        case 2:
            cell.contentLabel.text = thirdStr;
            break;
        case 3:
            cell.contentLabel.text = fourthStr;
            break;

            
        default:
            break;
    }
    

    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52;
}
#pragma mark - 下一步

- (IBAction)nextBtnClick:(id)sender {
    
    if (year_income_id == 0 ||
        total_assets_id == 0 ||
        investment_purpose_id == 0) {
        showMassage(@"信息输入不完整")
        return;
    }
    
        loading(@"正在提交数据");
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        
        [dic setObject:[NSString stringWithFormat:@"%d",year_income_id] forKey:@"year_income_id"];
        [dic setObject:[NSString stringWithFormat:@"%d",total_assets_id] forKey:@"total_assets_id"];
        [dic setObject:[NSString stringWithFormat:@"%d",investment_purpose_id] forKey:@"investment_purpose_id"];
        [dic setObject:[NSString stringWithFormat:@"22"] forKey:@"housing_ownership_id"];
//        [dic setObject:[NSString stringWithFormat:@"%d",housing_ownership_id] forKey:@"housing_ownership_id"];
//        [dic setObject:[NSString stringWithFormat:@"%@",_property_valuationTextfield.text] forKey:@"property_valuation"];
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error ;
            
            RDRequestModel * model = [RDRequest setWithApi:@"/api/account/setFinanceInfo.api" andParam:dic error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                hiddenHUD;
                if (error==nil) {
                    showMassage(model.Message);
                    NSLog(@"%@",model.Message);
                    
                    if ([model.Message isEqualToString:@"成功"]) {
                        //下一页
                        ExperienceViewController * EVC = [[ExperienceViewController alloc]init];
                        [self.navigationController pushViewController:EVC animated:YES];
                    }
                    
                }else{
                    [MBProgressHUD showError:@"请求失败"];
                }
            });
            
        });
        


}
#pragma mark - 弹出框 block 回调取值
-(void)chooseViewWithIndex:(NSInteger)index andArray:(NSArray *)array
{
    ChooseBankView * view = [[ChooseBankView alloc]initWithDataArray:array];
    [view show];
    view.callBackBlock = ^(NSString * tStr){
        
        switch (index) {
            case 0:
                year_income_id = [tStr intValue] + 1;
                switch ([tStr intValue]) {
                    case 0:
                        firstStr = dataArr[0][0];
                        break;
                    case 1:
                        firstStr = dataArr[0][1];
                        break;
                    case 2:
                        firstStr = dataArr[0][2];
                        break;
                    case 3:
                        firstStr = dataArr[0][3];
                        break;
                    case 4:
                        firstStr = dataArr[0][4];
                        break;
                    default:
                        break;
                }
                
                break;
            case 1:
                total_assets_id = [tStr intValue] + 1;
                switch ([tStr intValue]) {
                    case 0:
                        secondStr = dataArr[1][0];
                        break;
                    case 1:
                        secondStr = dataArr[1][1];
                        break;
                    case 2:
                        secondStr = dataArr[1][2];
                        break;
                    case 3:
                        secondStr = dataArr[1][3];
                        break;
                        
                    default:
                        break;
                }
                break;

            case 2:
                investment_purpose_id = [tStr intValue] + 1;
                switch ([tStr intValue]) {
                    case 0:
                        thirdStr = dataArr[2][0];
                        break;
                    case 1:
                        thirdStr = dataArr[2][1];
                        break;
                    case 2:
                        thirdStr = dataArr[2][2];
                        break;
                    case 3:
                        thirdStr = dataArr[2][3];
                        break;
                    case 4:
                        thirdStr = dataArr[2][4];
                        break;
                    default:
                        break;
                }
                break;
            case 3:
                housing_ownership_id = [tStr intValue] + 1;
                switch ([tStr intValue]) {
                    case 0:
                        fourthStr = dataArr[3][0];
                        break;
                    case 1:
                        fourthStr = dataArr[3][1];
                        break;
                    case 2:
                        fourthStr = dataArr[3][2];
                        break;
                    case 3:
                        fourthStr = dataArr[3][3];
                        break;
                    case 4:
                        fourthStr = dataArr[3][4];
                        break;
                    default:
                        break;
                }
                break;
                
                
            default:
                break;
        }
        [_tableView reloadData];
    };
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
