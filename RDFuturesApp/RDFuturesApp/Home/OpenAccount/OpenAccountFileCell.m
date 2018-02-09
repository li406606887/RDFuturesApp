//
//  OpenAccountFileCell.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "OpenAccountFileCell.h"

@implementation OpenAccountFileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.contentView addSubview:self.contentLabel];
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setContentText:(NSString *)contentText{
    if (contentText) {
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont rdSystemFontOfSize:12]};
        NSAttributedString *att = [[NSAttributedString alloc] initWithString:contentText attributes:attributes];
        CGSize ret1;
        ret1 = [self textForFont:12 andMAXSize:CGSizeMake(SCREEN_WIDTH - 60, MAXFLOAT) andText:contentText];
        self.contentLabel.frame = CGRectMake(23, 0, ret1.width, ret1.height);
        self.contentLabel.attributedText =att;
     
    }
}
- (CGSize)textForFont:(int)font andMAXSize:(CGSize)size andText:(NSString*)text
{
    
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont rdSystemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    
    //    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    //    CGRect rect = [text boundingRectWithSize:size
    //                                     options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
    //                                  attributes:attributes
    //                                     context:nil];
    
    return rect.size;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
      
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
@end
