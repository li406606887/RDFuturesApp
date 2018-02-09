//
//  AddressViewController.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AccountBaseController.h"

@interface AddressViewController : AccountBaseController
@property (nonatomic,strong) NSString *nameStr;
@property (nonatomic,strong) NSString *pinYinStr;
@property (nonatomic,strong) NSString *cardNumStr;
@property (nonatomic,strong) NSString *addressStr;
@property (nonatomic,strong) UIImage *passportImage;
@end
