//
//  SegmentedScrollView.h
//  PolicyAide
//
//  Created by user on 2017/8/30.
//  Copyright © 2017年 QHTeam. All rights reserved.
//

#import "BaseView.h"

@interface SegmentedScrollView : UIView
@property(nonatomic,copy)void (^itemClick)(int index);
-(instancetype)initWithFrame:(CGRect)frame item:(NSArray *)items;
@property(nonatomic,assign) int selectedIndex;
@property(nonatomic,strong) UIColor *defultTitleColor;//默认标题颜色
@property(nonatomic,strong) UIColor *selectedTitleColor;//选中标题颜色
@property(nonatomic,strong) UIColor *lineColor;//选中标题颜色
@property(nonatomic,assign) CGFloat font;//字号大小
@property(nonatomic,assign) int  oldIndex;
@property(nonatomic,strong) NSArray *itemArray;
-(void)show;
@end
