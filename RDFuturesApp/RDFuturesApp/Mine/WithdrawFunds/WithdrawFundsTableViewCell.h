//
//  WithdrawFundsTableViewCell.h
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface WithdrawFundsTableViewCell : BaseTableViewCell
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *placeholder;
@property(nonatomic,strong)void (^textFieldBlock)(NSString *value);

@end
