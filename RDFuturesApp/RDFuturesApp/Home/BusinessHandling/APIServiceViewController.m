//
//  APIServiceViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/15.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//green_untick

#import "APIServiceViewController.h"
#import "ShootExampleView.h"
#import "APISignatureViewController.h"
#import "SaveCompletedViewController.h"
#import "APIServiceModel.h"
@interface APIServiceViewController (){

    BOOL is_Algostar;

    int topClick;
    
    int readClick;
}

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;
@property (weak, nonatomic) IBOutlet UIButton *patentButton;
@end

@implementation APIServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"API服务申请";
    [self setLabelTap];
    [self loadBtnStatus];
    
    //获取 数据 有提交过申请patentButton不能点击
    [self getApplyInfo];
}
-(void)getApplyInfo{
    //type       类型id（0: 未申请 ，1：第一个选项，2 ：第二个选项）
    loading(@"获取数据")
    WS(weakself)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSError * error;
        RDRequestModel * model = [RDRequest getWithApi:@"/api/apply/getApply.api" andParam:nil error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            hiddenHUD;
            if (error == nil) {
                if ([model.State isEqualToString:@"1"]) {
                    NSDictionary * dic = [NSDictionary dictionary];
                    dic = model.Data;
                    
                    APIServiceModel * model = [APIServiceModel mj_objectWithKeyValues:dic];
                    NSString * type = [NSString stringWithFormat:@"%@",model.type];
                    
                    if ([type isEqualToString:@"1"]) {
                        
                        _patentButton.userInteractionEnabled = NO;
                        [_patentButton setBackgroundImage:[UIImage imageNamed:@"gray_btn"] forState:UIControlStateNormal];
                        
                        [self first];
                        
                        _readBtn.enabled = NO;
                        
                    }else if([type isEqualToString:@"2"]){
                        
                        _patentButton.userInteractionEnabled = NO;
                        [_patentButton setBackgroundImage:[UIImage imageNamed:@"gray_btn"] forState:UIControlStateNormal];
                        
                        [weakSelf second];
                        
                        _readBtn.enabled = NO;
                    }else  return;
                    
                }
                
            }else{
                [MBProgressHUD showError:promptString];
            }
        });
        
    });
}
//下一步
- (IBAction)nextBtnClick:(id)sender {
    
    NSString * str;
    str = is_Algostar?@"1":@"2";
    
    APISignatureViewController * AVC = [[APISignatureViewController alloc]init];
    AVC.typeStr = str;
    AVC.AutographBlock = ^(BOOL result){
        if (result == YES) {
            SaveCompletedViewController *saveCompleted = [[SaveCompletedViewController alloc] init];
            saveCompleted.prompt = promptTypeApiService;
            [self.navigationController pushViewController:saveCompleted animated:YES];
        }
    };
    [self presentViewController:AVC animated:YES completion:nil];
    
}

//弹框
-(void)pushImportantNotice{
    
    ShootExampleView * shootView = [[ShootExampleView alloc]initWithImportContentStr:[NSString turnTxtStringWithResourceStr:@"易盛應用程式介面(“API”)服務的使用條款及重要事項"]];
    [shootView show];
    shootView.goonBlock = ^(){
    
    };
    
}

-(void)loadBtnStatus{
    
    topClick = 1;
    is_Algostar = YES;
    [self AlgostarIsYES];
    readClick = 1;
    [_readBtn setImage:[UIImage imageNamed:@"green_untick"] forState:UIControlStateNormal];
    
    [_patentButton setBackgroundImage:[UIImage imageNamed:@"gray_btn"] forState:UIControlStateNormal];
}

- (IBAction)firstBtnClick:(id)sender {
    
    [self first];
}
-(void) first{
    if (is_Algostar) {
        return;
    }
    if (topClick == 1) {
        
        [self konwDerivativesIsNO];
        is_Algostar = NO;
        
        topClick =2;
        return;
    }
    if (topClick ==2) {
        
        [self AlgostarIsYES];
        is_Algostar = YES;
        topClick = 1;
        return;
    }
}
-(void) second{
    
    if (!is_Algostar) {
        return;
    }
    if (topClick == 1) {
        
        [self konwDerivativesIsNO];
        //打钩
        is_Algostar = NO;
        topClick =2;
        return;
    }
    if (topClick ==2) {
        
        [self AlgostarIsYES];
        is_Algostar = YES;
        
        topClick = 1;
        return;
    }

}
- (IBAction)secondBtnClick:(id)sender {
    
    [self second];
}

-(void)AlgostarIsYES{
    
    [_firstBtn setImage:[UIImage imageNamed:@"green_tick"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"green_untick"] forState:UIControlStateNormal];
}
-(void)konwDerivativesIsNO{
    
    [_firstBtn setImage:[UIImage imageNamed:@"green_untick"] forState:UIControlStateNormal];
    //打钩
    [_secondBtn setImage:[UIImage imageNamed:@"green_tick"] forState:UIControlStateNormal];
}
//已读
- (IBAction)readbtnClick:(id)sender {
    if (readClick == 1) {
        [_readBtn setImage:[UIImage imageNamed:@"green_tick"] forState:UIControlStateNormal];
        _patentButton.userInteractionEnabled = YES;
        [_patentButton setBackgroundImage:[UIImage imageNamed:@"b_btn"] forState:UIControlStateNormal];
        readClick =2;
        return;
    }
    if (readClick ==2) {
        [_readBtn setImage:[UIImage imageNamed:@"green_untick"] forState:UIControlStateNormal];
        _patentButton.userInteractionEnabled = NO;
        [_patentButton setBackgroundImage:[UIImage imageNamed:@"gray_btn"] forState:UIControlStateNormal];
        readClick = 1;
        return;
    }

    
}

-(void)setLabelTap{
    if (SCREEN_WIDTH == 320) {
        self.middleLabel.font = [UIFont rdSystemFontOfSize:12.0f];
    }else self.middleLabel.font = [UIFont rdSystemFontOfSize:14.0f];
    
    self.middleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushImportantNotice)];
    [self.middleLabel addGestureRecognizer:tap];
    
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
