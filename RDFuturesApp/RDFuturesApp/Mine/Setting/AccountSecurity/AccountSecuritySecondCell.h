//
//  AccountSecuritySecondCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/27.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kAccountSecuritySecondCell = @"AccountSecuritySecondCell";
@interface AccountSecuritySecondCell : UITableViewCell

@property (nonatomic, strong) void (^bBlock)();

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;




@end
