//
//  BankCardModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/25.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject
@property (nonatomic,strong) NSString *HK_bank;
@property (nonatomic,strong) NSString *HK_card;
@property (nonatomic,strong) NSString *HK_card_holder;
@property (nonatomic,strong) NSString *currency_HK;
@property (nonatomic,strong) NSString *currency_dollar;
@property (nonatomic,strong) NSString *dollar_bank;
@property (nonatomic,strong) NSString *dollar_bank_holder;
@property (nonatomic,strong) NSString *dollar_card;
@property (nonatomic,strong) NSString *is_account;

//
//"HK_bank" = "\U4e1c\U4e9a\U94f6\U884c";
//"HK_card" = 123;
//"HK_card_holder" = a;
//"currency_HK" = "\U6e2f\U5e01";
//"currency_dollar" = "\U7f8e\U5143";
//"dollar_bank" = "\U62db\U5546\U94f6\U884c\Uff08\U9999\U6e2f\U5206\U884c\Uff09";
//"dollar_bank_holder" = "\U5728";
//"dollar_card" = 25563;
//"is_account" = 1;
@end
