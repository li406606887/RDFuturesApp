//
//  CollectionViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/25.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionMainView.h"
#import "CollectionViewModel.h"
#import "DetailsViewController.h"

@interface CollectionViewController ()
@property (nonatomic,strong) CollectionMainView *mainView;
@property (nonatomic,strong) CollectionViewModel *viewModel;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的收藏";
    
    [self.view addSubview:self.mainView];
}
-(void)bindViewModel{
    
    WS(weakself)
    [[self.viewModel.cellClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
       //
        
        DetailsViewController * DVC = [[DetailsViewController alloc]init];
        DVC.urlStr = x;
        DVC.titleString = @"详情";
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
-(CollectionViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[CollectionViewModel alloc]init];
    }
    return _viewModel;

}
-(CollectionMainView *)mainView{

    if (!_mainView) {
        _mainView = [[CollectionMainView alloc]initWithViewModel:self.viewModel];
        _mainView.backgroundColor = BACKGROUNDCOLOR;
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
