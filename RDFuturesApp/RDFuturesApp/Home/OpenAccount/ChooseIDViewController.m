//
//  ChooseIDViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ChooseIDViewController.h"
#import "IdPhotoViewController.h"
#import "HKIDPhotoViewController.h"
#import "PassportViewController.h"

// iPhone5/5c/5s/SE 4英寸 屏幕宽高：320*568点 屏幕模式：2x 分辨率：1136*640像素
#define iPhone5orSE ([UIScreen mainScreen].bounds.size.height == 568.0)

// iPhone6/6s/7 4.7英寸 屏幕宽高：375*667点 屏幕模式：2x 分辨率：1334*750像素
#define iPhone6or7 ([UIScreen mainScreen].bounds.size.height == 667.0)

// iPhone6 Plus/6s Plus/7 Plus 5.5英寸 屏幕宽高：414*736点 屏幕模式：3x 分辨率：1920*1080像素
#define iPhonePlus ([UIScreen mainScreen].bounds.size.height == 736.0)

@interface ChooseIDViewController ()
@property (weak, nonatomic) IBOutlet UIButton *daluButton;
@property (weak, nonatomic) IBOutlet UIButton *HKButton;
@property (weak, nonatomic) IBOutlet UIButton *passportButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daluWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daluHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HKWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HKHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passHeight;

@end

@implementation ChooseIDViewController
-(void)viewWillAppear:(BOOL)animated{
    
    if (iPhone5orSE) {
        _daluWidth.constant = _daluHeight.constant = _HKWidth.constant =  _HKHeight.constant = _passWidth.constant = _passHeight.constant =  100;
        
    }
    
    if (iPhone6or7) {
        _daluWidth.constant = _daluHeight.constant = _HKWidth.constant =  _HKHeight.constant = _passWidth.constant = _passHeight.constant =  130;
        
    }
    if (iPhonePlus) {
        _daluWidth.constant = _daluHeight.constant = _HKWidth.constant =  _HKHeight.constant = _passWidth.constant = _passHeight.constant =  140;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"证件选择";
    
    
}
//大陆
- (IBAction)daluBtnClick:(id)sender {
    
    IdPhotoViewController * IVC = [[IdPhotoViewController alloc]init];
    [self.navigationController pushViewController:IVC animated:YES];
    
}
//香港
- (IBAction)HKBtnClick:(id)sender {
    
    HKIDPhotoViewController * HVC = [[HKIDPhotoViewController alloc]init];
    [self.navigationController pushViewController:HVC animated:YES];
    
}
//护照
- (IBAction)PassportBtnClick:(id)sender {
    
    PassportViewController * PVC =[[PassportViewController alloc]init];
    [self.navigationController pushViewController:PVC animated:YES];
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
