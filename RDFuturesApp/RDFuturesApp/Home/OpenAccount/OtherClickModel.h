//
//  OtherClickModel.h
//  RDFuturesApp
//
//  Created by user on 17/3/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OtherClickModel : NSObject
@property(nonatomic,strong)NSMutableArray *cellStyleArray;
@property(nonatomic,assign)BOOL on_Off;//section开关;yes 关闭 no 展开
@property(nonatomic,assign)BOOL head_on_Off;//headView 背景色开关;no 让headView背景色变暗 off 让headView背景色变白

@end
@interface OtherCellModel : NSObject
@property(nonatomic,copy)NSString *cellTitle;//标题
@property(nonatomic,copy)NSString *cellStyle;//样式
@property(nonatomic,copy)NSString *context;//内容
@end
