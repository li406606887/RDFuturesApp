//
//  NoticeCellView.m
//  RDFuturesApp
//
//  Created by user on 17/5/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeCellView.h"
#import "NoticeViewModel.h"

#define kTitleWidth SCREEN_WIDTH-120


@interface NoticeCellView()
@property(nonatomic,strong)NoticeViewModel *viewModel;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *title;
@end

@implementation NoticeCellView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (NoticeViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)setupViews{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.icon];
    [self addSubview:self.title];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [self.viewModel.cellClickSubject sendNext:_model];
    }];
    [self addGestureRecognizer:tap];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    WS(weakself)
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(10);
        make.size.mas_offset(CGSizeMake(45, 45));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.icon.mas_right).with.offset(15);
        make.size.mas_offset(CGSizeMake(kTitleWidth, 45));
    }];
    [super updateConstraints];
}
-(void)setModel:(NoticeModel *)model{
    if (model) {
        _model = model;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"loading_image_loading"]];
        self.title.text = model.title;
    }
}
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor clearColor];
        _icon.contentMode = UIViewContentModeScaleToFill;

    }
    return _icon;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.numberOfLines = 0;
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont rdSystemFontOfSize:fifteenFontSize];
    }
    return _title;
}

@end
