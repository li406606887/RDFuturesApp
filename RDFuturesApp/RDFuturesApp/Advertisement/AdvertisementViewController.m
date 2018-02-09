

//
//  AdvertisementViewController.m
//  RDFuturesApp
//
//  Created by user on 2017/5/21.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AdvertisementViewController.h"
#import "AdvertisementImageView.h"
#import "AdvertisementLabel.h"
#import "AdvertisementViewModel.h"
#import "AdvertisementModel.h"

@interface AdvertisementViewController ()
@property (nonatomic, strong) AdvertisementImageView *pageView;
@property (nonatomic, strong) AdvertisementViewModel *advertisementViewModel;
@end

@implementation AdvertisementViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.advertisementViewModel.advertisementCommand execute:nil];
    [self pageViewInit];
}


- (void)pageViewInit {
    WS(weakself)
    _pageView = [[AdvertisementImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _pageView.blockSelect = ^{
        [RDUserInformation getInformation].advertisementClick = YES;
        [weakSelf removerImagePageView];

    };
    [self.view addSubview:_pageView];
    
    AdvertisementLabel *countdownLabel = [[AdvertisementLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 20, 60, 30)];
    countdownLabel.blockNewViewController = ^{
        [weakSelf removerImagePageView];
    };
    [_pageView addSubview:countdownLabel];
}

- (void)removerImagePageView {
    WS(weakSelf);
    [UIView animateWithDuration:0.5 animations:^{
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionFade;
        animation.subtype = kCATransitionFromTop;
        [self.view.window.layer addAnimation:animation forKey:nil];
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
        if (weakSelf.blockMainViewController) {
            weakSelf.blockMainViewController();
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)bindViewModel{
    [self.advertisementViewModel.advertisementCommand execute:nil];
}
-(AdvertisementViewModel *)advertisementViewModel{
    if (!_advertisementViewModel) {
        _advertisementViewModel = [[AdvertisementViewModel alloc] init];
    }
    return _advertisementViewModel;
}
@end
