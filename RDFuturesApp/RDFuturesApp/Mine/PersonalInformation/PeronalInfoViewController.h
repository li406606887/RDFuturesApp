//
//  PeronalInfoViewController.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"
typedef void(^PopBlock) (NSString * nameStr,NSURL * imageUrl);
@interface PeronalInfoViewController : ViewBaseController

@property (nonatomic,strong) PopBlock popBlock;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *customer_id;
@property (nonatomic,strong) NSURL *user_img;
@end
