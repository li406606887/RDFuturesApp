//
//  ChooseBankView.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MyEditorWidth 300.0f
#define MyEditorHeight 420.0f
#import "BankCell.h"
typedef void(^CallBackBlcok) (NSString *str);//1
@interface ChooseBankView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, strong) UILabel * subTitle;
@property (nonatomic, strong) UIView  * backImageView;
@property (nonatomic,copy)CallBackBlcok callBackBlock;//2

@property(nonatomic,strong) void (^goonBlock)();

-(id)initWithDataArray:(NSArray *)dataArray;
-(id)initWithNoBgViewDataArray:(NSArray*)dataArray;
- (void)show;

@end
