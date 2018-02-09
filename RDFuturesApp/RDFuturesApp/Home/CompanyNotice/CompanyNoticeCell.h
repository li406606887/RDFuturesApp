//
//  CompanyNoticeCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyNoticeModel.h"
static NSString * const kCompanyNoticeCell = @"CompanyNoticeCell";
@interface CompanyNoticeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (nonatomic,strong) CompanyNoticeModel *model;

@end
