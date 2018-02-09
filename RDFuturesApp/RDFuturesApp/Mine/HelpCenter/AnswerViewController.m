//
//  AnswerViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AnswerViewController.h"

@interface AnswerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) UILabel *contentLabel;
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"问题详情";
    
    self.titleLabel.text = self.titleStr;
    
    [self.view addSubview:self.contentLabel];
    
   
}
- (CGSize)textForFont:(int)font andMAXSize:(CGSize)size andText:(NSString*)text andLineSpacing:(NSInteger)lineSpacing
{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    paragraphStyle.firstLineHeadIndent = 15.0f;//首行缩进
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont rdSystemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    
    return rect.size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, getTop(self.titleLabel)+10, SCREEN_WIDTH-30, 0)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor grayColor];

        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:15];
        paragraphStyle.firstLineHeadIndent = 15.0f;//首行缩进
        NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont rdSystemFontOfSize:sixteenFontSize]};
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.contentStr attributes:attributes];
        _contentLabel.attributedText = attributedString;
        CGSize height  =  [self textForFont:sixteenFontSize andMAXSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) andText:self.contentStr andLineSpacing:15];
        
        _contentLabel.height = height.height;
    }
    return _contentLabel;
}
@end
