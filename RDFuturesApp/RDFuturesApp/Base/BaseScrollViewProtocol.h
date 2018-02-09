//
//  BaseScrollViewProtocol.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModelProtocol.h"

@protocol BaseScrollViewProtocol <NSObject>


@optional

- (instancetype)initWithViewModel:(id <BaseViewModelProtocol>)viewModel;

-(void)bindViewModel;
-(void)setupViews;


@end
