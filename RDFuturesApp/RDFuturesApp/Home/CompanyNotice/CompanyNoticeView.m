//
//  CompanyNoticeView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "CompanyNoticeView.h"
#import "CompanyNoticeCell.h"
#import "CompanyNoticeViewModel.h"
#import "CompanyNoticeModel.h"

@interface CompanyNoticeView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) CompanyNoticeViewModel * viewModel;
@end

@implementation CompanyNoticeView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{

    self.viewModel = (CompanyNoticeViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)setupViews{

    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    WS(weakself)
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

-(void)layoutSubviews{

}

-(void)bindViewModel{
    
    [self.viewModel.refreshDataCommand execute:nil];
    
    [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
    }];
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id  _Nullable x) {
        
        [self.tableView reloadData];
        
        switch ([x integerValue]) {
            case HeaderRefresh_HasMoreData:
                [self.tableView.mj_header endRefreshing];
                if (!self.tableView.mj_footer) {
                    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        [self.viewModel.refreshDataCommand execute:nil];
                    }];
                }
                break;
            case HeaderRefresh_HasNoMoreData:
                [self.tableView.mj_header endRefreshing];
                self.tableView.mj_footer = nil;
                
                break;
            case FooterRefresh_HasMoreData:{
            
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView.mj_footer endRefreshing];
            
            }
                break;
            case FooterRefresh_HasNoMoreData:{
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
            }
                break;
            case RefreshError:{
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }
                break;
            default:
                break;
        }
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CompanyNoticeModel* model = [CompanyNoticeModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row   ]];
    NSString * string = [NSString stringWithFormat:@"%@",model.content_url];
    [self.viewModel.cellClick sendNext:string];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyNoticeCell * cell = [tableView dequeueReusableCellWithIdentifier:kCompanyNoticeCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.viewModel.dataArray.count > indexPath.row) {
        CompanyNoticeModel * model = [CompanyNoticeModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row]];
        cell.model = model;
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewModel.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150;
}

-(UITableView *)tableView{
    WS(weakself)
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(230, 230, 230);
        [_tableView registerNib:[UINib nibWithNibName:kCompanyNoticeCell bundle:nil] forCellReuseIdentifier:kCompanyNoticeCell];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.viewModel.refreshDataCommand execute:nil];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.viewModel.nextPageCommand execute:nil];
        }];
    }
    return _tableView;
}

@end
