//
//  UIBarButtonItem+XMGExtension.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/5.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+XMGExtension.h"
@interface UIBarButtonItem (XMGExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
