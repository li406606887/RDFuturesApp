//
//  ViewBaseController.h
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewBaseControllerProtocol.h"
#import "NotificationModel.h"
@interface ViewBaseController : UIViewController<ViewControllerProtocol>
@property(nonatomic,copy)NSString *centerTitle;


- (void)hideTabbar:(BOOL)hidden;
- (UIView *)centerView;
- (UIBarButtonItem *)leftButton;
- (UIBarButtonItem *)rightButton;

-(void)puchBreedRules;
-(void)puchBankInformation;
-(void)puchBond;
-(void)puchLastTradingDay;
-(void)puchLogin;
-(void)puchRDProfile;
-(void)puchContactUs;
-(void)puchOpenfirst;
-(void)pushProgress;
-(void)pushCompanyNotice;
-(void)pushInfoFeedBack;
-(void)pushHelpCenter;
-(void)pushBills;
-(void)pushBusinessBandling;
-(void)pushMagicBox;
+(CGSize)textForFont:(int)font andMAXSize:(CGSize)size andText:(NSString*)text;
@end
