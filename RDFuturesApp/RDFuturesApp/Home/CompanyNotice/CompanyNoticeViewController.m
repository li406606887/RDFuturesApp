//
//  CompanyNoticeViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "CompanyNoticeViewController.h"
#import "CompanyNoticeView.h"
#import "CompanyNoticeViewModel.h"
#import "CompanyNoticeModel.h"
#import "DetailsViewController.h"
@interface CompanyNoticeViewController ()
@property (nonatomic,strong)CompanyNoticeView * mainView;
@property (nonatomic,strong)CompanyNoticeViewModel * viewModel;
@end

@implementation CompanyNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公司公告";
   
    [self.view addSubview:self.mainView];
}

-(void)bindViewModel{

    WS(weakself)
    [[self.viewModel.cellClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        
        DetailsViewController * DVC = [[DetailsViewController alloc]init];
        DVC.urlStr = x;
        DVC.titleString = @"公告详情";
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
-(void)readBtnClick:(id)sender{


}
-(CompanyNoticeViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[CompanyNoticeViewModel alloc]init];
    }
    return _viewModel;
}
-(CompanyNoticeView *)mainView{

    if (!_mainView) {
        _mainView = [[CompanyNoticeView alloc]initWithViewModel:self.viewModel];
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
