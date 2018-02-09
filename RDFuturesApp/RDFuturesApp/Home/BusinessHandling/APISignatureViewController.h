//
//  APISignatureViewController.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/19.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "AutographModel.h"

@interface APISignatureViewController : UIViewController
@property(nonatomic,strong) void (^AutographBlock)(BOOL result);
@property(nonatomic,strong)AutographModel *model;
@property (nonatomic,strong) NSString *typeStr;
@end
