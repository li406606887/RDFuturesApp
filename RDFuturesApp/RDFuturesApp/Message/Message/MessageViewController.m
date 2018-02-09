//
//  MessageViewController.m
//  RDFuturesApp
//
//  Created by user on 17/5/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageView.h"
#import "MessageModel.h"
#import "MessageViewModel.h"
#import "RDNoitceViewController.h"
#import "OnlineServiceViewController.h"

@interface MessageViewController ()
@property(nonatomic,strong)MessageView *messageView;
@property(nonatomic,strong)MessageViewModel *messageViewModel;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"消息"];
    [self.view addSubview:self.messageView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.messageViewModel.refreshTable sendNext:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateViewConstraints{
    WS(weakself)
    
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

-(void)bindViewModel{
    
    [[self.messageViewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        int index = [x intValue];
        switch (index) {
            case 0:
            {
                OnlineServiceViewController *online = [[OnlineServiceViewController alloc] init];
                [self.navigationController pushViewController:online animated:YES];

            }
                break;
            case 1:{
                RDNoitceViewController *rdNotice = [[RDNoitceViewController alloc] init];
                [self.navigationController pushViewController:rdNotice animated:YES];
                MessageModel *model = self.messageViewModel.dataArray[1];
                model.is_new_inform = NO;
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

-(MessageView *)messageView{
    if (!_messageView) {
        _messageView = [[MessageView alloc] initWithViewModel:self.messageViewModel];
        _messageView.backgroundColor = [UIColor whiteColor];
    }
    return _messageView;
}
-(MessageViewModel *)messageViewModel{
    if (!_messageViewModel) {
        _messageViewModel = [[MessageViewModel alloc] init];
    }
    return _messageViewModel;
}
@end
