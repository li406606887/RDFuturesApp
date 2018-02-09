//
//  AddressItem.m
//  ChooseLocation
//
//  Created by Sekorm on 16/8/26.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "ZMBAddressItem.h"

@implementation ZMBAddressItem

+ (instancetype)initWithName:(NSString *)name isSelected:(BOOL)isSelected{
    
    ZMBAddressItem * item = [[ZMBAddressItem alloc]init];
    item.name = name;
    item.isSelected = isSelected;
    return item;
}

+ (instancetype)initWithId:(NSString *)Id name:(NSString *)name fullName:(NSString *)fullName
{
  ZMBAddressItem * item = [[ZMBAddressItem alloc]init];
  item.region_id = Id;
  item.local_name = name;
//  item.local_name = fullName;
  return item;
}
-(id)initWithInfoDic:(NSDictionary *)infoDic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:infoDic];
    }
    return self;
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
