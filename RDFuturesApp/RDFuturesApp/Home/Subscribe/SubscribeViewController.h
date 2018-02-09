//
//  SubscribeViewController.h
//  RDFuturesApp
//
//  Created by user on 2017/6/15.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"
#import <WebKit/WebKit.h>

@interface SubscribeViewController : ViewBaseController
@property(nonatomic,copy)NSString *web_url;
@property(nonatomic,copy)NSString *titleName;
@end
