//
//  NickNameViewController.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"
typedef void(^BackBlock) (NSString * nameStr);
@interface NickNameViewController : ViewBaseController
@property (nonatomic,copy) BackBlock backblock;
@end
