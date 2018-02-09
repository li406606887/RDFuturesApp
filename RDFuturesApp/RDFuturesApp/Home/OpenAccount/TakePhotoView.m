//
//  TakePhotoView.m
//  RDFuturesApp
//
//  Created by user on 17/3/15.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "TakePhotoView.h"

@implementation TakePhotoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {

        [self setBackgroundColor:[UIColor whiteColor]];
        UIImage *image = [UIImage imageNamed:@"take_photo_warning"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 250)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImage:image];
        [self addSubview:imageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, getTop(imageView), viewWidth-20, 30)];
        title.font = [UIFont rdSystemFontOfSize:16];
        [title setText:@"接下来需要你按指定动作拍摄三张照片"];
        [self addSubview:title];
        
        UILabel *context = [[UILabel alloc] initWithFrame:CGRectMake(10, getTop(title), viewWidth-20, 80)];
        context.font = [UIFont rdSystemFontOfSize:16];
        [context setText:@"1、确认周边环境光线充足柔和；\n2、确保人脸出现在照片里，请勿遮挡脸部；\n3、请使用拍照功能上传即时拍摄的照片。"];
        context.numberOfLines = 0;
        [self addSubview:context];
        
        UIButton *dissmissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [dissmissBtn setFrame:CGRectMake(20, getTop(context)+30, viewWidth-40, 45)];
        [dissmissBtn setBackgroundColor:[UIColor blueColor]];
        [dissmissBtn setTitle:@"开始" forState:UIControlStateNormal];
        dissmissBtn.layer.masksToBounds = YES;
        dissmissBtn.layer.cornerRadius = 5;
        [dissmissBtn addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dissmissBtn];
    }
    
    return self;
}
-(void)dissmiss{
    [self removeFromSuperview];
}
@end
