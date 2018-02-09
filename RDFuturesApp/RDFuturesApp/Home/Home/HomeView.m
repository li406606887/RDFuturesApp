//
//  HomeView.m
//  RDFuturesApp
//
//  Created by user on 17/3/1.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "HomeView.h"
#import "HomeViewModel.h"
#import "HomeScrollView.h"
#import "HomeItemView.h"
#import "RDCommon.h"
#import "HomeTableViewCell.h"


#define kHeadHeight SCREEN_WIDTH*0.453 +3

#define kScrollHeight SCREEN_WIDTH*0.453

@interface HomeView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;//

@property(nonatomic,strong)HomeScrollView *headScrollView;

@property(nonatomic,strong)HomeItemView *homeItemView;

@property(nonatomic,strong)HomeViewModel *homeviewModel;

@property(nonatomic,strong)UIView *headView;//头部视图

@property(nonatomic,strong)UIView *footView;//尾部视图

@end

@implementation HomeView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    
    self.homeviewModel = (HomeViewModel *)viewModel;
    
    return [super initWithViewModel:viewModel];
    
}
-(void)setupViews{
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}


-(void)bindViewModel{
    WS(weakself)
    [self.homeviewModel.refreshDataCommand execute:nil];
    [self.homeviewModel.refreshUI subscribeNext:^(id x) {
        [weakSelf.headScrollView refreshData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    }];
    
    
    
}

-(void)layoutSubviews{
    
}
-(void)updateConstraints{
    WS(weakself)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
        
    }];
    
    [self.headScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.headView);
        make.top.equalTo(weakSelf.headView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, kScrollHeight));
    }];
    
    
    
    [self.homeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.footView);
        make.top.equalTo(weakSelf.footView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH));
    }];
    
    
    [super updateConstraints];
}

#pragma mark  tableview的代理事件
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([HomeTableViewCell class])] forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.homeviewModel.cellClickSubject sendNext:nil];
}


#pragma mark  懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        WS(weakself)
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setTableHeaderView:self.headView];
        [_tableView setTableFooterView:self.footView];
        [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([HomeTableViewCell class])]];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.homeviewModel.refreshDataCommand execute:nil];
        }];
        
    }
    return _tableView;
}
-(HomeScrollView *)headScrollView{
    if (!_headScrollView) {
        _headScrollView = [[HomeScrollView alloc] initWithViewModel:self.homeviewModel];
        [_headScrollView setBackgroundColor:[UIColor greenColor]];
    }
    return _headScrollView;
}
-(HomeItemView *)homeItemView{
    if (!_homeItemView) {
        _homeItemView = [[HomeItemView alloc] initWithViewModel:self.homeviewModel];
        _homeItemView.backgroundColor = [UIColor whiteColor];
    }
    return _homeItemView;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadHeight)];
        [_headView addSubview:self.headScrollView];
    }
    return _headView;
}
-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 294)];
        [_footView addSubview:self.homeItemView];
    }
    return _footView;
}
@end
