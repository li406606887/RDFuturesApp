//
//  NoticeDetailsViewController.m
//  RDFuturesApp
//
//  Created by user on 17/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeDetailsViewController.h"
#import <WebKit/WebKit.h>
#import "PopCollectionView.h"
#import "NoticeCollectionViewModel.h"

@interface NoticeDetailsViewController ()
@property(nonatomic,strong)WKWebView *noticeDetails;
@property(nonatomic,strong)NoticeCollectionViewModel *viewModel;
@property(nonatomic,strong)UIButton *isCollect;
@end

@implementation NoticeDetailsViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([[RDUserInformation getInformation] getLoginState]){
        
        [self.viewModel.reloadClollectionStyleCommand execute:self.model.notice_id];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"详  情"];
    [self.view addSubview:self.noticeDetails];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)bindViewModel{
//        [self.viewModel.reloadClollectionStyleCommand execute:self.model.notice_id];
        [self.viewModel.refreshStyle subscribeNext:^(id  _Nullable x) {
            self.isCollect.selected = !self.isCollect.selected;
            showMassage(self.isCollect.selected==YES? @"收藏成功":@"取消收藏");
        }];
        [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
            
            if ([x intValue]==1) {
                self.isCollect.selected = YES;
            }else{
                self.isCollect.selected = NO;
            }
        }];
}

-(WKWebView *)noticeDetails{
    if (!_noticeDetails) {
        _noticeDetails = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-64)];
        NSURL *url = [NSURL URLWithString:self.model.content_url];
        // 3.创建Request
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        // 4.加载网页
        [_noticeDetails loadRequest:request];
    }
    return _noticeDetails;
}
-(UIBarButtonItem *)rightButton{

    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"Collection_icon_nomal"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Collection_icon_selected"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(collectionClick) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    [btn setShowsTouchWhenHighlighted:NO];
    self.isCollect = btn;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)collectionClick{
    if(![[RDUserInformation getInformation] getLoginState]){
        [self puchLogin];
        return ;
    }
    [self.viewModel.collectionClickCommand execute:self.model.notice_id];
}
-(NoticeCollectionViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[NoticeCollectionViewModel alloc] init];
    }
    return _viewModel;
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
