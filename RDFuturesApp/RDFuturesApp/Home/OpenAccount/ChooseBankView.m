//
//  ChooseBankView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ChooseBankView.h"
static CGFloat kTransitionDuration = 0.15;

@implementation ChooseBankView
-(id)init {
    
    self = [super init];
    if (self) {
    }
    
    return self;
}

-(id)initWithDataArray:(NSArray *)dataArray
{
    
    self = [super init];
    if (self) {
        
        _dataArray = dataArray;
        self.backgroundColor = BACKGROUNDCOLOR;

        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyEditorWidth, MyEditorHeight) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:kBankCell bundle:nil] forCellReuseIdentifier:kBankCell];

//
//        UIButton * go_onbuuton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [go_onbuuton setFrame:CGRectMake(MyEditorWidth / 2 - 65, MyEditorHeight - 60, 130, 45)];
//        [go_onbuuton setImage:[UIImage imageNamed:btnImgString] forState:UIControlStateNormal];
//        [go_onbuuton addTarget:self action:@selector(goonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:go_onbuuton];
        
    }
    
    return self;
}
#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankCell * cell = [tableView dequeueReusableCellWithIdentifier:kBankCell];
    cell.bluePointImg.hidden = YES;//点击时才显示

    cell.titleLabel.text = _dataArray[indexPath.row];
    return cell;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self dismissAlert];
    if (self.callBackBlock) {
        self.callBackBlock([NSString stringWithFormat:@"%ld",(long)indexPath.row]);
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
#pragma mark - 继续按钮
-(void)goonAction:(id)sender
{
    //代码筷回掉
    //    _leaveAlertView = NO;
    [self dismissAlert];
    if (self.goonBlock) {
        
        self.goonBlock();
    }
    
}

/*
 * 展示自定义AlertView
 */
- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(SCREEN_WIDTH/2-MyEditorWidth/2, SCREEN_HEIGHT/2- MyEditorHeight*0.5, MyEditorWidth, MyEditorHeight);
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
    [UIView setAnimationDuration:kTransitionDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceAnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView commitAnimations];
    
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - 缩放
- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
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
-(id)initWithNoBgViewDataArray:(NSArray *)dataArray
{
    
    self = [super init];
    if (self) {
        
        _dataArray = dataArray;
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, MyEditorWidth, MyEditorHeight) style:UITableViewStylePlain];
        tableView.size = CGSizeMake(MyEditorWidth, dataArray.count*60);
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:kBankCell bundle:nil] forCellReuseIdentifier:kBankCell];
        self.backgroundColor = [UIColor clearColor];
        //
        //        UIButton * go_onbuuton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [go_onbuuton setFrame:CGRectMake(MyEditorWidth / 2 - 65, MyEditorHeight - 60, 130, 45)];
        //        [go_onbuuton setImage:[UIImage imageNamed:btnImgString] forState:UIControlStateNormal];
        //        [go_onbuuton addTarget:self action:@selector(goonAction:) forControlEvents:UIControlEventTouchUpInside];
        //        [self addSubview:go_onbuuton];
        
    }
    
    return self;
}



@end
