//
//  IdPhotoViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/2.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "IdPhotoViewController.h"
#import "BankCardInfoViewController.h"
#import "ShootExampleView.h"
#import "IDCardModel.h"
#import "SKFCamera.h"
#import <AipOcrSdk/AipOcrSdk.h>
@interface IdPhotoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UIImage * frontImg;
    UIImage * backImg;
    UIImage * natureImage1;
    UIImage * natureImage2;
    BOOL isGetInfo;
    NSDictionary * infoDic;//get到的数据
}

@property (weak, nonatomic) IBOutlet UIImageView *frontImgView;
@property (weak, nonatomic) IBOutlet UIImageView *backImgView;
@property (strong, nonatomic) IBOutlet UIView *secondView;//第二步视图
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pinYinTextfield;
@property (weak, nonatomic) IBOutlet UITextField *idNumTextfield;
@property (weak, nonatomic) IBOutlet UITextField *addressTextfield;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UIButton *frontButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
//
@implementation IdPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份信息";
    

    [self addSecondView];
    
    natureImage1 = _frontImgView.image;
    natureImage2 = _backImgView.image;
    
    isGetInfo = NO;//是否上传信息过
    
    if ([self.loadType intValue] == 1) {
        [self getInfo];
    }
    
    [self loadLicense];
}
#pragma mark - 加载license
-(void)loadLicense{
    
    NSString *licenseFile = [[NSBundle mainBundle] pathForResource:@"aip" ofType:@"license"];
    NSData *licenseFileData = [NSData dataWithContentsOfFile:licenseFile];
    if(!licenseFileData) {
        [[[UIAlertView alloc] initWithTitle:@"授权失败" message:@"授权文件不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
    [[AipOcrService shardService] authWithLicenseFileData:licenseFileData];
    
}
-(void)getInfo{
    
    loading(@"正在请求数据");

    __weak __typeof(self)weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest setWithApi:@"/api/account/getIdCardImage.api" andParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
//                showMassage(model.Message);

                infoDic = [NSDictionary dictionary];
                infoDic = model.Data;
                
                [weakSelf loadInfo];
                
            }else{
//                [MBProgressHUD showError:@"请求失败"];
            }
        });
        
    });

}
//加载get到的数据
-(void)loadInfo{
    
    IDCardModel * cardModel = [IDCardModel mj_objectWithKeyValues: infoDic];
    
    _pinYinTextfield.text = cardModel.spell_name;
    _idNumTextfield.text = cardModel.province_card;
    _addressTextView.text = [cardModel.certificate_address stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _nameTextfield.text = [cardModel.chinese_name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * url1 = [NSURL URLWithString:cardModel.pros_image];
    NSURL * url2 = [NSURL URLWithString:cardModel.cons_image];
    
    [_frontImgView sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"cardFront"]];
    [_backImgView sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"cardBack"]];
    
    isGetInfo = YES;

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
-(void)textFieldDidBeginEditing:(UITextField *)textField
{

}
#pragma mark - 隐藏第一视图并显示第二视图,身份证开始识别
- (IBAction)hiddenFirstView:(id)sender {
    

    if ([natureImage1 isEqual:_frontImgView.image] || [natureImage2 isEqual:_backImgView.image]) {
        
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
        
        [_backButton setTitle:@"重拍背面照" forState:UIControlStateNormal];
        [_frontButton setTitle:@"重拍正面照" forState:UIControlStateNormal];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [NSThread sleepForTimeInterval:1];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideHUD];
                _secondView.hidden = NO;
            });
            
        });
    }
    
    
}

#pragma mark - 提交服务器并push
- (IBAction)nextBtnClick:(id)sender {
    
    
    if (isGetInfo) {
        BankCardInfoViewController * BVC = [[BankCardInfoViewController alloc]init];
        [self.navigationController pushViewController:BVC animated:YES];
    }else{
    
    loading(@"正在提交数据");
    
    NSString * str1 = [RDUserInformation transBase64WithImage:self.frontImgView.image];
    NSString * str2 = [RDUserInformation transBase64WithImage:self.backImgView.image];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    

    [dic setObject:self.nameTextfield.text forKey:@"chinese_name"];
    [dic setObject:self.pinYinTextfield.text forKey:@"spell_name"];
    [dic setObject:self.idNumTextfield.text forKey:@"province_card"];
    [dic setObject:[RDUserInformation transString:self.addressTextView.text] forKey:@"certificate_address"];
    [dic setObject:str1 forKey:@"pros_image"];
    [dic setObject:str2 forKey:@"cons_image"];
    [dic setObject:@"1" forKey:@"type"];
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        

        RDRequestModel * model = [RDRequest UploadImageWithApi:@"/api/account/setIdCardImage.api" andParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                NSLog(@"%@",model.Message);
                
                if ([model.Message isEqualToString:@"成功"]) {
                   
                    BankCardInfoViewController * BVC = [[BankCardInfoViewController alloc]init];
                    [self.navigationController pushViewController:BVC animated:YES];

                }
                
            }else{
                [MBProgressHUD showError:@"请求失败"];
            }
        });
        
    });

    }
}


#pragma mark - 加载第二视图并隐藏
-(void)addSecondView{
    CGFloat Y = _firstView.frame.origin.y;
    _secondView.frame = CGRectMake(0, Y, SCREEN_WIDTH, 470);
    [self.view addSubview:_secondView];
    
    [self textfieldDelegate];
    _secondView.hidden = YES;
}
-(void)textfieldDelegate{
    _nameTextfield.delegate = self;
    _pinYinTextfield.delegate  = self;
    _idNumTextfield.delegate = self;
    _addressTextfield.delegate = self;
}

#pragma mark - 旋转
-(void)transformWithImageView:(UIImageView *)imageView{
    CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI*2);
    imageView.transform = transform;//旋转
}
//是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - 拍摄正面
- (IBAction)IDFrontBtnClick:(id)sender {
    
    
    ShootExampleView * view = [[ShootExampleView alloc]initViewTitleImgString:@"takePhoto" TitleString:@"拍照示范" SubTitleString:@"请将证件放平，手机横向拍摄。保证照片中的身份证边框完整，字体清晰，亮度均匀" BtnImgString:@"blue_btn"];
    [view show];
    view.goonBlock = ^(){
        
        SKFCamera * camera = [[SKFCamera alloc]init];
        
        camera.fininshcapture = ^(UIImage * image){
            
            _frontImgView.image = image;
            
            NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
            [[AipOcrService shardService] detectTextFromImage:image withOptions:options successHandler:^(id result) {
                
                NSMutableString *message = [NSMutableString string];
                if(result[@"words_result"]){
                    for(NSDictionary *obj in result[@"words_result"]){
                        [message appendFormat:@"%@", obj[@"words"]];
                    }
                }else{
                    [message appendFormat:@"%@", result];
                }
                //结果赋值
                
                if ([message rangeOfString:@"姓名"].location != NSNotFound &&
                    [message rangeOfString:@"性别"].location != NSNotFound &&
                    [message rangeOfString:@"住址"].location != NSNotFound &&
                    [message rangeOfString:@"公民身份号码"].location != NSNotFound){
                    
                    NSString * num = [message substringFromIndex:message.length - 18];
                    NSString * name = [message cutStringFrom:@"姓名" to:@"性别"];
                    NSString * address = [message cutStringFrom:@"住址" to:@"公民身份号码"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _idNumTextfield.text = num;
                        _nameTextfield.text = name;
                        _pinYinTextfield.text = [self transform:name];
                        _addressTextView.text = address;
                    });
                }else {
                  
                }
                
                
            } failHandler:^(NSError *err) {
                
            }];
            
        };
        
        [self presentViewController:camera animated:YES completion:nil];
        
    };

    
    //免费识别
//    ShootExampleView * view = [[ShootExampleView alloc]initViewTitleImgString:@"takePhoto" TitleString:@"拍照示范" SubTitleString:@"请将证件放平，手机横向拍摄。保证照片中的身份证边框完整，字体清晰，亮度均匀" BtnImgString:@"blue_btn"];
//    [view show];
//    view.goonBlock = ^(){
//
//        AVCaptureViewController * AVC = [[AVCaptureViewController alloc]init];
//        AVC.callBackBlock = ^(IDInfo *idInfo,UIImage *IDImage){
//            _nameTextfield.text = idInfo.name;
//            _addressTextfield.text = idInfo.address;
//            _addressTextView.text = idInfo.address;
//            _idNumTextfield.text = idInfo.num;
//            _frontImgView.image = IDImage;
//            _pinYinTextfield.text = [self transform:idInfo.name];
//            isGetInfo= NO;
//        };
//        [self presentViewController:AVC animated:YES completion:nil];
//        
//    };

}
#pragma mark - 拍摄背面
- (IBAction)IDBackBtnClick:(id)sender {
    
    
    ShootExampleView * view = [[ShootExampleView alloc]initViewTitleImgString:@"takePhoto" TitleString:@"拍照示范" SubTitleString:@"请将证件放平，手机横向拍摄。保证照片中的身份证边框完整，字体清晰，亮度均匀" BtnImgString:@"blue_btn"];
    [view show];
    view.goonBlock = ^(){
        
        SKFCamera * camera = [[SKFCamera alloc]init];
        
        camera.fininshcapture = ^(UIImage * image){
            
            _backImgView.image = image;
            isGetInfo= NO;
        };
        
        [self presentViewController:camera animated:YES completion:nil];
        
    };


}
#pragma mark - 文本框return收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)sender
{
    [sender resignFirstResponder];
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

@end
