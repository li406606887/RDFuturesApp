//
//  RDRequestModel.h
//  RDFuturesApp
//
//  Created by user on 17/3/25.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDRequestModel : NSObject
@property(nonatomic,copy)NSString *Code;
@property(nonatomic,strong)id Data;
@property(nonatomic,copy)NSString *Message;
@property(nonatomic,copy)NSString *State;
@property(nonatomic,copy)NSString *skip_url;
@end



