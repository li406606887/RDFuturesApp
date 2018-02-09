//
//  GuidanceView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//
#define kScrollHeight SCREEN_WIDTH*0.453
#import "GuidanceView.h"
#import "OpenAccountFileCell.h"
static CGFloat kTransitionDuration = 0.3;
@interface GuidanceView ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) UIImageView * bgView;
@property(nonatomic,strong) UIImageView * bgView1;
@property(nonatomic,strong) UIImageView * bgView2;
@property(nonatomic,strong) UIImageView * bgView3;
@property (nonatomic,strong) UIPageControl * pageControl;
@property (nonatomic,assign) int clickCount;
@end
@implementation GuidanceView
-(id)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(id)initWithGuidanceOfScroll{

    self = [super init];
    if (self) {
        WS(weakself)
        
        //滚动引导
        self.scrollView = [[UIScrollView alloc]init];
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.edges.equalTo(weakSelf);
        }];
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*4, SCREEN_HEIGHT);
        self.scrollView.bounces = YES;
        self.scrollView.pagingEnabled = YES;

        self.bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.bgView.image = [UIImage imageNamed:@"guidance_adv"];
        [self.scrollView addSubview:self.bgView];
        self.bgView.contentMode = UIViewContentModeScaleAspectFill;

        self.bgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.bgView1.image = [UIImage imageNamed:@"guidance_business"];
        [self.scrollView addSubview:self.bgView1];
        self.bgView1.contentMode = UIViewContentModeScaleAspectFill;

        self.bgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.bgView2.image = [UIImage imageNamed:@"guidance_box_new"];
        [self.scrollView addSubview:self.bgView2];
        self.bgView2.contentMode = UIViewContentModeScaleAspectFill;

        self.bgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.bgView3.image = [UIImage imageNamed:@"guidance_notice_new"];
        [self.scrollView addSubview:self.bgView3];
        self.bgView3.contentMode = UIViewContentModeScaleAspectFill;

        self.bgView3.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goonAction:) ];
        [self.bgView3 addGestureRecognizer:tap];

        //设置视图上的小圆点
        _pageControl = [[UIPageControl alloc] init];

        _pageControl.numberOfPages = 4;
        _pageControl.currentPage = 0;
         [self addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(weakSelf).with.offset(-20);
            make.centerX.equalTo(weakSelf);
            make.height.mas_offset(30);
        }];

        
    }
    return self;

}
-(id)initWithGuidanceOfClick{
    
    self = [super init];
    if (self) {
        WS(weakself)
        
        self.bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guidance_adv"]];
        [self addSubview:self.bgView];
        self.bgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        self.bgView.userInteractionEnabled = YES;
        self.bgView.hidden = NO;

        self.clickCount = 1;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap)];

        [self.bgView addGestureRecognizer:tap];

        
    }
    return self;
}
-(void)imageTap{

//    self.bgView.hidden = YES;
//    self.bgView1.hidden = NO;
    
    switch (self.clickCount) {
        case 1:
        {
            self.bgView.image = [UIImage imageNamed:@"guidance_business"];
        }
            break;
        case 2:
        {
            self.bgView.image = [UIImage imageNamed:@"guidance_box_new"];
        }
            break;
        case 3:
        {
            self.bgView.image = [UIImage imageNamed:@"guidance_notice_new"];
        }
            break;
        case 4:
        {
            [self dismissAlert];
        }
            break;
            
        default: [self dismissAlert];
            break;
    }
    self.clickCount ++;
}
-(void)imageTap1{
    self.bgView.hidden = YES;
    self.bgView1.hidden = YES;
    self.bgView2.hidden = NO;
}
-(void)imageTap2{
    self.bgView.hidden = YES;
    self.bgView1.hidden = YES;
    self.bgView2.hidden = YES;
    self.bgView3.hidden = NO;
}
-(void)imageTap3{
    
    [self dismissAlert];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    //    NSLog(@"%d", page);
    
    // 设置页码
    _pageControl.currentPage = page;
}

-(void)closeBtnClick:(id)sender{
    [self dismissAlert];
}


#pragma mark - 继续按钮
-(void)goonAction:(id )sender
{
    //代码块回掉
    
    if (self.goonBlock) {
        self.goonBlock();
        
    }
    [self dismissAlert];
}

/*
 * 展示自定义AlertView
 */
- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(0,0, SCREEN_WIDTH , SCREEN_HEIGHT);
    self.backgroundColor = [UIColor whiteColor];
    self.alpha = 1.0f;

    [topVC.view addSubview:self];
}


- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor whiteColor];
        self.backImageView.alpha = 1.0f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    
    // 一系列动画效果,达到反弹效果
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.05, 0.05);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceAnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
    
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - 缩放
- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
}

#pragma mark - 缩放
- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
}


- (void)dismissAlert
{
    [self remove];
}

- (void)remove
{
    [self.backImageView removeFromSuperview];
    
    [self removeFromSuperview];
    
}

@end
