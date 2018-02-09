

//
//  MoneyAmountViewController.m
//  RDFuturesApp
//
//  Created by user on 17/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MoneyAmountViewController.h"
#import "MoneyAmountViewModel.h"
#import "MoneyAmountView.h"
#import "DepositBankViewController.h"

#define CellID  @"MoneyAmountCell"


@interface MoneyAmountViewController ()
@property(nonatomic,strong)MoneyAmountView *moneyAmountView;
@property(nonatomic,strong)MoneyAmountViewModel *viewModel;

@end

@implementation MoneyAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"持有银行卡"];
    [self.view addSubview:self.moneyAmountView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateViewConstraints{
    WS(weakself)
    [self.moneyAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}
-(void)bindViewModel{
    WS(weakself)
    [[self.viewModel.nextStepClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id _Nullable x) {
        DepositBankViewController *depositBank = [[DepositBankViewController alloc] init];
        depositBank.accountAccessId = [NSString stringWithFormat:@"%@",x];
        [weakSelf.navigationController pushViewController:depositBank animated:YES];
    }];
    [[self.viewModel.textFiledEditEnd takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        UITextField *field = (UITextField *)x;
        NSLog(@"%@",field.text);
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(MoneyAmountViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MoneyAmountViewModel alloc] init];
    }
    return _viewModel;
}

-(MoneyAmountView *)moneyAmountView{
    if(!_moneyAmountView){
        _moneyAmountView = [[MoneyAmountView alloc] initWithViewModel:self.viewModel];
        _moneyAmountView.model.currency = self.currency;
        _moneyAmountView.model.depositWays = self.depositWays;
    }
    return _moneyAmountView;
}


@end
