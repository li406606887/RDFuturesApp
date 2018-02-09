//
//  OpenAccountFileCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kOpenAccountFileCell  = @"OpenAccountFileCell";
@interface OpenAccountFileCell : UITableViewCell
@property (nonatomic,strong) NSString *contentText;
@property (strong, nonatomic) UILabel *contentLabel;
@end
