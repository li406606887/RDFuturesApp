//
//  OtherInforCell.m
//  RDFuturesApp
//
//  Created by user on 17/3/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "OtherInforCell.h"


@implementation OtherInforSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
        [self.contentView addSubview:titleLabel];
        titleLabel.centerY = self.contentView.centerY;
        titleLabel.font = [UIFont rdSystemFontOfSize:14];
        self.title = titleLabel;
        
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(getLeft(titleLabel)+10, 0, viewWidth-100, 30)];
        textField.centerY = self.contentView.centerY;
        textField.placeholder = @"请输入";
        [self.contentView addSubview:textField];
        textField.font = [UIFont rdSystemFontOfSize:14];
        self.context = textField;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end

