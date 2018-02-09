


//
//  MessageView.m
//  RDFuturesApp
//
//  Created by user on 17/5/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MessageView.h"
#import "MessageTableViewCell.h"
#import "MessageViewModel.h"




@interface MessageView()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)MessageViewModel *viewModel;
@end


@implementation MessageView

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
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (MessageViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)bindViewModel{
    [self.viewModel.reloadDataCommand execute:nil];
    [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
    }];
    [self.viewModel.refreshTable subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];

    }];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MessageTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    [self.viewModel.cellClickSubject sendNext:index];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MessageTableViewCell class])]];
        
    }
    return _tableView;;
}
@end
