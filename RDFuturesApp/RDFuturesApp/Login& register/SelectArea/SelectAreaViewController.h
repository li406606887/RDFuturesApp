//
//  SelectAreaViewController.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBlock) (NSString * areaStr,NSString * numStr);
@interface SelectAreaViewController : ViewBaseController
@property (nonatomic,copy) BackBlock backblock;
@end
