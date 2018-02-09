//
//  ZLGestureLockViewController.h
//  GestureLockDemo
//
//  Created by ZL on 2017/4/5.
//  Copyright © 2017年 ZL. All rights reserved.
//  手势密码界面 控制器

#import "ViewBaseController.h"

typedef NS_ENUM(NSInteger,ZLUnlockType) {
    ZLUnlockTypeCreatePsw, // 创建手势密码
    ZLUnlockTypeValidatePsw, // 校验手势密码
    ZLUnlockTypeModifyPsw, // 修改手势密码
    ZLUnlockTypeClosePsw, // 关闭手势密码
};

@interface ZLGestureLockViewController : ViewBaseController

+ (void)deleteGesturesPassword;//删除手势密码
+ (NSString *)gesturesPassword;//获取手势密码

- (instancetype)initWithUnlockType:(ZLUnlockType)unlockType;

@end
