//
//  NSString+NSString_Extension.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/15.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_Extension)


- (NSString *)cutStringFrom:(NSString *)startString to:(NSString *)endString;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;//手机号正则表达式
+ (NSString *) turnTxtStringWithResourceStr:(NSString *)resourceStr;
+ (NSString *) turnTxtStringWithJianStr:(NSString *)JianStr;
@end
