//
//  ProgressViewController.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountBaseController.h"

@interface ProgressViewController : AccountBaseController
@property (nonatomic, copy)NSString *loadType;
@property (nonatomic, assign)BOOL PuchStyle;
@end
