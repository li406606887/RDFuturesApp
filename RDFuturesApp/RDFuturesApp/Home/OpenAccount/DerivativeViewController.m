//
//  DerivativeViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/20.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//衍生产品认知 green_untick

#import "DerivativeViewController.h"
#import "OtherInforViewController.h"
#import "ProgressViewController.h"
@interface DerivativeViewController (){
    
    BOOL is_konw_derivatives;
    BOOL is_derivative_trading;

    int topClick;
    int bottomClick;

}
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthButton;

@end

@implementation DerivativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"衍生产品认知";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    topClick= bottomClick = 1;
    
    is_konw_derivatives = YES;
    is_derivative_trading = YES;
    

    [self knowDerivativesIsYES];
    [self derivativeTradingIsYES];
    
//    if ([_loadType intValue]==1) {
//    }
    [self getDerivativeCognition];
    
}
//
-(void)getDerivativeCognition{
    
    loading(@"正在请求数据");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest setWithApi:@"/api/account/getDerivativeCognition.api" andParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                if ([model.State isEqualToString:@"1"]) {
                    NSDictionary * infoDic = [NSDictionary dictionary];
                    infoDic = model.Data;
                    switch ([infoDic[@"know_derivatives"] intValue]) {
                        case 1:
                        {
                            is_konw_derivatives = NO;
                            topClick = 2;
                            [self first];
                        }
                            break;
                        case 2:
                        {
                            is_konw_derivatives = YES;
                            topClick = 1;
                            [self second];
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                
                    switch ([infoDic[@"derivative_trading"] intValue]) {
                        case 1:
                        {
                            is_derivative_trading = NO;
                            bottomClick = 2;
                            [self third];
                        }
                            break;
                        case 2:
                        {
                            is_derivative_trading = YES;
                            bottomClick = 1;
                            [self fourth];
                        }
                            break;
                            
                        default:
                            break;
                    }

                    
                }else{
                    showMassage(model.Message);

                }
                
            }else{
                [MBProgressHUD showError:promptString];
            }
        });
        
    });


}
- (IBAction)firstBtnClick:(id)sender {
    
    [self first];
    
}
-(void)first{

    if (is_konw_derivatives) {
        return;
    }
    if (topClick == 1) {
        
        [self konwDerivativesIsNO];
        is_konw_derivatives = NO;
        
        topClick =2;
        return;
    }
    if (topClick ==2) {
        
        [self knowDerivativesIsYES];
        is_konw_derivatives = YES;
        topClick = 1;
        return;
    }
}
-(void)knowDerivativesIsYES{

    [_firstButton setImage:[UIImage imageNamed:@"green_tick"] forState:UIControlStateNormal];
    [_secondButton setImage:[UIImage imageNamed:@"green_untick"] forState:UIControlStateNormal];
}
-(void)konwDerivativesIsNO{
    
    [_firstButton setImage:[UIImage imageNamed:@"green_untick"] forState:UIControlStateNormal];
    //打钩
    [_secondButton setImage:[UIImage imageNamed:@"green_tick"] forState:UIControlStateNormal];
}
- (IBAction)secondBtnClick:(id)sender {
    
    [self second];
    
}
-(void)second{

    if (!is_konw_derivatives) {
        return;
    }
    if (topClick == 1) {
        

        [self konwDerivativesIsNO];
        //打钩
        is_konw_derivatives = NO;
        topClick =2;
        return;
    }
    if (topClick ==2) {
        

        [self knowDerivativesIsYES];
        is_konw_derivatives = YES;
        
        topClick = 1;
        return;
    }
}

//下部
- (IBAction)thirdBtnClick:(id)sender {
    
    [self third];
    
}
-(void)third{
    
    if (is_derivative_trading) {
        return;
    }
    if (bottomClick == 1) {
        
        [self derivativeTradingIsNO];
        //打钩
        is_derivative_trading = NO;
        bottomClick =2;
        return;
    }
    if (bottomClick ==2) {
        
        [self derivativeTradingIsYES];
        is_derivative_trading = YES;
        bottomClick = 1;
        return;
    }

}


-(void)derivativeTradingIsYES{
    
    [_thirdButton setImage:[UIImage imageNamed:@"green_tick"] forState:UIControlStateNormal];
    [_fourthButton setImage:[UIImage imageNamed:@"green_untick"] forState:UIControlStateNormal];
    
}

-(void)derivativeTradingIsNO{
 
    [_thirdButton setImage:[UIImage imageNamed:@"green_untick"] forState:UIControlStateNormal];
    [_fourthButton setImage:[UIImage imageNamed:@"green_tick"] forState:UIControlStateNormal];
}

- (IBAction)fourthBtnClick:(id)sender {
    [self fourth];
}
-(void)fourth{

    if (!is_derivative_trading) {
        return;
    }
    if (bottomClick == 1) {
        
        [self derivativeTradingIsNO];
        is_derivative_trading = NO;
        
        bottomClick =2;
        return;
    }
    if (bottomClick ==2) {
        
        [self derivativeTradingIsYES];
        is_derivative_trading = YES;
        bottomClick = 1;
        return;
    }
}
#pragma mark  - 下一步
- (IBAction)nextBtnClick:(id)sender {
    

    NSString * str,*str1;

    str = is_konw_derivatives?@"1":@"2";
    str1 = is_derivative_trading?@"1":@"2";
    
    loading(@"正在提交数据");
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:str forKey:@"know_derivatives"];
    [dic setObject:str1 forKey:@"derivative_trading"];
    
    NSLog(@"%@",dic);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest setWithApi:@"/api/account/setDerivativeCognition.api" andParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                NSLog(@"%@",model);
                
                if ([model.State isEqualToString:@"1"]) {
                    //成功
                    OtherInforViewController * OVC = [[OtherInforViewController alloc]init];
                    [self.navigationController pushViewController:OVC animated:YES];

                }
                
            }else{
                [MBProgressHUD showError:promptString];
                
            }
        });
        
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
