//
//  PromptView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "PromptView.h"
static CGFloat kTransitionDuration = 0.3;
#define MyEditorWidth 300.0f
#define MyEditorHeight 120.0f+self.textHeight
@interface PromptView()

@property(nonatomic,copy)NSString *sting;
@property(nonatomic,assign)CGFloat textHeight;

@end
@implementation PromptView


-(id)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(id)initWithTitleString:(NSString *)titleString SubTitleString:(NSString *)subTitleString{
    
    self = [super init];
    if (self) {
        self.sting = subTitleString;

        
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(MyEditorWidth / 2 - 50, 20, 100, 25)];
        label1.text = titleString;
        label1.font = [UIFont rdSystemFontOfSize:18];
        label1.textColor = GRAYCOLOR2;
        label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label1];
        
     
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 45, MyEditorWidth-40, self.textHeight+10)];
        label2.textColor = GRAYCOLOR2;
        label2.numberOfLines = 0;
        label2.text = subTitleString;

        
        label2.font = [UIFont rdSystemFontOfSize:15];
        label2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label2];
    
        
        [self addSubview:self.closeButton];
        
        
        [self addSubview:self.goonBtn];
        
    }
    
    return self;
}
-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1.0f]];
        [_closeButton setTitle:@"取消" forState:UIControlStateNormal];
        [_closeButton setTitleColor:GRAYCOLOR2 forState:UIControlStateNormal];
        [_closeButton setFrame:CGRectMake(0, MyEditorHeight-50, MyEditorWidth/2, 50)];
    }
    return _closeButton;
}
-(UIButton *)goonBtn{
    if (!_goonBtn) {
        _goonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goonBtn addTarget:self action:@selector(goonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_goonBtn setBackgroundColor:RGB(220, 12, 23)];
        [_goonBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_goonBtn setTintColor:[UIColor whiteColor]];
        [_goonBtn setFrame:CGRectMake(MyEditorWidth/2, MyEditorHeight-50, MyEditorWidth/2, 50)];
    }
    return _goonBtn;
}
-(void)closeBtnClick:(id)sender{
    [self dismissAlert];
}
#pragma mark - 继续按钮
-(void)goonAction:(UIButton *)sender
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
    self.frame = CGRectMake(SCREEN_WIDTH/2-MyEditorWidth/2, SCREEN_HEIGHT/2-MyEditorHeight*0.5, MyEditorWidth, MyEditorHeight);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
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
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    
    // 一系列动画效果,达到反弹效果
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.05, 0.05);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceAnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    [UIView commitAnimations];
    
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - 缩放
- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
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

- (CGFloat)getTextHeight{
   
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont rdSystemFontOfSize:fifteenFontSize]};
    CGRect rect = [self.sting boundingRectWithSize:CGSizeMake(MyEditorWidth-40, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    
    return rect.size.height;
}
- (void)remove
{
    [self.backImageView removeFromSuperview];
    
    [self removeFromSuperview];
    
}
- (void)showCachAccount
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(SCREEN_WIDTH/2-MyEditorWidth/2, SCREEN_HEIGHT/2-350*0.5, MyEditorWidth, 350);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [topVC.view addSubview:self];
}

-(CGFloat)textHeight{
    if (!_textHeight) {
        _textHeight = [self getTextHeight];
    }
    return _textHeight;
}
@end
