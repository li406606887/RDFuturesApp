//
//  PassportViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "PassportViewController.h"
#import "SKFCamera.h"
#import <AipOcrSdk/AipOcrSdk.h>
#import "ShootExampleView.h"
#import "AddressViewController.h"

@interface PassportViewController (){

        UIImage * natureImage;
}
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pinyinTextfield;
@property (weak, nonatomic) IBOutlet UITextField *numTextfield;
@property (weak, nonatomic) IBOutlet UITextView *addressTextfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BGViewHeiht;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;

@end

@implementation PassportViewController

-(void)viewWillAppear:(BOOL)animated{

    //(580/760)
    _BGViewHeiht.constant = (SCREEN_WIDTH-30)/(0.76);
    
    _bottomViewHeight.constant = _BGViewHeiht.constant + 360;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份信息";

    
//    [self addSecondView];
    natureImage = _imgView.image;
    
    _imgView.userInteractionEnabled = YES;
    
    [self loadLicense];
    
    if ([self.loadType intValue] == 1) {
        [self getInfo];
    }
    
}
#pragma mark - 加载第二视图并隐藏
-(void)addSecondView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.BGView.layer.borderColor = [UIColor colorWithRed:98.0/255.0 green:98.0/255.0  blue:98.0/255.0  alpha:1.0f].CGColor;
    
    CGFloat Y = _BGView.frame.origin.y + _BGViewHeiht.constant;
    
    NSLog(@"33333===%f,%f",_BGView.frame.origin.y,_BGViewHeiht.constant);
    _secondView.frame = CGRectMake(0, Y, SCREEN_WIDTH, 300);
    
    [self.bottomView addSubview:_secondView];
    _secondView.hidden = YES;
    
    
}
#pragma mark - license
-(void)loadLicense{

    NSString *licenseFile = [[NSBundle mainBundle] pathForResource:@"aip" ofType:@"license"];
    NSData *licenseFileData = [NSData dataWithContentsOfFile:licenseFile];
    if(!licenseFileData) {
        [[[UIAlertView alloc] initWithTitle:@"授权失败" message:@"授权文件不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
    [[AipOcrService shardService] authWithLicenseFileData:licenseFileData];

}
#pragma mark - 获取
-(void)getInfo{

    
}
#pragma mark -下一步
- (IBAction)nextBtnClick:(id)sender {
    
    if ([natureImage isEqual:_imgView.image]) {
        
        [MBProgressHUD showSuccess:@"还未拍摄证件照"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [NSThread sleepForTimeInterval:0.3];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideHUD];
                
            });
            
        });
        
    }else{
        
        _firstView.hidden = YES;
        [MBProgressHUD showSuccess:@"正在识别"];
        
        [self addSecondView];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [NSThread sleepForTimeInterval:1];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideHUD];
                _secondView.hidden = NO;
            });
            
        });
    }
}


#pragma mark -  判断是否以字母开头 正则表达
- (BOOL)isEnglishFirst:(NSString *)str {
    NSString *regular = @"^[A-Za-z].+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    
    if ([predicate evaluateWithObject:str] == YES){
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}
#pragma mark - 拍照
- (IBAction)takePhoto:(id)sender {
    
    ShootExampleView * view = [[ShootExampleView alloc]initViewTitleImgString:@"takePhoto" TitleString:@"拍照示范" SubTitleString:@"请将证件放平，手机横向拍摄。保证照片中的护照的边框完整，字体清晰，亮度均匀" BtnImgString:@"blue_btn"];
    [view show];
    
    view.goonBlock = ^(){
        
        SKFCamera * camera = [[SKFCamera alloc]init];
        
        camera.fininshcapture = ^(UIImage * image){
            
            _imgView.image = image;
            
            NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
            [[AipOcrService shardService] detectTextFromImage:image withOptions:options successHandler:^(id result) {
                
                NSLog(@"result=%@",result);
                
                NSMutableString *message = [NSMutableString string];
                
                if(result[@"words_result"]){
                    for(NSDictionary *obj in result[@"words_result"]){
                        [message appendFormat:@"%@", obj[@"words"]];
                        
                        //护照号
                        if ([self isEnglishFirst:obj[@"words"]] &&
                            
                            [NSString stringWithFormat:@"%@",obj[@"words"]].length == 9 &&
                            
                            [self isPureNumandCharacters:[[NSString stringWithFormat:@"%@",obj[@"words"]] substringFromIndex:[NSString stringWithFormat:@"%@",obj[@"words"]].length - 8]]) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                _numTextfield.text = [NSString stringWithFormat:@"%@",obj[@"words"]];
                                
                            });
    
                        }
                    }
                    
                }else{
                    [message appendFormat:@"%@", result];
                }
                NSLog(@"护照=%@",message);

                /*
                 G00000000东方/ DONG FANG名 Ciea names楚慧/ CHU HUI
                 
                 G00000000系方7oN6FANG名 Gice names楚慧/ chu hui
                 
                 CHNG00000000姓Sar东方/ DONG FANG她憲

                 G00000000东方/ DONG FANG名! Gica names楚慧/ CHU HUI
                 
                 CHNG00000000东方/ DONG FANG f 6 5 7 chu but
                 */
                
                if ([message rangeOfString:@"PASSPORET"].location != NSNotFound &&
                    [message rangeOfString:@"/"].location != NSNotFound &&
                    [message rangeOfString:@"护照"].location != NSNotFound &&
                    [message rangeOfString:@"性别"].location != NSNotFound) {
                    
                    NSString * str = [message cutStringFrom:@"PASSPORET" to:@"性别"];
                    NSString * num = [str substringToIndex:13];//G00000000
                    NSString *xing = [str cutStringFrom:num to:@"/"];//东方
                    
                    if (xing.length > 6) {
                        NSString * xing1 = [xing substringToIndex:5];
                        xing = xing1;
                    }
                
                    NSLog(@"xing=%@",xing);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _nameTextfield.text = xing;
                        
                    });

                }else{
                
                   
                }
 
                
            } failHandler:^(NSError *err) {
                
            }];
            
            
        };
        
        [self presentViewController:camera animated:YES completion:nil];
        
    };
    
}

#pragma mark -提交
- (IBAction)commitBtnClick:(id)sender {
    
    if (_pinyinTextfield.text.length == 0 ||
        _nameTextfield.text.length == 0 ||
        _numTextfield.text.length == 0 ||
        _addressTextfield.text.length == 0) {
        
        showMassage(@"资料未填写完整");
        
    }else{
        AddressViewController * AVC = [[AddressViewController alloc]init];
        AVC.nameStr = _nameTextfield.text;
        AVC.pinYinStr = _pinyinTextfield.text;
        AVC.cardNumStr = _numTextfield.text;
        AVC.addressStr = _addressTextfield.text;
        AVC.passportImage = _imgView.image;
        [self.navigationController pushViewController:AVC animated:YES];
    
    }
    
}
#pragma mark - 汉字转拼音
- (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
