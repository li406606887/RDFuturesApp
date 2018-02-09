//
//  AboutUsViewModel.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/26.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AboutUsViewModel.h"

@implementation AboutUsViewModel

-(void)initialize{
    
    
    
}

-(RACSubject *)labelClick{
    
    if (!_labelClick) {
        _labelClick = [[RACSubject alloc]init];
    }
    return _labelClick;
}
@end
