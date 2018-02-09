//
//  AddressViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AddressViewController.h"
#import "BankCardInfoViewController.h"
#import "ShootExampleView.h"
#import "SKFCamera.h"
@interface AddressViewController (){
    
    UIImage * natureImage;
}
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BGViewHeight;

@end

@implementation AddressViewController
-(void)viewWillAppear:(BOOL)animated{
    
    _BGViewHeight.constant = (SCREEN_WIDTH-30)/(0.983);
    
    _bottomViewHeight.constant = _BGViewHeight.constant + 270;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"住宅信息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.BGView.layer.borderColor = [UIColor colorWithRed:98.0/255.0 green:98.0/255.0  blue:98.0/255.0  alpha:1.0f].CGColor;
    
    
    natureImage = _imgView.image;
}
#pragma mark - 拍照
- (IBAction)takePhoto:(id)sender {
    
    
    ShootExampleView * view = [[ShootExampleView alloc]initViewTitleImgString:@"takePhoto" TitleString:@"拍照示范" SubTitleString:@"请将证件放平，手机横向拍摄。保证照片中的身份证边框完整，字体清晰，亮度均匀" BtnImgString:@"blue_btn"];
    [view show];
    view.goonBlock = ^(){
        
        SKFCamera * camera = [[SKFCamera alloc]init];
        
        camera.fininshcapture = ^(UIImage * image){
            
            _imgView.image = image;
            
        };
        
        [self presentViewController:camera animated:YES completion:nil];
        
    };

}

-(void)postInfo{

    loading(@"正在提交数据");
    
    NSString * str1 = [RDUserInformation transBase64WithImage:self.imgView.image];
    NSString * str2 = [RDUserInformation transBase64WithImage:self.passportImage];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:self.nameStr forKey:@"chinese_name"];
    [dic setObject:self.pinYinStr forKey:@"spell_name"];
    [dic setObject:self.cardNumStr forKey:@"province_card"];
    [dic setObject:self.addressStr forKey:@"certificate_address"];
    [dic setObject:str1 forKey:@"address_image"];
    [dic setObject:str2 forKey:@"passport_image"];
    [dic setObject:@"3" forKey:@"type"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest UploadImageWithApi:@"/api/account/setIdCardImage.api" andParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                NSLog(@"%@",model.Message);
                
                if ([model.Message isEqualToString:@"成功"]) {
                    //成功
                    BankCardInfoViewController * BVC = [[BankCardInfoViewController alloc]init];
                    [self.navigationController pushViewController:BVC animated:YES];
                    
                }
                
            }else{
                [MBProgressHUD showError:@"请求失败"];
            }
        });
        
    });

}
#pragma mark - 下一步
- (IBAction)commitBtnClick:(id)sender {
    //判断image
    if ([natureImage isEqual:_imgView.image]) {
        
        [MBProgressHUD showSuccess:@"还未拍摄证件照"];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [NSThread sleepForTimeInterval:0.3];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideHUD];
                
            });
            
        });
        
    }else
        [self postInfo];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
