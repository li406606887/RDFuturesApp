//
//  BillViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/25.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BillViewController.h"
#import "BillViewModel.h"
#import "BillMainView.h"
#import "DetailsViewController.h"

@interface BillViewController ()
@property (nonatomic, strong)BillMainView * mainView;
@property (nonatomic, strong)BillViewModel * viewModel;
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的账单";
    [self.view addSubview:self.mainView];
}


-(void)bindViewModel{

    WS(weakself)
    [[self.viewModel.cellClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        DetailsViewController * DVC = [[DetailsViewController alloc]init];
        DVC.urlStr = x;
        DVC.titleString = @"账单详情";
        [weakSelf.navigationController pushViewController:DVC animated:YES];
    }];

}

-(void)updateViewConstraints{
    WS(weakself)
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];

    [super updateViewConstraints];
}

-(BillViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[BillViewModel alloc]init];
    }
    return _viewModel;
}
-(BillMainView *)mainView{

    if (!_mainView) {
        _mainView = [[BillMainView alloc]initWithViewModel:self.viewModel];
    }
    return _mainView;
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
