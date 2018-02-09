//
//  PopCollectionView.m
//  RDFuturesApp
//
//  Created by user on 2017/5/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "PopCollectionView.h"

@interface PopCollectionView()
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIImageView *backgroundImageView;//背景图片
@property(nonatomic,strong)NSArray *imageArray;//图片数组
@property(nonatomic,strong)NSArray *titleArray;//图片数组
@property(nonatomic,strong)UIButton *share;//分享按钮
@property(nonatomic,strong)UIButton *collection;//收藏按钮
@property(nonatomic,strong)UIView *lineView;//
@end

@implementation PopCollectionView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addSubview:self.backView];
        [self addSubview:self.backgroundImageView];
        [self.backgroundImageView addSubview:self.lineView];
        [self.backgroundImageView addSubview:self.share];
        [self.backgroundImageView addSubview:self.collection];
        
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

-(UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(viewWidth-155, 57, 150, 110)];
        [_backgroundImageView setImage:[UIImage imageWithStretchableName:@"colleticon_backgroundImage"]];
        _backgroundImageView.userInteractionEnabled = YES;
    }
    return _backgroundImageView;
}
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.4f;
    }
    return _backView;
}

-(UIButton *)creatButtonwithFrame:(CGRect)frame WithTitle:(NSString*)title withImage:(NSString*)image withSeletedImage:(NSString*)selectedImage withAction:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        return button;
}

-(void)bindViewModel{
    
}
-(void)buttonClick:(UIButton*)button{
    switch (button.tag) {
        case 1:{
        
            [self removeFromSuperview];
        
        }
            break;
        case 2:{
            
            [self.viewModel.collectionClickCommand execute:self.model.notice_id];
            
            [self removeFromSuperview];
            
        }
            break;
        default:
            break;
    }
}
-(void)setModel:(NoticeModel *)model{
    if (model) {
        _model = model;
    }
}
-(void)setIsCollect:(BOOL)isCollect{
    if (isCollect==YES) {
        [_collection setTitle:@"已收藏" forState:UIControlStateNormal];
        _collection.selected = YES;

    }else{
        [_collection setTitle:@"收藏" forState:UIControlStateNormal];

    }
}
-(UIButton *)collection{
    if (!_collection) {
        _collection = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collection setFrame:CGRectMake(0, getTop(self.lineView), 150, 50)];
        _collection.imageEdgeInsets = UIEdgeInsetsMake(10,20, 10, 40);
        _collection.titleEdgeInsets = UIEdgeInsetsMake(10, 5, 5, 5);
        _collection.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_collection setImage:[UIImage imageNamed:@"Collection_icon_nomal"] forState:UIControlStateNormal];
        [_collection setImage:[UIImage imageNamed:@"Collection_icon_selected"] forState:UIControlStateSelected];
        [_collection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_collection.titleLabel setFont:[UIFont rdSystemFontOfSize:17]];
        [_collection setTag:2];
        [_collection addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collection;
}
-(UIButton *)share{
    if (!_share) {
        _share = [UIButton buttonWithType:UIButtonTypeCustom];
        [_share setFrame:CGRectMake(0, 10, 150, 50)];
        [_share setTag:1];
        _share.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 40);
        _share.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 5, 5);
        
        _share.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_share setImage:[UIImage imageNamed:@"Share_Icon_nomal"] forState:UIControlStateNormal];
        [_share setTitle:@"分享" forState:UIControlStateNormal];
        [_share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_share.titleLabel setFont:[UIFont rdSystemFontOfSize:17]];
        [_share addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _share;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, getTop(self.share), 150, 0.5)];
        [_lineView setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _lineView;
}
@end
