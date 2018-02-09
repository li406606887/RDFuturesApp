//
//  AddressTableViewCell.m
//  ChooseLocation
//
//  Created by Sekorm on 16/8/26.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "ZMBAddressCell.h"
#import "ZMBAddressItem.h"
#import "Masonry.h"
@interface ZMBAddressCell ()

@property (strong, nonatomic) UIImageView *selectFlag;

@end

@implementation ZMBAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (!self) {
    return nil;
  }
  
  _addressLabel = [[UILabel alloc] init];
  _addressLabel.textColor = [UIColor darkTextColor];
  _addressLabel.font = [UIFont systemFontOfSize:14];
  [self.contentView addSubview:_addressLabel];

  
  
  _selectFlag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected_icon"]];
  [self.contentView addSubview:_selectFlag];
  
  
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
//        make.right.equalTo(_selectFlag.left).offset(-15);
        make.size.mas_equalTo(CGSizeMake(200, 15));
//        make.top.bottom.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_selectFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
//        make.size.equalTo(CGSizeMake(15, 15));
        make.size.mas_equalTo(CGSizeMake(12, 12));
        make.centerY.equalTo(self.contentView);
    }];
    
//  [_addressLabel makeConstraints:^(MASConstraintMaker *make) {
//    
//    make.left.equalTo(self.contentView).offset(15);
//    make.right.equalTo(_selectFlag.left).offset(-15);
//    make.top.bottom.equalTo(self.contentView);
//    
//  }];
//
//  [_selectFlag makeConstraints:^(MASConstraintMaker *make) {
//    
//    make.right.equalTo(self.contentView).offset(-15);
//    make.size.equalTo(CGSizeMake(15, 15));
//    make.centerY.equalTo(self.contentView);
//    
//  }];
  
  return self;
}


-(void)setIsSelected:(BOOL)isSelected
{
  _addressLabel.textColor = isSelected ? [UIColor redColor] : [UIColor blackColor];
  _selectFlag.hidden = !isSelected;
}

@end
