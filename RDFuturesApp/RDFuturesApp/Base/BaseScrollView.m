//
//  BaseScrollView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}



- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{

    self = [super init];
    if (self) {
        [self setupViews];
        [self bindViewModel];
        
    }
    return self;
    
}

- (void)bindViewModel {
}

- (void)setupViews {
}


@end
