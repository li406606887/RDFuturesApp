//
//  NewsTitleLabel.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsTitleLabel.h"

@implementation NewsTitleLabel


#define RGBRed 0
#define RGBGreen 0
#define RGBBlue 0

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
//        self.font = [UIFont rdSystemFontOfSize:13.0f];
        self.font = [UIFont systemFontOfSize:13.0f];
//        self.textColor = [UIColor colorWithRed:RGBRed green:RGBGreen blue:RGBBlue alpha:1.0];
        self.textColor = [UIColor blackColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor yellowColor];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

-(void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    CGFloat red = RGBRed + (0.164 - RGBRed) * scale;
    CGFloat green = RGBGreen + (0.678 - RGBGreen) * scale;
    CGFloat blue = RGBBlue + (0.91 - RGBBlue) * scale;
    /*
     red = 42;
     grenn = 173;
     blue = 234;
     */
    
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    CGFloat transfromScale = 1 + scale * 0.3;
    self.transform = CGAffineTransformMakeScale(transfromScale, transfromScale);
    
}

@end
