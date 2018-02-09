

//
//  UILabel+Extension.m
//  RDFuturesApp
//
//  Created by user on 2017/5/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+(CGSize)textForFont:(int)font andMAXSize:(CGSize)size andText:(NSString*)text
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont rdSystemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    
    return rect.size;
}




@end
