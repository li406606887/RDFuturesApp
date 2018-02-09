



//
//  RDNoticeView.m
//  RDFuturesApp
//
//  Created by user on 2017/5/12.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDNoticeView.h"
#import "RDNoticeTableViewCell.h"
#import "RDNoticeModel.h"
#import "RDNoticeViewModel.h"

@interface RDNoticeView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)RDNoticeViewModel *viewModel;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)NSArray *titleArray;
@end

@implementation RDNoticeView

-(void)setupViews{
    [self addSubview:self.table];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{
    
    WS(weakself)
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
        
    }];
    
    [super updateConstraints];
}
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (RDNoticeViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.dateArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RDNoticeModel *notice =self.viewModel.dateArray[indexPath.row];
    CGSize size = [UILabel textForFont:fourteenFontSize andMAXSize:CGSizeMake(SCREEN_WIDTH-80, MAXFLOAT) andText:notice.content];
    int height = size.height+76;
    return height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RDNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([RDNoticeTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dateArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RDNoticeModel *notice =self.viewModel.dateArray[indexPath.row];
    switch ([notice.sign intValue]) {
        case 1:
            [self.viewModel.cellClickSubject sendNext:notice.sign];
            break;
        default:
            break;
    }
}
-(void)bindViewModel{

    [self.viewModel.reloadDataCommand execute:nil];
    [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
        [self.table reloadData];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSArray arrayWithObjects:@"",@"", nil];
    }
    return _imageArray;
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"",@"", nil];
    }
    return _titleArray;
}
-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[RDNoticeTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([RDNoticeTableViewCell class])]];
    }
    return _table;
}
@end
