//
//  NoticeView.m
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeView.h"
#import "NoticeViewModel.h"
#import "NoticeTableCell.h"
#import "NoticeModel.h"


#define kCellHeight  (SCREEN_WIDTH-40)*0.559+10+30+65+65+65+2;

#define kCellHeight2 (SCREEN_WIDTH-40)*0.559+10+30+65+65+1;

#define kCellHeight3 (SCREEN_WIDTH-40)*0.559+10+30+65;

#define kCellHeight4 (SCREEN_WIDTH-40)*0.559+10+30;

@interface NoticeView()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NoticeViewModel *noticeViewModel;
@end

@implementation NoticeView
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    
    self.noticeViewModel = (NoticeViewModel *)viewModel;
    
    return [super initWithViewModel:viewModel];
    
}
-(void)setupViews{
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.noticeViewModel.dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoticeTableCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([NoticeTableCell class])] forIndexPath:indexPath];
    cell.viewModel = (NoticeViewModel*)self.noticeViewModel;
    
    if (self.noticeViewModel.dataArray) {
        cell.array = self.noticeViewModel.dataArray[indexPath.row];

    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self scrollBottom];
    });
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array  = self.noticeViewModel.dataArray[indexPath.row];
    switch (array.count) {
        case 1:
            return kCellHeight4;
            
            break;
        case 2:
            return kCellHeight3;

            break;
        case 3:
            return kCellHeight2;
            
            break;
        case 4:
            return kCellHeight;
            
            break;
        default:
            break;
    }
    
    return kCellHeight;
    
}

-(void)bindViewModel{
    @weakify(self);
    [self.noticeViewModel.refreshDataCommand execute:nil];
    [self.noticeViewModel.refreshUI subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        
    }];

    
    [self.noticeViewModel.refreshEndSubject subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        switch ([x integerValue]) {
            case HeaderRefresh_HasMoreData:
                [self.tableView.mj_header endRefreshing];
                
                if (!self.tableView.mj_footer) {
                    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        @strongify(self)
                        
                        [self.noticeViewModel.refreshDataCommand execute:nil];
                        
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)scrollBottom{
    if ([self.noticeViewModel.dataArray count]) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.noticeViewModel.dataArray.count-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}
-(void)updateConstraints{
    [super updateConstraints];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[NoticeTableCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([NoticeTableCell class])]];
        WS(weakself)
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.noticeViewModel.nextPageCommand execute:nil];
        }];
    }
    return _tableView;
}
@end
