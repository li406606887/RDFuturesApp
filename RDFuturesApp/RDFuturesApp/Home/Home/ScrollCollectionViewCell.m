
//
//  ScrollCollectionViewCell.m
//  RDFuturesApp
//
//  Created by user on 17/4/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ScrollCollectionViewCell.h"

@interface ScrollCollectionViewCell()
@property(nonatomic,strong)UIImageView *image;
@end


@implementation ScrollCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        
        [self addSubview:imageView];
        self.image = imageView;
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        }
    return self;
}

-(void)setImage_url:(NSString *)image_url{
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:image_url] placeholderImage:[UIImage imageNamed:@"loading_image_loading"]];
    
}
-(UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc] init];
        _image.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _image;
}
-(void)updateConstraints{
    WS(weakself)
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}
@end
