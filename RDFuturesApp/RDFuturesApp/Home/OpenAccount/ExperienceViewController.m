//
//  ExperienceViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ExperienceViewController.h"
#import "PullDownCell.h"
#import "ChooseBankView.h"
#import "WitnessCityViewController.h"
#import "ExperienceModel.h"
#import "ExperienceViewController.h"
#import "DerivativeViewController.h"

@interface ExperienceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *cellTextArray;
@property (nonatomic,strong)NSMutableArray *cellIndexArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *yearsArr;
@property (nonatomic,strong)NSMutableArray * otherYearsArr;
@end

@implementation ExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"投资经验";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:kPullDownCell bundle:nil] forCellReuseIdentifier:kPullDownCell];
    
    if ([self.loadType intValue] == 1) {
        [self getInvestmentExperienceInfoData];

    }

}
#pragma mark - tableView ————
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row > 4) {
        [self chooseViewWithIndex:indexPath.row andArray:self.yearsArr];//弹出框
    }else{
    
        [self chooseViewWithIndex:indexPath.row andOtherYearArray:self.otherYearsArr];//弹出框
    }
    

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PullDownCell * cell = [tableView dequeueReusableCellWithIdentifier:kPullDownCell];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    
    cell.contentLabel.text = self.cellTextArray[indexPath.row];

    
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
#pragma mark - 下一步
- (IBAction)nextBtnClick:(id)sender {

   
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setObject:self.cellIndexArray[0] forKey:@"shares_id"];//股票投资经验id
    [dataDic setObject:self.cellIndexArray[1] forKey:@"trading_id"];//股票投资经验id
    [dataDic setObject:self.cellIndexArray[2] forKey:@"bear_card_id"];//股票投资经验id
    [dataDic setObject:self.cellIndexArray[3] forKey:@"derivative_id"];//股票投资经验id
    [dataDic setObject:self.cellIndexArray[4] forKey:@"futures_id"];//股票投资经验id
    [dataDic setObject:self.cellIndexArray[5] forKey:@"options_id"];//股票投资经验id
    [dataDic setObject:self.cellIndexArray[6] forKey:@"precious_metal_id"];//股票投资经验id
    [dataDic setObject:self.cellIndexArray[7] forKey:@"investment_other_id"];//股票投资经验id

    
    loading(@"");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        RDRequestModel *model = [RDRequest postInvestmentExperienceInfoWithParam:dataDic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error == nil) {
                if ([model.State isEqualToString:@"1"]) {

                    [self pushDerivative];
                }
            }else{
                [MBProgressHUD showError:promptString];
            }
        });
        
    });
    
    
}
-(void)getInvestmentExperienceInfoData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        RDRequestModel *model = [RDRequest getInvestmentExperienceInfoWithParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                if ([model.State isEqualToString:@"1"]) {
                    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:model.Data];
                    ExperienceModel *experience = [ExperienceModel mj_objectWithKeyValues:dic];
                    
                    if ([dic objectForKey:@"Data"]) {
                        
                    }else{
                        
                        self.cellIndexArray[0] = [NSString stringWithFormat:@"%@",experience.shares_id];
                        self.cellIndexArray[1] =
                        [NSString stringWithFormat:@"%@",experience.trading_id];
                        self.cellIndexArray[2] = [NSString stringWithFormat:@"%@",experience.bear_card_id];
                        self.cellIndexArray[3] = [NSString stringWithFormat:@"%@",experience.derivative_id];
                        self.cellIndexArray[4] = [NSString stringWithFormat:@"%@",experience.futures_id];
                        self.cellIndexArray[5] = [NSString stringWithFormat:@"%@",experience.options_id];
                        self.cellIndexArray[6] = [NSString stringWithFormat:@"%@",experience.precious_metal_id];
                        self.cellIndexArray[7] = [NSString stringWithFormat:@"%@",experience.investment_other_id];
                        
                        for (int i=0 ; i<self.cellIndexArray.count; i++) {
                            
                            if (i > 4) {
                                self.cellTextArray[i] = self.yearsArr[[self.cellIndexArray[i] intValue]-1];
                            }else{
                            
                                self.cellTextArray[i] = self.otherYearsArr[[self.cellIndexArray[i] intValue] - 1];
                            }

                            [self.tableView reloadData];
                        }
                    }
                    
                }else{
                    showMassage(model.Message);
                }
            }else{
                [MBProgressHUD showError:promptString];
            }
        });
        
    });
    
}
#pragma mark - 弹出框 block 回调取值
-(void)chooseViewWithIndex:(NSInteger)index andOtherYearArray:(NSArray *)array
{
    ChooseBankView * view = [[ChooseBankView alloc]initWithDataArray:array];
    [view show];
    view.callBackBlock = ^(NSString * tStr){
        self.cellTextArray[index] = self.otherYearsArr[[tStr intValue]];
        self.cellIndexArray[index] = [NSString stringWithFormat:@"%d",[tStr intValue]+1];
        [_tableView reloadData];
    };
    
}
#pragma mark - 弹出框 block 回调取值
-(void)chooseViewWithIndex:(NSInteger)index andArray:(NSArray *)array
{
    ChooseBankView * view = [[ChooseBankView alloc]initWithDataArray:array];
    [view show];
    view.callBackBlock = ^(NSString * tStr){
        self.cellTextArray[index] = self.yearsArr[[tStr intValue]];
        self.cellIndexArray[index] = [NSString stringWithFormat:@"%d",[tStr intValue]+1];
        [_tableView reloadData];
    };
    
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
-(NSMutableArray *)cellTextArray{
    if (!_cellTextArray) {
        _cellTextArray = [NSMutableArray arrayWithObjects:@"少于一年",@"少于一年",@"少于一年",@"少于一年",@"少于一年",@"少于一年",@"少于一年",@"少于一年", nil];
    }
    return _cellTextArray;
}
-(NSMutableArray *)cellIndexArray{
    if (!_cellIndexArray) {
        _cellIndexArray = [NSMutableArray arrayWithObjects:@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2", nil];
    }
    return _cellIndexArray;
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"股票",@"杠杆式外汇交易",@"牛熊证",@"衍生权证(窝轮)",@"期货",@"期权",@"贵金属",@"其他",nil];
    }
    return _titleArray;
}
-(NSMutableArray *)otherYearsArr{
    
    if (!_otherYearsArr) {
        _otherYearsArr = [NSMutableArray arrayWithObjects:@"少于一年",@"一至五年",@"六至十年",@"十年以上", nil];
    }
    return _otherYearsArr;
}

-(NSMutableArray *)yearsArr{
    if (!_yearsArr) {
    
        _yearsArr = [NSMutableArray arrayWithObjects:@"少于一年",@"一至二年",@"三至五年",@"五年以上",nil];
    }
    return _yearsArr;
}
@end
