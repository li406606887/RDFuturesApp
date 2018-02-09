//
//  AddressItem.h
//  ChooseLocation
//
//  Created by Sekorm on 16/8/26.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMBAddressItem : NSObject

@property (nonatomic,copy) NSString *region_id;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *local_name;
//@property (nonatomic,copy) NSString *fullName;
@property (nonatomic,copy) NSArray * cityList;
@property (nonatomic,copy) NSArray * regionList;


@property (nonatomic,assign) BOOL  isSelected;

+ (instancetype)initWithName:(NSString *)name isSelected:(BOOL)isSelected;

+ (instancetype)initWithId:(NSString *)Id name:(NSString *)name fullName:(NSString *)fullName;

-(id)initWithInfoDic:(NSDictionary *)infoDic;
@end
