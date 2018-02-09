//
//  BillTableViewCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/27.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"
static NSString * const kBillTableViewCell = @"BillTableViewCell";

@interface BillTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) BillModel *model;
@end
