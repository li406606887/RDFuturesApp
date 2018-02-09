//
//  BillMainView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/27.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BillMainView.h"
#import "BillViewModel.h"
#import "BillTableViewCell.h"
#import "BillModel.h"
#import "BillfooterView.h"

@interface BillMainView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) BillViewModel *viewModel;

@property (nonatomic,strong) BillfooterView * footerView;

@end


@implementation BillMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel
{
    self.viewModel = (BillViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews{

    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)layoutSubviews{

}
-(void)updateConstraints{

    WS(weakself)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
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
                
                _footerView = [[BillfooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
                _tableView.tableFooterView = _footerView;
            }
                break;
                
            case FooterRefresh_HasNoMoreData:{
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
            }
                break;
            case RefreshError:
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_header endRefreshing];
                break;
                
            default:
                break;
        }

        
    }];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BillTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBillTableViewCell];
    
    if (self.viewModel.dataArray.count > indexPath.row) {
        BillModel * model = [BillModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row]];
        cell.model = model;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewModel.dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BillModel * model = [BillModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row]];
    NSString * string = [NSString stringWithFormat:@"%@",model.billUrl];
    [self.viewModel.cellClick sendNext:string];
    
}

//-(BillfooterView *)footerView{
//
//    if (!_footerView) {
//        _footerView = [[BillfooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    }
//    return _footerView;
//
//}

-(UITableView *)tableView{

    WS(weakself)
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:kBillTableViewCell bundle:nil] forCellReuseIdentifier:kBillTableViewCell];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.viewModel.refreshDataCommand execute:nil];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.viewModel.nextPageCommand execute:nil];
        }];
        
//        BillfooterView * footerView = [[BillfooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//        _tableView.tableFooterView = footerView;
        
    }
    return _tableView;
}
@end
