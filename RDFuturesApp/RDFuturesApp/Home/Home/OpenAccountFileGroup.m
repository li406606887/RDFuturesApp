//
//  OpenAccountFileGroup.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/6.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "OpenAccountFileGroup.h"

@implementation OpenAccountFileGroup
//初始化方法
- (instancetype) initWithItem:(NSMutableArray *)item{
    if (self = [super init]) {
        self.folded=YES;
        _items = item;
    }
    return self;
}

//每个组内有多少联系人
- (NSUInteger) size {
    return _items.count;
}

@end
