//
//  OtherHeadView.m
//  RDFuturesApp
//
//  Created by user on 17/3/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "OtherHeadView.h"

@interface OtherHeadView ()


@end

@implementation OtherHeadView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildView];

    }
    return self;
    
}

-(void)addChildView{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 2, 30, 30);
    [button setImage:[UIImage imageNamed:@"other_infor_nomal"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"other_infor_select"] forState:UIControlStateSelected];
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    button.userInteractionEnabled = NO;
    button.showsTouchWhenHighlighted = NO;
    [self addSubview:button];
    self.selectButton = button;
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake( 50, 4, self.frame.size.width-60, self.frame.size.height-6)];
    titlelabel.numberOfLines = 0;
    titlelabel.font = [UIFont rdSystemFontOfSize:14];
    [self addSubview:titlelabel];
    self.labelTitle = titlelabel;
    
}


-(void)setTitle:(NSString *)title{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    [self.labelTitle setAttributedText:attributedString];
    
}


@end
