//
//  SetGesturesViewController.m
//  RDFuturesApp
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "SetGesturesViewController.h"
#import "ZLGestureLockViewController.h"

@interface SetGesturesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) UILabel *backgroundLabel;
@end

@implementation SetGesturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)addChildView {
    [self.view addSubview:self.table];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNavTitle:(NSString *)navTitle {
    self.title = navTitle;
}

-(void)updateViewConstraints {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[RDUserInformation getInformation].gesturesStatus intValue] == 1 ? 2: 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetGesturesCell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[RDUserInformation getInformation].gesturesStatus intValue] == 1) {
        switch (indexPath.row) {
            case 0:
                [self pushSetGesturesController:0];
                break;
            case 1:
                [self pushSetGesturesController:1];
                break;
            default:
                break;
        }
    }else{
        [self pushSetGesturesController:2];
    }
}


-(void)pushSetGesturesController:(int)index {
    ZLUnlockType type = ZLUnlockTypeCreatePsw;
    switch (index) {
        case 0:
            type = ZLUnlockTypeClosePsw;
            break;
        case 1:
            type = ZLUnlockTypeModifyPsw;
            break;
        case 2:
            type = ZLUnlockTypeCreatePsw;
            break;
        default:
            break;
    }
    ZLGestureLockViewController *draw = [[ZLGestureLockViewController alloc] initWithUnlockType:type];
    [self.navigationController pushViewController:draw animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = 50;
        _table.sectionHeaderHeight = 0.5f;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SetGesturesCell"];
    }
    return _table;
}

-(NSArray *)titleArray {
    if (!_titleArray) {
        if ([[RDUserInformation getInformation].gesturesStatus intValue] == 1) {
            _titleArray = [NSArray arrayWithObjects:@"关闭手势解锁",@"更改解锁图案", nil];
        }else {
            _titleArray = [NSArray arrayWithObjects:@"开启手势解锁", nil];
        }
    }
    return _titleArray;
}

-(UILabel *)backgroundLabel {
    if (!_backgroundLabel) {
        _backgroundLabel = [[UILabel alloc] init];
        _backgroundLabel.text = @"开启手势解锁后，离开瑞达国际5分钟后将需要手势解锁进入";
    }
    return _backgroundLabel;
}
@end
