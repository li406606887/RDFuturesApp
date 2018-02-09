//
//  AdvertisementLabel.h
//  RDFuturesApp
//
//  Created by user on 2017/5/21.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisementLabel : UILabel
@property (nonatomic, copy) void(^blockNewViewController)();

@end
