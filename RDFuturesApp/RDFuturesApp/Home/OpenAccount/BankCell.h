//
//  BankCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/7.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kBankCell = @"BankCell";
@interface BankCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bluePointImg;

@end
