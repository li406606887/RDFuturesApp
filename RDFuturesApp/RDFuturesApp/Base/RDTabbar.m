//
//  RDTabbar.m
//  RDFuturesApp
//
//  Created by user on 17/5/7.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDTabbar.h"

@implementation RDTabbar
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        [self setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f]];

        [self setBarTintColor:[UIColor colorWithRed:44.0/255.0 green:44.0/255.0 blue:44.0/255.0 alpha:1.0f]];
        self.translucent = NO;
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
