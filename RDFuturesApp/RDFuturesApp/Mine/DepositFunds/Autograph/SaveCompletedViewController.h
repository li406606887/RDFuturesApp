//
//  SaveCompletedViewController.h
//  RDFuturesApp
//
//  Created by user on 17/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"

typedef enum : NSInteger {
    promptTypeDepositFunds,
    promptTypeWitdrawFunds,
    promptTypeApiService
    
} PromptStyle;

@interface SaveCompletedViewController : ViewBaseController
@property (nonatomic, assign)PromptStyle prompt;

@end
