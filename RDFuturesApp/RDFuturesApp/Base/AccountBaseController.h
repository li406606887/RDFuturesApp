//
//  AccountBaseController.h
//  RDFuturesApp
//
//  Created by user on 17/4/6.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AccountBaseController : UIViewController
@property(nonatomic,copy)NSString *centerTitle;
- (void)hideTabbar:(BOOL)hidden;
- (UIView *)centerView;
- (UIBarButtonItem *)leftButton;
- (UIBarButtonItem *)rightButton;
-(void)puchOpenfirst;
-(void)puchOtherInformation;
-(void)puchOpenAccountFirst;
-(void)puchOpenAccount;
-(void)puchTakeIdCardPhoto;
-(void)puchBankCardInfo;
-(void)puchContactInfo;
-(void)puchFinanceInfo;
-(void)puchExperience;
-(void)puchWitnessCity;
-(void)puchCommitInfo;
-(void)puchProgress;
-(void)puchLogin_register;
-(void)hiddenCloseBtnClick;
-(void)pushDerivative;

+(CGSize)textForFont:(int)font andMAXSize:(CGSize)size andText:(NSString*)text;
@end
