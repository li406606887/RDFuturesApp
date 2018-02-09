//
//  NewsViewModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "BaseScrollViewModel.h"

@interface NewsViewModel : BaseScrollViewModel

@property(nonatomic,strong)RACSubject * titleClickSubject;//title点击时

@property(nonatomic,strong)RACSubject * didEndScrollSubject;//滚动结束时




@end
