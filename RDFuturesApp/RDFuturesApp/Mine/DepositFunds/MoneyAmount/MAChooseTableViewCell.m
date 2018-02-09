//
//  MAChooseTableViewCell.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MAChooseTableViewCell.h"

@interface MAChooseTableViewCell()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *chooseBtn;
@property(nonatomic,strong)UIView *textFieldView;
@property(nonatomic,strong)NSMutableArray *itemArray;

@end

@implementation MAChooseTableViewCell


-(void)setupViews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textFieldView];
    [self.textFieldView addSubview:self.contentText];
    [self.textFieldView addSubview:self.chooseBtn];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)updateConstraints{
    WS(weakself)
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.size.mas_offset(CGSizeMake(60, 15));
    }];
    
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.titleLabel.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
        make.height.mas_offset(45);
    }];
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.textFieldView).with.offset(10);
        make.centerY.equalTo(weakSelf.contentView);
        make.size.mas_offset(CGSizeMake(180, 30));
    }];
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.textFieldView.mas_right);
        make.centerY.equalTo(weakSelf.contentView);
        make.size.mas_offset(CGSizeMake(40, 30));
    }];
    [super updateConstraints];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:RGB(68, 68, 68)];
        _titleLabel.font = [UIFont rdSystemFontOfSize:15];
    }
    return _titleLabel;
}

-(UIView *)textFieldView{
    if (!_textFieldView) {
        _textFieldView = [[UIView alloc] init];
        _textFieldView.layer.borderColor = [RGB(210, 210, 210) CGColor];
        _textFieldView.layer.borderWidth = 0.5f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [self.itemArray removeAllObjects];
            for (int i = 0; i<self.titleArray.count; i++) {
                MenuItem *item = [[MenuItem alloc] init];
                item.title = self.titleArray[i];
                item.index = i;
                
                WS(weakself)
                item.selectItemBlock = ^(MenuItem *model){
                    weakSelf.contentText.text = model.title;
                    NSString *index = [NSString stringWithFormat:@"%d",model.index];
                    if (weakSelf.chooseCellBlock) {
                        weakSelf.chooseCellBlock(index);
                    }
                };
                [self.itemArray addObject:item];
            }
            CGPoint point ={0,0};
            [PopoverView showPopoverViewAtPoint:point withWidth:300 withMenuItems:self.itemArray];
        }];
        [_textFieldView addGestureRecognizer:tap];
    }
    return _textFieldView;
}
-(UILabel *)contentText{
    if (!_contentText) {
        _contentText = [[UILabel alloc] init];
        [_contentText setText:@"请选择"];
        _contentText.font = [UIFont rdSystemFontOfSize:14];
    }
    return _contentText;
}
-(UIButton *)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseBtn setImage:[UIImage imageNamed:@"DepositFounds_Drop_down_arrow"] forState:UIControlStateNormal];
        _chooseBtn.userInteractionEnabled = NO;
    }
    return _chooseBtn;
}

-(NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}

@end
