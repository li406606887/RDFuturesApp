//
//  NewsThirdView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsThirdView.h"
#import "RDCommon.h"
#import "NewsTableViewCell.h"
#import "NewsListModel.h"
#import "NewsViewModel.h"

@interface NewsThirdView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic,strong) NewsViewModel * viewModel;

@property (nonatomic,assign) int page;
@end

@implementation NewsThirdView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (NewsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark 添加view
-(void)setupViews{
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
#pragma mark 第一次加载处理viewModel的事件
-(void)bindViewModel{
    @weakify(self)
    [self.viewModel.refreshThirdSubject subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
        if ([x intValue]!=1) {
            self.page--;
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark  更新约束
-(void)updateConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}


#pragma mark - 代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([NewsTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.thirdDataArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.thirdDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListModel * model = self.viewModel.thirdDataArray[indexPath.row];
    NSString * string = [NSString stringWithFormat:@"%@",model.newsUrl];
    [self.viewModel.cellClickSubject sendNext:string];
}

#pragma mark  懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([NewsTableViewCell class])]];
        WS(weakself)
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [weakSelf.viewModel.getThirdDataCommand execute:@"1"];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.page++;
            [weakSelf.viewModel.getThirdDataCommand execute:[NSString stringWithFormat:@"%d",self.page]];
        }];
    }
    return _tableView;
}

@end
