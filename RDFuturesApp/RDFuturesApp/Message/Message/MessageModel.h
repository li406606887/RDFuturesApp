//
//  MessageModel.h
//  RDFuturesApp
//
//  Created by user on 17/5/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *titleText;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,assign)BOOL is_new_inform;//是否有新通知（1：是，2否）
@end
