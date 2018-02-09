//
//  NewsTitleScrollView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsTitleScrollView.h"
#import "NewsViewModel.h"

#define offectX xVlaue*(SCREEN_WIDTH/4.57 + 1.5) + ((SCREEN_WIDTH/4.57)- 35)/2

@interface NewsTitleScrollView()<UIScrollViewDelegate>{
    int xVlaue;
}
@property(nonatomic,strong) NewsViewModel *viewModel;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) UISegmentedControl * segment;

@property(assign,nonatomic) CGFloat kWidth;
@end

@implementation NewsTitleScrollView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (NewsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.segment];
    [self.scrollView addSubview:self.lineView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView);
        make.size.mas_offset(CGSizeMake(self.kWidth*8, 33.5));
    }];
    
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segment.mas_bottom);
        make.left.equalTo(self.scrollView).with.offset(self.kWidth/2-19);
        make.size.mas_equalTo(CGSizeMake(38, 1.5));
    }];
}

-(void)bindViewModel{
    [[self.viewModel.titleClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        self.segment.selectedSegmentIndex = [x intValue];
        xVlaue = [x intValue];

//        switch ([x intValue]) {
//            case 0: {
//                CGPoint position = CGPointMake(0, 0);
//
//                [self setContentOffset:position animated:YES];
//            }
//                break;
//            case 1: {
//                CGPoint position = CGPointMake(0, 0);
//
//                [self setContentOffset:position animated:YES];
//            }
//                break;
//            case 2: {
//                CGPoint position = CGPointMake(0, 0);
//
//                [self setContentOffset:position animated:YES];
//            }
//                break;
//            case 3: {
//                //根据内容滚动值第几个vc  来使title滚动
//                CGPoint position = CGPointMake(SCREEN_WIDTH/4.57, 0);
//
//                [self setContentOffset:position animated:YES];
//            }
//                break;
//            case 4: {
//                //根据内容滚动值第几个vc  来使title滚动
//                CGPoint position = CGPointMake((SCREEN_WIDTH/4.57)*2, 0);
//
//                [self setContentOffset:position animated:YES];
//            }
//                break;
//            case 5: {
//                //根据内容滚动值第几个vc  来使title滚动
//                CGPoint position = CGPointMake((SCREEN_WIDTH/4.57)*3, 0);
//
//                [self setContentOffset:position animated:YES];
//            }
//                break;
//            case 6: {
//                //根据内容滚动值第几个vc  来使title滚动
//                CGPoint position = CGPointMake((SCREEN_WIDTH/4.57)*3.5, 0);
//
//                [self setContentOffset:position animated:YES];
//            }
//                break;
//            case 7: {
//                //根据内容滚动值第几个vc  来使title滚动
//                CGPoint position = CGPointMake((SCREEN_WIDTH/4.57)*3.5, 0);
//
//                [self setContentOffset:position animated:YES];
//            }
//                break;
//
//            default:
//                break;
//        }
    }];

}


-(void)tapWithtag:(NSString *)string{
    [self.viewModel.titleClickSubject sendNext:string];
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = RGB(216, 1, 1);
    }
    return _lineView;
}

-(UISegmentedControl *)segment {
    if (!_segment) {
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"要闻",@"股指",@"债券",@"外汇",@"贵金属",@"农产品",@"有色金属",@"能源化工",nil];
        _segment = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        _segment.tintColor = [UIColor blackColor];
        _segment.layer.borderWidth = 4;
        _segment.layer.masksToBounds = YES;
        _segment.layer.borderColor = [UIColor whiteColor].CGColor;
        // 设置UISegmentedControl选中的图片
        [_segment setBackgroundImage:[UIImage imageNamed:@"kuang"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        // 正常的图片
        [_segment setBackgroundImage:[UIImage imageNamed:@"kuang"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        [_segment setDividerImage:[UIImage imageNamed:@"white_bar"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        // 设置选中的文字颜色
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName: RGB(0, 0, 0)} forState:UIControlStateSelected];
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName: RGB(51, 51, 51)} forState:UIControlStateNormal];
        _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

-(void)segmentClick:(UISegmentedControl *)seg {
    NSInteger index = seg.selectedSegmentIndex;
    xVlaue = (short)index;
    CGFloat offsetX = self.kWidth*index +self.kWidth/2 - 19;
    NSString * str = [NSString stringWithFormat:@"%ld",(long)index];
    [self.viewModel.titleClickSubject sendNext:str];
    [self updateLineView:offsetX];
}

-(void)updateLineView:(CGFloat )offset {
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offset);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

-(CGFloat)kWidth {
    if (!_kWidth) {
        _kWidth = SCREEN_WIDTH/4.57;
    }
    return _kWidth;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentSize = CGSizeMake(self.kWidth*8, 1.0f);
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}
@end
