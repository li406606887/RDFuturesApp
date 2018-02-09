//
//  NoticeTableCell.m
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeTableCell.h"
#import "NoticeCellView.h"
#import "NoticeMainCellView.h"


#define kWidth SCREEN_WIDTH-40
#define kMainHeight (SCREEN_WIDTH-40)*0.559

@interface NoticeTableCell()
@property(nonatomic,strong)UIView *bgView;//背景View;
@property(nonatomic,strong)NoticeMainCellView *noticeMainView;
@property(nonatomic,strong)NoticeCellView *noticeFirstView;
@property(nonatomic,strong)NoticeCellView *noticeSecondView;
@property(nonatomic,strong)NoticeCellView *noticeThirdView;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)NSMutableArray *modelArray;
@end

@implementation NoticeTableCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)updateConstraints{
    WS(weakself)
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(30, 20, 10, 20));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).with.offset(5);
        make.centerX.equalTo(weakSelf.contentView);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    [self.noticeMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.bgView);
        make.size.mas_offset(CGSizeMake(kWidth, kMainHeight));
    }];
    [self.noticeFirstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.noticeMainView.mas_bottom);
        make.size.mas_offset(CGSizeMake(kWidth, 65));
    }];
    [self.noticeSecondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.noticeFirstView.mas_bottom).with.offset(1);
        make.size.mas_offset(CGSizeMake(kWidth, 65));
    }];
    [self.noticeThirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.noticeSecondView.mas_bottom).with.offset(1);;
        make.size.mas_offset(CGSizeMake(kWidth, 65));
    }];
    
    [super updateConstraints];

}

-(void)setArray:(NSArray *)array{
    [self loadSubView];
    if (array) {
        for (int i = 0; i<array.count; i++) {
            NoticeModel *model = [NoticeModel mj_objectWithKeyValues:array[i]];
            switch (i) {
                case 0:
                    self.noticeMainView.model = model;
//                    self.timeLabel.text = [NSDate changeTheNoticeTime:model.create_time];
                    self.timeLabel.text = model.create_time;
                    break;
                case 1:
                    self.noticeFirstView.model = model;
                    break;
                case 2:
                    self.noticeSecondView.model = model;
                    break;
                case 3:
                    self.noticeThirdView.model = model;
                    break;
                    
                default:
                    break;
            }
        }
    }
   
    
    
}
-(void)loadSubView{
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.timeLabel];
    [self.bgView addSubview:self.noticeMainView];
    [self.bgView addSubview:self.noticeFirstView];
    [self.bgView addSubview:self.noticeSecondView];
    [self.bgView addSubview:self.noticeThirdView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setBackgroundColor:[UIColor clearColor]];
}

-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return _modelArray;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 5;

    }
    return _bgView;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont rdSystemFontOfSize:fourteenFontSize];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor darkGrayColor];
    }
    return _timeLabel;
}
-(NoticeMainCellView *)noticeMainView{
    if (!_noticeMainView) {
        _noticeMainView = [[NoticeMainCellView alloc] initWithViewModel:self.viewModel];
    }
    return _noticeMainView;
}
-(NoticeCellView *)noticeFirstView{
    if (!_noticeFirstView) {
        _noticeFirstView = [[NoticeCellView alloc] initWithViewModel:self.viewModel];
    }
    return _noticeFirstView;
}
-(NoticeCellView *)noticeSecondView{
    if (!_noticeSecondView) {
        _noticeSecondView = [[NoticeCellView alloc] initWithViewModel:self.viewModel];
    }
    return _noticeSecondView;
}
-(NoticeCellView *)noticeThirdView{
    if (!_noticeThirdView) {
        _noticeThirdView = [[NoticeCellView alloc] initWithViewModel:self.viewModel];
    }
    return _noticeThirdView;
}
@end
