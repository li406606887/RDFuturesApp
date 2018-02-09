//
//  BankCardInfoViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//自定义了选择银行的弹出框，block回调处理点击事件，顶层模态视图的回收

#import "BankCardInfoViewController.h"
#import "ChooseBankView.h"
#import "ContactInfoViewController.h"
#import "BankCardModel.h"

@interface BankCardInfoViewController ()<UITextFieldDelegate>
{
    NSArray * bankArray;//弹出框数据源
    int bankID;
    BOOL isGetInfo;
    int clickCount;//blueLabel 点击计数
    int readClick;//阅读计数
}
@property (weak, nonatomic) IBOutlet UILabel *haveHkAccountLabel;//blueLabel
@property (strong, nonatomic) IBOutlet UIView *secondView;//二视图
@property (weak, nonatomic) IBOutlet UIView *secondKuangView;//二视图框
@property (weak, nonatomic) IBOutlet UILabel *shengmingLabel;//声明书内容Label

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UITextField *dollarPeopleTextfield;//美元持币人
@property (weak, nonatomic) IBOutlet UITextField *dollarAccontTextfield;
@property (weak, nonatomic) IBOutlet UILabel *dollarBankLabel;//美元银行label

@property (weak, nonatomic) IBOutlet UITextField *firstTextfield;//港币持币人
@property (weak, nonatomic) IBOutlet UITextField *bankCardTextfield;//港币账户
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;//港币银行lable

@property (weak, nonatomic) IBOutlet UIButton *readButton;//阅读btn

@end

@implementation BankCardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行结算账户";
    self.view.backgroundColor = [UIColor whiteColor];

    [self loadFirstView];
    clickCount = 1;
    [self addBlueLabelTap];
    
    [_readButton setImage:[UIImage imageNamed:@"unselected_icon"] forState:UIControlStateNormal];
    readClick = 1;
    
    [self bankArray];
    
    [self addLabelTap];
    
    isGetInfo = NO;//是否上传信息过
    
    if ([_loadType intValue]==1) {
        [self getInfo];
    }
}

#pragma mark - 叹号点击Alert
- (IBAction)shengmingBtnClick:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"声明" message:@"银行卡账户所有人必须与开户人姓名相同" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    //弹出
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark - 阅读点击
- (IBAction)readBtnClick:(id)sender {
    
    if (readClick == 1) {
        
        [_readButton setImage:[UIImage imageNamed:@"sel_kuang"] forState:UIControlStateNormal];
        //已阅读
        
        readClick =2;
        return;
    }
    if (readClick ==2) {

        [_readButton setImage:[UIImage imageNamed:@"unselected_icon"] forState:UIControlStateNormal];
        readClick = 1;
        return;
    }
    
}
#pragma mark - 添加 blueLabel 点击事件
-(void)addBlueLabelTap{
    _haveHkAccountLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeView)];
    tap.numberOfTapsRequired = 1;
    [self.haveHkAccountLabel addGestureRecognizer:tap];
    
}
#pragma mark - 切换第一第二View
-(void)changeView{
    
    if (clickCount == 1) {

        //隐藏第一
        _firstView.hidden = YES;
        _secondView.hidden = NO;
        _haveHkAccountLabel.text = @"我有香港地区的银行账户？";
        
        clickCount =2;
        return;
    }
    if (clickCount ==2) {
        _firstView.hidden = NO;
        _secondView.hidden = YES;
        _haveHkAccountLabel.text = @"我没有香港地区的银行账户？";
        
        clickCount = 1;
        return;
    }

}
#pragma mark - 加载第一视图
-(void)loadFirstView{

    _secondView.frame = CGRectMake(0, 130, SCREEN_WIDTH, 300);
    _secondKuangView.layer.borderColor = [UIColor colorWithRed:98.0/255.0 green:98.0/255.0  blue:98.0/255.0  alpha:1.0f].CGColor;
    [self.view addSubview:_secondView];
    
    _shengmingLabel.text = @"致瑞达国际金融控股有限公司：\n   由于国内外汇管制严谨，境外资金进入国内银行受到严格限制。 在此本人特此声明：\n 1、 本人知晓贵公司出金到本人国内银行账户，国内银行会有拒收的情况出现，因此本人需要有香港银行账户才能出金；\n 2、 如出金到国内银行，本人愿承担因国内银行无论以什么理由拒收而引致的所有风险和费用， 一切与贵公司无关；\n 3、 本人知晓贵公司不允许第三方出入金的规定，本人会积极去开立本人香港银行账户，以满足贵司对出入金的规定。";
    _secondView.hidden = YES;
    
    //边框
    _bankLabel.layer.borderColor = _dollarBankLabel.layer.borderColor =  _firstTextfield.layer.borderColor =_bankCardTextfield.layer.borderColor = _dollarAccontTextfield.layer.borderColor = _dollarPeopleTextfield.layer.borderColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0  blue:235.0/255.0  alpha:1.0f].CGColor;
    _bankCardTextfield.delegate = self;
}


#pragma mark -- 懒加载
- (NSArray *)bankArray
{
    if (!bankArray) {
        bankArray = @[@"中国银行（香港）",@"交通银行（香港）",@"招商银行（香港分行）",@"东亚银行",@"交通银行",@"中国建设银行",@"集友银行",@"创兴银行有限公司",@"花旗银行",@"中信银行国际",@"星展银行（香港）",@"恒生银行",@"汇丰银行",@"中国工商亚洲银行",@"南洋商业银行",@"澳洲银行",@"上海商业银行",@"渣打银行",@"永隆银行",@"其他"];
    }
    return bankArray;
}

#pragma mark --- banklabel 点击事件
-(void)addLabelTap{
    _bankLabel.userInteractionEnabled = YES;
 
    UITapGestureRecognizer * tapp1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bankTap:)];
    tapp1.numberOfTapsRequired = 1;
    [self.bankLabel addGestureRecognizer:tapp1];
    
    
    _dollarBankLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dollarBankTap:)];
    tap2.numberOfTapsRequired = 1;
    [self.dollarBankLabel addGestureRecognizer:tap2];
}
-(void)dollarBankTap:(UILabel *)sender{
    //弹框列表
    ChooseBankView * chooseView = [[ChooseBankView alloc]initWithDataArray:bankArray];
    [chooseView show];
    
    chooseView.callBackBlock = ^(NSString * tStr){
        //赋值
        _dollarBankLabel.text = bankArray[[tStr intValue]];

        isGetInfo = NO;
    };
}

-(void)bankTap:(UILabel *)sender{
    //弹框列表
    ChooseBankView * chooseView = [[ChooseBankView alloc]initWithDataArray:bankArray];
    [chooseView show];
    
    chooseView.callBackBlock = ^(NSString * tStr){
        //赋值
        _bankLabel.text = bankArray[[tStr intValue]];
        isGetInfo = NO;
    };
}

//提示框
-(void)setAlertView {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请勾选同意开户协议" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    //弹出
    [self presentViewController:alert animated:true completion:nil];
    
}
#pragma mark - set请求
-(void)setInfoWithParam:(NSMutableDictionary *)param{
    loading(@"正在提交数据");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;

        RDRequestModel * model = [RDRequest setWithApi:@"/api/account/setBankInfo.api" andParam:param error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);

                if ([model.Message isEqualToString:@"成功"]) {
                    //成功
                    ContactInfoViewController * CVC = [[ContactInfoViewController alloc]init];
                    [self.navigationController pushViewController:CVC animated:YES];

                }

            }else{
                [MBProgressHUD showError:@"请求失败"];
            }
        });
        
    });

    
}

#pragma mark - 下一步
- (IBAction)nextBtnClick:(id)sender {
    
    
    if (readClick == 1 && clickCount == 2) {
        //未同意 出现第二视图
        [self setAlertView];
        return;
    }
    if (readClick == 2 && clickCount == 2) {
        //同意 出现第二视图 is_account = 2
        NSLog(@"同意声明 出现第二视图");
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:@"2" forKey:@"is_account"];
        NSLog(@"222^^^^^%@",dic);
        [self setInfoWithParam:dic];
    }
    
    
    if (clickCount == 1) {
        //未填写信息
        if (_firstTextfield.text.length == 0 &&
            _bankCardTextfield.text.length == 0 &&
            [_bankLabel.text isEqualToString:@"请选择"] &&
            _dollarPeopleTextfield.text.length == 0 &&
            _dollarAccontTextfield.text.length == 0 &&
            [_dollarBankLabel.text isEqualToString:@"请选择"]) {
            
            showMassage(@"信息未填写")
            return;
        }
        
        //第一视图
        NSLog(@" 第一视图 ");
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"1" forKey:@"is_account"];
        
        if (_firstTextfield.text.length == 0 ||
            _bankCardTextfield.text.length == 0 ||
            [_bankLabel.text isEqualToString:@"请选择"]) {
            
            [dic setObject:@"美元" forKey:@"currency_dollar"];
            [dic setObject:_dollarPeopleTextfield.text forKey:@"dollar_card_holder"];
            [dic setObject:_dollarBankLabel.text forKey:@"dollar_bank"];
            [dic setObject:_dollarAccontTextfield.text forKey:@"dollar_card"];
            
        }else if (_dollarPeopleTextfield.text.length == 0 ||
            _dollarAccontTextfield.text.length == 0 ||
            [_dollarBankLabel.text isEqualToString:@"请选择"]) {
            
            [dic setObject:@"港币" forKey:@"currency_HK"];
            [dic setObject:_firstTextfield.text forKey:@"HK_card_holder"];
            [dic setObject:_bankLabel.text forKey:@"HK_bank"];
            [dic setObject:_bankCardTextfield.text forKey:@"HK_card"];
            
        }else{
            [dic setObject:@"美元" forKey:@"currency_dollar"];
            [dic setObject:_dollarPeopleTextfield.text forKey:@"dollar_card_holder"];
            [dic setObject:_dollarBankLabel.text forKey:@"dollar_bank"];
            [dic setObject:_dollarAccontTextfield.text forKey:@"dollar_card"];
            
            [dic setObject:@"港币" forKey:@"currency_HK"];
            [dic setObject:_firstTextfield.text forKey:@"HK_card_holder"];
            [dic setObject:_bankLabel.text forKey:@"HK_bank"];
            [dic setObject:_bankCardTextfield.text forKey:@"HK_card"];
            
        }
        
        NSLog(@"^^^^^%@",dic);
        
        [self setInfoWithParam:dic];
    }
    

}

#pragma mark - get请求
-(void)getInfo{
    
        loading(@"正在请求数据");
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error ;
    
            RDRequestModel * model = [RDRequest setWithApi:@"/api/account/getBankInfo.api" andParam:nil error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                hiddenHUD;
                if (error==nil) {
                    if ([model.State isEqualToString:@"1"]) {
                        
                        NSDictionary * infoDic = [NSDictionary dictionary];
                        infoDic = model.Data;
            
                        BankCardModel * model1 = [BankCardModel mj_objectWithKeyValues:infoDic];
                        NSString * str = [NSString stringWithFormat:@"%@",model1.is_account];
                        if ([str isEqualToString:@"1"]) {
                            
                            
                            _firstTextfield.text = [NSString stringWithFormat:@"%@",model1.HK_card_holder];
                            
                            _bankLabel.text = [NSString stringWithFormat:@"%@",model1.HK_bank];
                            
                            _bankCardTextfield.text = [NSString stringWithFormat:@"%@",model1.HK_card];
                            
                            _dollarBankLabel.text = [NSString stringWithFormat:@"%@",model1.dollar_bank];
                            
                            _dollarPeopleTextfield.text = [NSString stringWithFormat:@"%@",model1.dollar_bank_holder];
                            
                            _dollarAccontTextfield.text = [NSString stringWithFormat:@"%@",model1.dollar_card];
                            
                            if (model1.currency_HK.length == 0) {
                                _firstTextfield.text = @"";
                                _bankLabel.text = @"请选择";
                                _bankCardTextfield.text = @"";
                            }
                            
                            if (model1.currency_dollar.length== 0) {
                                _dollarAccontTextfield.text = @"";
                                _dollarBankLabel.text = @"请选择";
                                _dollarPeopleTextfield.text = @"";
                            }
                            
                            
                        }
                        showMassage(model.Message);

                    }
    
                }else{
                    [MBProgressHUD showError:promptString];
                }
                
            });
            
        });
    
}


- (void)textFieldDidEndEditing:(UITextField *)sender
{
    [sender resignFirstResponder];
}
//文本框return收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
