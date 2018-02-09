//
//  ShootExampleView.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MyEditorWidth  300
#define MyEditorHeight 420.0f
@interface ShootExampleView : UIView
{
    
}
@property (nonatomic,strong) UITableView *noticeTableView;//重要通知 tableView(API申请页面)
@property (nonatomic,strong) NSString *noticeString;//重要通知str (API申请页面)
@property (nonatomic, strong) UILabel * title;
@property (nonatomic, strong) UILabel * subTitle;
@property (nonatomic, strong) UIView  * backImageView;

@property(nonatomic,strong) void (^goonBlock)();

-(id)initViewTitleImgString:(NSString *)titleImgString TitleString:(NSString *)titleString SubTitleString:(NSString *)subTitleString BtnImgString:(NSString *)btnImgString;
-(id)initWithImportContentStr:(NSString *)contentStr;
- (void)show;
-(id)initViewTitleImgString:(NSString *)title cachString:(NSString *)cach financingString:(NSString *)financing;
- (void)showCachAccount;

@end
