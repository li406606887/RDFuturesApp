//
//  BaseCollectionViewCell.m
//  RDFuturesApp
//
//  Created by user on 17/4/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

-(instancetype)init{
    if (self=[super init]) {
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}
@end
