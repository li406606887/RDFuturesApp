//
//  NewsSeventhView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsSeventhView.h"
#import "RDCommon.h"
#import "NewsViewModel.h"
#import "NewsTableViewCell.h"
#import "NewsListModel.h"

@interface NewsSeventhView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NewsViewModel* viewModel;

@property (nonatomic, assign) int page;
@end
@implementation NewsSeventhView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (NewsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)bindViewModel{
    @weakify(self)
    [self.viewModel.refreshSeventhSubject subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
        if ([x intValue]) {
            self.page--;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    [self.tableView.mj_header beginRefreshing];
}


-(void)updateConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}
#pragma mark - 代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([NewsTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.seventhDataArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.seventhDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsListModel * model = self.viewModel.seventhDataArray[indexPath.row];
    NSString * string = [NSString stringWithFormat:@"%@",model.newsUrl];
    [self.viewModel.cellClickSubject sendNext:string];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([NewsTableViewCell class])]];
        WS(weakself)
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [weakSelf.viewModel.getSeventhDataCommand execute:nil];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.page ++;
            [weakSelf.viewModel.getSeventhDataCommand execute:[NSString stringWithFormat:@"%d",self.page]];
        }];
    }
    return _tableView;
}

@end
