//
//  NewsTableViewCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/19.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListModel.h"
@interface NewsTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * timeLabel;

@property (nonatomic,strong) NewsListModel *model;
@end
