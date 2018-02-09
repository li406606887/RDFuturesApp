//
//  DepositBankViewController.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "DepositBankViewController.h"
#import "DepositBankView.h"
#import "DepositBankViewModel.h"
#import "AutographViewController.h"
#import "SaveCompletedViewController.h"
#import "AutographModel.h"


@interface DepositBankViewController ()
@property(nonatomic,strong)DepositBankViewModel *viewModel;
@property(nonatomic,strong)DepositBankView *depositBankView;
@end

@implementation DepositBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"选择银行账号"];
    [self.view addSubview:self.depositBankView];
    
}
-(void)bindViewModel{
    WS(weakself)
    [[self.viewModel.nextStepClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        AutographViewController *autograph = [[AutographViewController alloc] init];
        autograph.model = (AutographModel*)x;
        autograph.AutographBlock = ^(BOOL result){
            if (result == YES) {
                SaveCompletedViewController *saveCompleted = [[SaveCompletedViewController alloc] init];
                saveCompleted.prompt = promptTypeDepositFunds;
                [weakSelf.navigationController pushViewController:saveCompleted animated:YES];
            }
        };
        [weakSelf presentViewController:autograph animated:YES completion:nil];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateViewConstraints{
    WS(weakself)
    [self.depositBankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(DepositBankView *)depositBankView{
    if (!_depositBankView) {
        _depositBankView = [[DepositBankView alloc] initWithViewModel:self.viewModel];
        _depositBankView.model.accountAccessId = self.accountAccessId;
    }
    return  _depositBankView;
}
-(DepositBankViewModel *)viewModel{
    if (!_viewModel){
        _viewModel = [[DepositBankViewModel alloc] init];
    }
    return _viewModel;
}
@end
