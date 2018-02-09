//
//  BaseCollectionViewCell.h
//  RDFuturesApp
//
//  Created by user on 17/4/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol CollectionViewCellProtocol <NSObject>

@optional

- (void)setupViews;
- (void)bindViewModel;


@end

@interface BaseCollectionViewCell : UICollectionViewCell<CollectionViewCellProtocol>

@end
