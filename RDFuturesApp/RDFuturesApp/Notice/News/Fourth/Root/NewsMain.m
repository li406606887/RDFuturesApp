//
//  NewsMain.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsMain.h"
#import "NewsViewModel.h"
#import "NewsTitleScrollView.h"
#import "NewsContentScrollView.h"
#import "SegmentedScrollView.h"

@interface NewsMain()<UIScrollViewDelegate>

@property (nonatomic ,strong)NewsViewModel * viewModel;

@property (nonatomic ,strong)SegmentedScrollView * titleScrollView;
@property (nonatomic ,strong)NewsContentScrollView * contentScrollView;

@end
@implementation NewsMain

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{

    self.viewModel = (NewsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews{
    [self addSubview:self.titleScrollView];
    [self addSubview:self.contentScrollView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 35));
    }];
    
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(35);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-45));
    }];
    
    [super updateConstraints];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.didEndScrollSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.titleScrollView setSelectedIndex:[x intValue]];
    }];
}

-(NewsContentScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[NewsContentScrollView alloc]initWithViewModel:self.viewModel];
        _contentScrollView.contentSize = CGSizeMake(8*[UIScreen mainScreen].bounds.size.width, 0);
        _contentScrollView.pagingEnabled = YES;
    }
    return _contentScrollView;
}

-(SegmentedScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView = [[SegmentedScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35) item:[NSArray arrayWithObjects:@"要闻",@"股指",@"债券",@"外汇",@"贵金属",@"农产品",@"有色金属",@"能源化工", nil]];
        _titleScrollView.selectedTitleColor = [UIColor blackColor];
        _titleScrollView.defultTitleColor = RGB(51, 51, 51);
        _titleScrollView.lineColor = [UIColor redColor];
        _titleScrollView.font = 15.0f;
        [_titleScrollView show];
        @weakify(self)
        _titleScrollView.itemClick = ^(int index) {
            @strongify(self)
            [self.viewModel.titleClickSubject sendNext:[NSString stringWithFormat:@"%d",index]];
        };
    }
    return _titleScrollView;
}
@end
