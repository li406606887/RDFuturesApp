//
//  OtherHeadView.h
//  RDFuturesApp
//
//  Created by user on 17/3/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseView.h"

@interface OtherHeadView : BaseView
@property(nonatomic,copy) NSString *title;
@property(nonatomic,weak)UIButton *selectButton;
@property(nonatomic,weak)UILabel *labelTitle;

@end
