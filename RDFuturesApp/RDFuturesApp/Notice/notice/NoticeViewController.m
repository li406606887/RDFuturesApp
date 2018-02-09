//
//  NoticeViewController.m
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeView.h"
#import "NoticeViewModel.h"
#import "NoticeDetailsViewController.h"
#import "NoticeModel.h"
#import "MessageViewController.h"

@interface NoticeViewController ()
@property(nonatomic,strong)NoticeView *noticeView;
@property(nonatomic,strong)NoticeViewModel *noticeViewModel;
@property(nonatomic,strong)UIButton *messageButton;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.noticeView];
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.messageButton.selected  = [[RDUserInformation getInformation].messageState intValue]==1 ? YES:NO;
}
- (UIBarButtonItem *)rightButton
{
    return [[UIBarButtonItem alloc] initWithCustomView:self.messageButton];
}
-(UIButton *)messageButton{
    if (!_messageButton) {
        _messageButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_messageButton setImage:[UIImage imageNamed:@"icon_navigationbar_message"] forState:UIControlStateNormal];//设置左边按钮的图片
        [_messageButton setImage:[UIImage imageNamed:@"icon_navigationbar_message_select"] forState:UIControlStateSelected];//设置左边按钮的图片
        [_messageButton addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    }
    return _messageButton;
}
-(void)actionOnTouchBackButton:(id)sender{
    if(![[RDUserInformation getInformation] getLoginState]){
        [self puchLogin];
        return ;
    }
    MessageViewController *message = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:message animated:YES];
}
-(void)bindViewModel{
//    WS(weakself)
    [[self.noticeViewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NoticeModel * model) {
//        if(![[RDUserInformation getInformation] getLoginState]){
//            [weakSelf puchLogin];
//            return ;
//        }
        NoticeDetailsViewController * noticeDetails = [[NoticeDetailsViewController alloc]init];
        noticeDetails.model = model;
        [self.navigationController pushViewController:noticeDetails animated:YES];
        
    }];
}
-(void)updateViewConstraints{
    
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    [super updateViewConstraints];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIBarButtonItem *)leftButton{
    return nil;
}
-(NoticeView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[NoticeView alloc] initWithViewModel:self.noticeViewModel];
    }
    return _noticeView;
}
-(NoticeViewModel *)noticeViewModel{
    
    if (!_noticeViewModel) {
        _noticeViewModel = [[NoticeViewModel alloc] init];
    }
    return _noticeViewModel;
}

@end
