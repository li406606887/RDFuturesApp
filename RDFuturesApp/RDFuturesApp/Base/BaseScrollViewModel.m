//
//  BaseScrollViewModel.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseScrollViewModel.h"

@implementation BaseScrollViewModel


+ (instancetype)allocWithZone:(struct _NSZone *)zone{

    BaseScrollViewModel * viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model
{
    self = [super init];
    if (self) {
        
    }
    return self;
    
}
-(void)initialize{}
@end
