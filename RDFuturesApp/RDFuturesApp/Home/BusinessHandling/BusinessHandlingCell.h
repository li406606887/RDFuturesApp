//
//  BusinessHandlingCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/14.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kBusinessHandlingCell = @"BusinessHandlingCell";
@interface BusinessHandlingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
