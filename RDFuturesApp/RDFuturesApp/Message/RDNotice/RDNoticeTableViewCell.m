


//
//  RDNoticeTableViewCell.m
//  RDFuturesApp
//
//  Created by user on 2017/5/12.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDNoticeTableViewCell.h"


#define kBackgroundImageViewWidth SCREEN_WIDTH-70


@interface RDNoticeTableViewCell()

@property(nonatomic,strong)UIImageView *iconImage;//图标
@property(nonatomic,strong)UILabel *timeLabel;//时间标签
@property(nonatomic,strong)UIImageView *backgroudImageView;//背景图
@property(nonatomic,strong)UILabel *messageTitle;//消息标题
@property(nonatomic,strong)UILabel *messageText;//消息文本
@property(nonatomic,assign)CGFloat kBackgroundImageViewHeight;
@end

@implementation RDNoticeTableViewCell

-(void)setupViews{
    
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.backgroudImageView];
    [self.backgroudImageView addSubview:self.messageTitle];
    [self.backgroudImageView addSubview:self.messageText];
    self.backgroundColor = [UIColor clearColor];
    
    
}


-(void)updateConstraints{
    WS(weakself)
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).with.mas_offset(15);
        make.size.mas_offset(CGSizeMake(300, 15));
    }];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.top.equalTo(weakSelf.timeLabel.mas_bottom).with.offset(15);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    [self.backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLabel.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.iconImage.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(kBackgroundImageViewWidth, self.kBackgroundImageViewHeight));
    }];
    [self.messageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backgroudImageView).with.offset(5);
        make.left.equalTo(weakSelf.backgroudImageView).with.offset(10);
        make.size.mas_offset(CGSizeMake(200, 16));
    }];
    [self.messageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.backgroudImageView).mas_offset(UIEdgeInsetsMake(31, 15, 5, 5));
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
-(void)setModel:(RDNoticeModel *)model{
    if (model) {
        _model = model;
        self.timeLabel.text = model.createTime;
        self.messageTitle.text = model.title;
        self.messageText.attributedText = [self changeConnectText:model.content];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
}


-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont rdSystemFontOfSize:fourteenFontSize];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}
-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"Message_RDNotice_icon"];
    }
    return _iconImage;
}
-(UIImageView *)backgroudImageView{
    if (!_backgroudImageView) {
        _backgroudImageView = [[UIImageView alloc] init];
        _backgroudImageView.image = [self resizableImageWithName:@"RDNotice_notice_backgroundImage"];
        
    }
    return _backgroudImageView;
}
-(UILabel *)messageTitle{
    if (!_messageTitle) {
        _messageTitle = [[UILabel alloc] init];
        _messageTitle.font = [UIFont rdSystemFontOfSize:sixteenFontSize];
    }
    return _messageTitle;
}
-(UILabel *)messageText{
    if (!_messageText) {
        _messageText = [[UILabel alloc] init];
        _messageText.font = [UIFont rdSystemFontOfSize:fourteenFontSize];
        _messageText.numberOfLines = 0;
        
    }
    return _messageText;
}
-(UIImage *)resizableImageWithName:(NSString*)name{
    UIImage *normal = [UIImage imageNamed:name];
    // 左端盖宽度
    NSInteger leftCapWidth = normal.size.width*0.5;
    // 顶端盖高度
    NSInteger topCapHeight = normal.size.height*0.5;
    // 重新赋值
    return [normal stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}
-(NSAttributedString *)changeConnectText:(NSString*)text{
    NSRange range;
    range = [text rangeOfString:@"^"];
    NSString *rangeText = [text stringByReplacingOccurrencesOfString:@"^" withString:@""];
    
    if (range.location != NSNotFound) {
        range.length = rangeText.length-range.location;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont rdSystemFontOfSize:fourteenFontSize]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:rangeText attributes:attributes];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGB(22, 131, 251) range: NSMakeRange(range.location, range.length)];
    return attributedString;
}
-(CGFloat)kBackgroundImageViewHeight{
    if (!_kBackgroundImageViewHeight) {
        CGSize size = [UILabel textForFont:fourteenFontSize andMAXSize:CGSizeMake(SCREEN_WIDTH-80, MAXFLOAT) andText:self.model.content];
        
        _kBackgroundImageViewHeight = size.height+36;
    }
    return _kBackgroundImageViewHeight;
}
@end
