//
//  BillModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillModel : NSObject

@property (nonatomic,strong) NSString *billName;
@property (nonatomic,strong) NSString *billUrl;
/*
 1、billName             账单的标题
 2、billUrl			 	账单的内容详情url
 */
@end
