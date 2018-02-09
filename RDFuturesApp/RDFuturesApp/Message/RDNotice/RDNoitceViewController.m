
//
//  RDNoitceViewController.m
//  RDFuturesApp
//
//  Created by user on 2017/5/12.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDNoitceViewController.h"
#import "RDNoticeView.h"
#import "RDNoticeViewModel.h"
#import "ProgressViewController.h"


@interface RDNoitceViewController ()
@property(nonatomic,strong)RDNoticeView *noticeView;
@property(nonatomic,strong)RDNoticeViewModel *viewModel;
@end

@implementation RDNoitceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"瑞达通知"];
    [self.view addSubview:self.noticeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateViewConstraints{
    WS(weakself)
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}
-(void)bindViewModel{
    WS(weakself)
    [self.viewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
        switch ([x intValue]) {
            case 1:
            {
                ProgressViewController * PVC = [[ProgressViewController alloc]init];
                PVC.PuchStyle = YES;
                [weakSelf.navigationController pushViewController:PVC animated:YES];
            }
                break;
                
            default:
                break;
        }
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
-(RDNoticeView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[RDNoticeView alloc] initWithViewModel:self.viewModel];
    }
    return _noticeView;
}
-(RDNoticeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[RDNoticeViewModel alloc] init];
    }
    return _viewModel;
}
@end
