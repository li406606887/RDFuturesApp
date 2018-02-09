//
//  MessageTableViewCell.h
//  RDFuturesApp
//
//  Created by user on 17/5/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MessageModel.h"

@interface MessageTableViewCell : BaseTableViewCell
@property(nonatomic,strong)MessageModel *model;
@end
