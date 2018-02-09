//
//  ContactInfoViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//背景设置滚动，适配小屏幕

#import "ContactInfoViewController.h"
#import "FinanceInfoViewController.h"
#import "ChooseBankView.h"
#import "ContactInfoModel.h"
//#import <IQKeyboardManager/IQKeyboardManager.h>
@interface ContactInfoViewController ()<UITextFieldDelegate>
{
    NSArray * statusArray;
    NSArray * natureArray;
    
    int occupational_status_id;
    int business_type_id;
    
    BOOL isGetInfo;
}
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *addressTextfield;
@property (weak, nonatomic) IBOutlet UITextField *companyAddressTextfield;//公司地址
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *positionTextfield;//职位
@property (weak, nonatomic) IBOutlet UITextField *yearsTextfield;//服务年限
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonViewHeight;
@property (weak, nonatomic) IBOutlet UIView *lastView;//看情况隐藏
@property (weak, nonatomic) IBOutlet UILabel *natureLabel;//业务性质
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;//职业状态
@property (weak, nonatomic) IBOutlet UIView *freeStatusBGView;//选择自由职业 时 的 业务性质
@property (weak, nonatomic) IBOutlet UILabel *freeNatureLabel;//选择自由职业 时 的 业务性质

@end

@implementation ContactInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系信息";
    
    [self setTextField];

    [self natureArray];
    [self statusArray];
    
    [self addLabelTap];
    
    isGetInfo = NO;//是否上传信息过
    
    
    if ([self.loadType intValue] == 1) {
        [self getInfo];
    }

}

-(void)getInfo{
    
    loading(@"正在请求数据");

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest setWithApi:@"/api/account/getContactInfo.api" andParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                
                NSDictionary * infoDic = [NSDictionary dictionary];
                infoDic = model.Data;
                NSLog(@"info===%@",infoDic);
                
                ContactInfoModel * model = [ContactInfoModel mj_objectWithKeyValues:infoDic];
                
                _emailTextfield.text = [NSString stringWithFormat:@"%@",model.email];
//                _addressTextfield.text = [NSString stringWithFormat:@"%@",model.postal_address];
                
                _yearsTextfield.text = [NSString stringWithFormat:@"%@",model.service_age];
                _companyAddressTextfield.text = [NSString stringWithFormat:@"%@",model.company_address];

                
                occupational_status_id = [model.occupational_status_id intValue];
                business_type_id = [model.business_type_id intValue];
                
                NSLog(@"****%d------%d",occupational_status_id,business_type_id);
                
                if (occupational_status_id == 3 || occupational_status_id == 4) {
                    _lastView.hidden = YES;
                    if (occupational_status_id == 3) {
                        _freeStatusBGView.hidden = YES;
                    }else _freeStatusBGView.hidden = NO;
                }else{
                    _lastView.hidden = NO;
                }
                
                if (occupational_status_id == 0) {
                     _statusLabel.text = @"";
                }else _statusLabel.text = statusArray[occupational_status_id - 1];
                

                if (business_type_id == 0) {
                    _natureLabel.text =@"";
                    _freeNatureLabel.text =@"";
                    
                }else{
                    _natureLabel.text = natureArray[business_type_id - 1];
                    _freeNatureLabel.text = natureArray[business_type_id - 1];
                }
                

                _companyNameTextfield.text = [NSString stringWithFormat:@"%@",model.company_name];
                _positionTextfield.text = [NSString stringWithFormat:@"%@",model.professional_position];

                isGetInfo = YES;
                
            }else{
                [MBProgressHUD showError:@"请求失败"];
            }
        });
        
    });
    
}

//手机号码的正则表达式
- (BOOL)isValidateMobile:(NSString *)mobile{
    //手机号以13、15、18开头，八个\d数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

- (NSArray *)natureArray
{
    if (!natureArray) {
        natureArray = @[@"金融业",@"机构组织",@"农林牧渔",@"医药卫生",@"建筑建材",@"冶金矿产",@"石油化工",@"水利水电",@"交通运输",@"信息产业",@"机械机电",@"服装纺织",@"专业服务",@"安全防护",@"环保绿化",@"旅游休闲",@"办公文教",@"电子电工",@"玩具礼品",@"家居用品",@"物资",@"包装",@"体育",@"办公"];
    }
    return natureArray;
}
- (NSArray *)statusArray
{
    if (!statusArray) {
        statusArray = @[@"受雇",@"自雇",@"退休",@"自由职业"];
    }
    return statusArray;
}
#pragma mark - 下一步

- (IBAction)nextBtnClick:(id)sender {
    
  
    if (_emailTextfield.text.length == 0
//        || _addressTextfield.text.length == 0
        ) {
        showMassage(@"邮箱地址未填写");
    }else{
        
        loading(@"正在提交数据");
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:_emailTextfield.text forKey:@"email"];
//        [dic setObject:_addressTextfield.text forKey:@"postal_address"];
        [dic setObject:@"1" forKey:@"postal_address"];
        
        [dic setObject:[NSString stringWithFormat:@"%d",occupational_status_id] forKey:@"occupational_status_id"];
        [dic setObject:[NSString stringWithFormat:@"%@",_companyNameTextfield.text] forKey:@"company_name"];
        [dic setObject:[NSString stringWithFormat:@"%@",_companyAddressTextfield.text] forKey:@"company_address"];
        [dic setObject:[NSString stringWithFormat:@"%@",_positionTextfield.text] forKey:@"professional_position"];
        [dic setObject:[NSString stringWithFormat:@"%@",_yearsTextfield.text] forKey:@"service_age"];
        
        if (business_type_id == 0) {
            [dic setObject:[NSString stringWithFormat:@""] forKey:@"business_type_id"];
        }else [dic setObject:[NSString stringWithFormat:@"%d",business_type_id] forKey:@"business_type_id"];
        
        
        NSLog(@"%@",dic);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error ;
            
            RDRequestModel * model = [RDRequest setWithApi:@"/api/account/setContactInfo.api" andParam:dic error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                hiddenHUD;
                if (error==nil) {
                    showMassage(model.Message);
                    NSLog(@"%@",model.Message);
                    
                    if ([model.Message isEqualToString:@"成功"]) {
                        //成功
                        FinanceInfoViewController * FVC = [[FinanceInfoViewController alloc]init];
                        [self.navigationController pushViewController:FVC animated:YES];

                    }
                    
                }else{
                    [MBProgressHUD showError:@"请求失败"];
                }
            });
            
        });
        
    }
    
}

#pragma mark ------ label 点击事件
-(void)addLabelTap{
    
    _natureLabel.userInteractionEnabled = YES;
    _statusLabel.userInteractionEnabled = YES;
    _freeNatureLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(statusTap:)];
    tapp.numberOfTapsRequired = 1;
    [self.statusLabel addGestureRecognizer:tapp];
    
    UITapGestureRecognizer * tapp1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(natureTap:)];
    tapp1.numberOfTapsRequired = 1;
    [self.natureLabel addGestureRecognizer:tapp1];
    
    UITapGestureRecognizer * tapp2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(freeNatureTap:)];
    tapp2.numberOfTapsRequired = 1;
    [self.freeNatureLabel addGestureRecognizer:tapp2];
}
-(void)freeNatureTap:(UILabel *)sender{
    [self chooseViewWithFreeNatureLabel:_freeNatureLabel andArray:natureArray];
    
    isGetInfo = NO;
}
#pragma mark - 弹出框 block 回调取值
-(void)chooseViewWithFreeNatureLabel:(UILabel *)sender andArray:(NSArray *)array
{
    
    ChooseBankView * view = [[ChooseBankView alloc]initWithDataArray:array];
    [view show];
    view.callBackBlock = ^(NSString * tStr){
        
        sender.text = array[[tStr intValue]];

        if (sender == _freeNatureLabel) {
            business_type_id = [tStr intValue] + 1;
        }
        
        isGetInfo = NO;
    };
    
}
-(void)natureTap:(UILabel *)sender{
    [self chooseViewWithTextfield:_natureLabel andArray:natureArray];
    isGetInfo = NO;
}
-(void)statusTap:(UILabel *)sender{
    [self chooseViewWithTextfield:_statusLabel andArray:statusArray];
    isGetInfo = NO;
}
-(void)addTap{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}


#pragma mark - 弹出框 block 回调取值
-(void)chooseViewWithTextfield:(UILabel *)sender andArray:(NSArray *)array
{

    ChooseBankView * view = [[ChooseBankView alloc]initWithDataArray:array];
    [view show];
    view.callBackBlock = ^(NSString * tStr){
        
        sender.text = array[[tStr intValue]];
        if ([sender.text isEqualToString:@"退休"] ||
            [sender.text isEqualToString:@"自由职业"]) {
            _lastView.hidden = YES;
            if ([sender.text isEqualToString:@"退休"]) {
                _freeStatusBGView.hidden = YES;
                _freeNatureLabel.text = @"请输入";
                business_type_id = 0;
            }else _freeStatusBGView.hidden = NO;
            
        }else{
            _lastView.hidden = NO;
            
        }
        
        if (sender == _natureLabel) {
            business_type_id = [tStr intValue] + 1;
        }else{
            occupational_status_id = [tStr intValue] + 1;
        }
        
        isGetInfo = NO;
    };
    
}



#pragma mark - 文本框return收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
#pragma mark ---邮箱地址的正则表达式
- (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark - 文本框结束编辑时
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.emailTextfield){
        //弹框
        if ([self isValidateEmail:self.emailTextfield.text]) {
            [self setAlertView];
        }else{
            [self emailErrorAlert];
        }
        
    }
    [textField resignFirstResponder];
}
-(void)emailErrorAlert{

    NSString * str = [NSString stringWithFormat:@"您填写的邮箱地址:%@格式不正确,请重新输入！",_emailTextfield.text];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:  UIAlertControllerStyleAlert];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _emailTextfield.text = @"";//赋值空
    }]];

    //弹出
    [self presentViewController:alert animated:true completion:nil];
}
#pragma mark - 提示框
-(void)setAlertView {
    
    NSString * str = [NSString stringWithFormat:@"您填写的邮箱地址将用于登录及接收结单等重要操作,请再次确认是否输入正确:%@",_emailTextfield.text];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:  UIAlertControllerStyleAlert];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        _emailTextfield.text = @"";//赋值空
    }]];
    //弹出
    [self presentViewController:alert animated:true completion:nil];
    
}
#pragma mark - 隐藏软键盘
- (void)hideKeyboard
{
    [_emailTextfield resignFirstResponder];
    [_addressTextfield resignFirstResponder];
    [_yearsTextfield resignFirstResponder];
    [_companyNameTextfield resignFirstResponder];
    [_positionTextfield resignFirstResponder];
    [_companyAddressTextfield resignFirstResponder];
    
}
#pragma mark - 设置代理
-(void)setTextField
{
    _emailTextfield.delegate = self;
    _emailTextfield.keyboardType =UIKeyboardTypeEmailAddress;
    _addressTextfield.delegate = self;
    _yearsTextfield.delegate = self;
    _companyNameTextfield.delegate = self;
    _positionTextfield.delegate = self;
    _companyAddressTextfield.delegate = self;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
