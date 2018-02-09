//
//  GuidanceView.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MyEditorWidth  300
#define MyEditorHeight 420.0f
@interface GuidanceView : UIView

@property (nonatomic, strong) UILabel * title;
@property (nonatomic, strong) UILabel * subTitle;
@property (nonatomic, strong) UIView  * backImageView;

@property(nonatomic,strong) void (^goonBlock)();

-(id)initWithGuidanceOfClick;//点击方式
-(id)initWithGuidanceOfScroll;//滚动方式

- (void)show;

@end
