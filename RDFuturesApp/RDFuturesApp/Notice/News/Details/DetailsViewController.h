//
//  DetailsViewController.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/26.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"
#import <WebKit/WebKit.h>

@interface DetailsViewController : ViewBaseController
@property (nonatomic,strong) NSString *urlStr;

@property (nonatomic,strong) NSString *titleString;
@end
