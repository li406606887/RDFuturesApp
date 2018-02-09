//
//  CollectionModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject


/*
 1、noticeId				 收藏圈子id
 2、title                收藏圈子的标题
 3、collectTime          收藏的时间
 4、imageUrl				 图片url
 5、contentUrl			 收藏的内容详情url
 */

@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *collectTime;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *noticeId;
@property (nonatomic,strong) NSString *contentUrl;

@end
