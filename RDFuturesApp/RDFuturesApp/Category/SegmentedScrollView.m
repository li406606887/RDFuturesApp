//
//  SegmentedScrollView.m
//  PolicyAide
//
//  Created by user on 2017/8/30.
//  Copyright © 2017年 QHTeam. All rights reserved.
//

#import "SegmentedScrollView.h"

@interface SegmentedScrollView ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scroll;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) NSMutableArray *btnArray;
@property(nonatomic,assign) CGFloat spacing;
@end

@implementation SegmentedScrollView
-(instancetype)initWithFrame:(CGRect)frame item:(NSArray *)items {
    if (self = [super initWithFrame:frame]) {
        self.itemArray = items;
        [self addSubview:self.scroll];
    }
    return self;
}

-(void)scrollItemClick:(UIButton *)button{
    int index = (int)button.tag;
    if (index == self.oldIndex) return;

    UIButton *oldbtn = self.btnArray[self.oldIndex];
    oldbtn.selected = NO;
    button.selected = YES;

    [UIView animateWithDuration:0.5 animations:^{
        self.line.x = index * self.spacing +15;
    } completion:nil];
    
    self.oldIndex = index;
    self.oldIndex = (int)button.tag;
    if (self.itemClick) self.itemClick(self.oldIndex);
    
    CGFloat offsetX;
    if (button.centerX > self.centerX) {
        if (self.scroll.contentSize.width-button.centerX<self.centerX) {
            offsetX = self.scroll.contentSize.width - SCREEN_WIDTH;
        } else {
            offsetX = button.centerX - self.centerX;
        }
    }else{
        offsetX = 0;
    }
    CGPoint offset = CGPointMake(offsetX, self.scroll.contentOffset.y);
    [self.scroll setContentOffset:offset animated:YES];
}

-(void)setSelectedIndex:(int)selectedIndex {
    UIButton*oldButton = self.btnArray[self.oldIndex];
    oldButton.selected = NO;
    UIButton*newButton = self.btnArray[selectedIndex];
    newButton.selected = YES;
    self.oldIndex = selectedIndex;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.line.x = selectedIndex * self.spacing +15;
    } completion:nil];
    
    CGFloat offsetX;
    if (newButton.centerX > self.centerX) {
        if (self.scroll.contentSize.width - newButton.centerX<self.centerX) {
            offsetX = self.scroll.contentSize.width - SCREEN_WIDTH;
        } else {
            offsetX = newButton.centerX - self.centerX;
        }
    }else{
        offsetX = 0;
    }
    CGPoint offset = CGPointMake(offsetX, self.scroll.contentOffset.y);
    [self.scroll setContentOffset:offset animated:YES];
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
}

-(void)setDefultTitleColor:(UIColor *)defultTitleColor {
    _defultTitleColor = defultTitleColor;
}

-(void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.line.backgroundColor = lineColor;

}

-(void)show {
    [self.scroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btnArray removeAllObjects];
    int i = 0;
    for (NSString *title in self.itemArray) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:i];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:self.defultTitleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(scrollItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:button];
        [self.scroll addSubview:button];
        button.selected = i == 0 ? YES : NO;
        [button setFrame:CGRectMake(self.spacing*i, 0, self.spacing, 30)];
        i++;
    }
    
    [self.scroll addSubview:self.line];
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(15, 33, self.spacing-30, 2)];
    }
    return _line;
}

-(UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scroll.delegate = self;
        _scroll.showsHorizontalScrollIndicator = NO;
    }
    return _scroll;
}

-(NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

-(int)oldIndex{
    if (!_oldIndex) {
        _oldIndex = 0;
    }
    return _oldIndex;
}

-(void)setItemArray:(NSArray *)itemArray {
    _itemArray = itemArray;
    self.spacing = SCREEN_WIDTH/4.57;
    self.scroll.contentSize = CGSizeMake(self.spacing*8, 0.5f);

}
@end
