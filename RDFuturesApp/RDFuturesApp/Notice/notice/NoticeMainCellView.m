//
//  NoticeMainCellView.m
//  RDFuturesApp
//
//  Created by user on 17/5/4.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeMainCellView.h"
#import "NoticeViewModel.h"
#define kWidth SCREEN_WIDTH-40

@interface NoticeMainCellView()
@property(nonatomic,strong)NoticeViewModel *viewModel;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *title;

@end

@implementation NoticeMainCellView

-(void)setupViews{
    [self addSubview:self.icon];
    [self addSubview:self.bgView];
    [self addSubview:self.title];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [self.viewModel.cellClickSubject sendNext:_model];
    }];
    [self addGestureRecognizer:tap];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (NoticeViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)updateConstraints{
    WS(weakself)
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.icon.mas_bottom);
        make.size.mas_offset(CGSizeMake(kWidth, 48.5));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.bgView).with.mas_offset(UIEdgeInsetsMake(5, 10, 5, 10));
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
        _icon.image = [UIImage imageNamed:@"loading_image_loading"];
        _icon.backgroundColor = [UIColor whiteColor];
        _icon.contentMode = UIViewContentModeScaleAspectFill;

    }
    return _icon;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor whiteColor];        
        _title.numberOfLines = 0;
        _title.font = [UIFont rdSystemFontOfSize:17];
    }
    return _title;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.alpha = 0.4;
        _bgView.backgroundColor = [UIColor blackColor];
    }
    return _bgView;
}
@end
