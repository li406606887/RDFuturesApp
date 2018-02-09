//
//  WithdrawFundsViewController.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "WithdrawFundsViewController.h"
#import "WithdrawFundsViewModel.h"
#import "WithdrawFundsView.h"
#import "AutographViewController.h"
#import "SaveCompletedViewController.h"
#import "AutographModel.h"


@interface WithdrawFundsViewController ()
@property(nonatomic,strong)WithdrawFundsViewModel *viewModel;
@property(nonatomic,strong)WithdrawFundsView *withdrawFundsView;
@end

@implementation WithdrawFundsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"提取资金"];
    [self.view addSubview:self.depositBankView];
    
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
-(void)bindViewModel{
    WS(weakself)
    [[self.viewModel.nextStepClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        AutographViewController *autograph = [[AutographViewController alloc] init];
        autograph.model = (AutographModel*)x;
        autograph.AutographBlock = ^(BOOL result){
            
            if (result == YES) {
                SaveCompletedViewController *saveCompleted = [[SaveCompletedViewController alloc] init];
                saveCompleted.prompt = promptTypeWitdrawFunds;
                [weakSelf.navigationController pushViewController:saveCompleted animated:YES];
            }
        };
        [weakSelf presentViewController:autograph animated:YES completion:nil];
        
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

-(WithdrawFundsView *)depositBankView{
    if (!_withdrawFundsView) {
        _withdrawFundsView = [[WithdrawFundsView alloc] initWithViewModel:self.viewModel];
    }
    return  _withdrawFundsView;
}
-(WithdrawFundsViewModel *)viewModel{
    if (!_viewModel){
        _viewModel = [[WithdrawFundsViewModel alloc] init];
    }
    return _viewModel;
}


@end
