//
//  AppDelegate.h
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarBaseController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong , nonatomic) TabBarBaseController *root;
@property (strong , nonatomic) UIWindow *window;

@property (assign , nonatomic) BOOL isForceLandscape;
@property (assign , nonatomic) BOOL isForcePortrait;
@end

