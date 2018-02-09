//
//  NewsListModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListModel : NSObject



@property(nonatomic,copy)NSString *newsUrl;
@property(nonatomic,copy)NSString *releaseDate;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imageUrl;

@end
