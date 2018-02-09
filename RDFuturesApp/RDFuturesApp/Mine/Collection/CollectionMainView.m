//
//  CollectionMainView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/26.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "CollectionMainView.h"
#import "CollectionViewModel.h"
#import "CollectionTableViewCell.h"
#import "CollectionModel.h"



@interface CollectionMainView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic,strong) CollectionViewModel * viewModel;
@end



@implementation CollectionMainView


-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    
    self.viewModel = (CollectionViewModel*)viewModel;
    
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
//        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(7.5, 0, 0, 0));
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
                
            case FooterRefresh_HasMoreData:
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                
                break;
                
            case FooterRefresh_HasNoMoreData:
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
                
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CollectionTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:kCollectionTableViewCell];
    
    
    if (self.viewModel.dataArray.count >indexPath.row) {
        CollectionModel * model = [CollectionModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row]];
        cell.model = model;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewModel.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 75;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    CollectionModel * model = [CollectionModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row]];
    NSString * string = [NSString stringWithFormat:@"%@",model.contentUrl];
    [self.viewModel.cellClick sendNext:string];
}
-(UITableView *)tableView{
    WS(weakself)
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:kCollectionTableViewCell bundle:nil] forCellReuseIdentifier:kCollectionTableViewCell];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
         UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 7.5)];
        headerView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.tableHeaderView = headerView;
        
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.viewModel.refreshDataCommand execute:nil];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.viewModel.nextPageCommand execute:nil];
        }];
    };
    return _tableView;
}


@end
