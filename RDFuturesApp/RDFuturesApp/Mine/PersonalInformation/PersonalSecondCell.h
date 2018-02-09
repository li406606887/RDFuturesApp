//
//  PersonalSecondCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPersonalSecondCell = @"PersonalSecondCell";
@interface PersonalSecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end
