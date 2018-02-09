//
//  OpenAccountFileGroup.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/6.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenAccountFileGroup : NSObject
//联系人数据
@property(nonatomic,strong)NSMutableArray *items;
//数据
@property(nonatomic,strong)NSString *contentStr;
//大小(分组中有多少项)
@property (nonatomic, readonly) NSUInteger size;
//是否折叠
@property (nonatomic, assign, getter=isFolded) BOOL folded;

//初始化方法
- (instancetype) initWithItem:(NSMutableArray *)item;

- (instancetype) initWithContent:(NSString *)content;
@end
