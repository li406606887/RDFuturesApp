//
//  NewsContentScrollView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsContentScrollView.h"
#import "NewsFifthView.h"
#import "NewsSecondView.h"
#import "NewsThirdView.h"
#import "NewsFourthView.h"
#import "NewsFifthView.h"
#import "NewsSixthView.h"
#import "NewsSeventhView.h"
#import "NewsEighthView.h"
#import "NewsViewModel.h"

@interface NewsContentScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) NewsViewModel *viewModel;
@property (nonatomic ,strong) NewsFifthView * fisrt;
@property (nonatomic ,strong) NewsSecondView * second;
@property (nonatomic ,strong) NewsThirdView * third;
@property (nonatomic ,strong) NewsFourthView * fourth;
@property (nonatomic ,strong) NewsFifthView * fifth;
@property (nonatomic ,strong) NewsSixthView * sixth;
@property (nonatomic ,strong) NewsSeventhView * seventh;
@property (nonatomic ,strong) NewsEighthView * eighth;
@end

@implementation NewsContentScrollView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (NewsViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self.viewModel.didEndScrollSubject sendNext:[NSString stringWithFormat:@"%d",index]];
}

-(void)setupViews{
    self.delegate = self;
    [self addSubview:self.fisrt];
    [self addSubview:self.second];
    [self addSubview:self.third];
    [self addSubview:self.fourth];
    [self addSubview:self.fifth];
    [self addSubview:self.sixth];
    [self addSubview:self.seventh];
    [self addSubview:self.eighth];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)bindViewModel{
    [[self.viewModel.titleClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        CGPoint position = CGPointMake(([x intValue])*SCREEN_WIDTH, 0);
        [self setContentOffset:position animated:YES];
    }];
    
}
-(void)updateConstraints{
    [self.fisrt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.fisrt.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.third mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.second.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.fourth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.third.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.fifth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.fourth.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.sixth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.fifth.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.seventh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.sixth.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.eighth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.seventh.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [super updateConstraints];
}

-(NewsFifthView *)fisrt{
    if (!_fisrt) {
        _fisrt = [[NewsFifthView alloc]initWithViewModel:self.viewModel];
    }
    return _fisrt;
}
-(NewsSecondView *)second {
    if (!_second) {
        _second = [[NewsSecondView alloc]initWithViewModel:self.viewModel];
    }
    return _second;
}

-(NewsThirdView *)third {
    if (!_third) {
        _third = [[NewsThirdView alloc]initWithViewModel:self.viewModel];
    }
    return _third;
}

-(NewsFourthView *)fourth {
    if (!_fourth) {
        _fourth = [[NewsSecondView alloc]initWithViewModel:self.viewModel];
    }
    return _fourth;
}

-(NewsFifthView *)fifth {
    if (!_fifth) {
        _fifth = [[NewsFifthView alloc]initWithViewModel:self.viewModel];
    }
    return _fifth;
}

-(NewsSixthView *)sixth {
    if (!_sixth) {
        _sixth = [[NewsSixthView alloc]initWithViewModel:self.viewModel];
    }
    return _sixth;
}

-(NewsSeventhView *)seventh {
    if (!_seventh) {
        _seventh = [[NewsSeventhView alloc]initWithViewModel:self.viewModel];
    }
    return _seventh;
}

-(NewsEighthView *)eighth {
    if (!_eighth) {
        _eighth = [[NewsEighthView alloc]initWithViewModel:self.viewModel];
    }
    return _eighth;
}
@end
