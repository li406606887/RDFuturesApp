
//
//  AdvertisementLabel.m
//  RDFuturesApp
//
//  Created by user on 2017/5/21.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AdvertisementLabel.h"

@interface AdvertisementLabel()

@property (nonatomic, strong) NSTimer *timer;

@end


@implementation AdvertisementLabel
- (void)dealloc {
    
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 16;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.text = @"4秒后跳转";
        self.textColor = [UIColor darkGrayColor];
        self.font = [UIFont systemFontOfSize:10];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleTap];

        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(jumpNewViewController) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
        //开始循环
        [self.timer fire];
    }
    return self;
}

#pragma mark --- 响应倒计时的方法
- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    if (self.blockNewViewController) {
        [self.timer invalidate];
        self.timer = nil;
        self.blockNewViewController();
    }
}

- (void)jumpNewViewController {
    
    static int z = 0;
    z ++;
    if (z<4) {
        self.text = [NSString stringWithFormat:@"%d秒后跳转",4-z];

    }
    
    if (z == 4) {
        if (self.blockNewViewController) {
            self.text = [NSString stringWithFormat:@"正在跳转..."];
            [self.timer invalidate];
            self.timer = nil;
            self.blockNewViewController();
        }
    }
}

@end
