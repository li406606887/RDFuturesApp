//
//  MATextFieldTableViewCell.h
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MoneyAmountViewModel.h"
#import "MAChooseModel.h"

@interface MATextFieldTableViewCell : BaseTableViewCell
@property(nonatomic,copy)NSString *titleStr;

@property(nonatomic,copy)NSString *textfieldPrompt;

@property(nonatomic,strong)void (^textFieldBlock)(NSString *value);

@property(nonatomic,strong)MAChooseModel *model;

@property(nonatomic,strong)UITextField *contentField;
@end
