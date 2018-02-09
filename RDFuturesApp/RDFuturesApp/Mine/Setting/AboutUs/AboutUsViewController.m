//
//  AboutUsViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/25.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUsView.h"
#import "AboutUsViewModel.h"
#import "PrivacyStatementViewController.h"
#import "PromptView.h"

@interface AboutUsViewController ()

@property (nonatomic, strong) AboutUsView * mainView;
@property (nonatomic, strong) AboutUsViewModel * viewModel;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关于我们";
    [self.view addSubview:self.mainView];
    
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.mainView.versionLabel.text = [NSString stringWithFormat:@"瑞达国际 V%@",app_Version];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(versionTap)];
    [self.mainView.infoLabel addGestureRecognizer:tap];

}
-(void)versionTap{
    
    [self getVersionNo];

}
/*
*返回参数*
1、version_no		版本号
 */
-(void)getVersionNo{
    loading(@"");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest getWithApi:@"/api/version/getVersionNo.api" andParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                if ([model.State isEqualToString:@"1"]){
                    //服务器版本号
                    NSString * service_Version = [NSString stringWithFormat:@"%@",model.Data[@"version_no"]];
                    
                    // 获取app版本
                    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                    
                    if ([self compareEditionNumber:service_Version localNumber:app_Version]) {
                        
                        
                        PromptView *promptView = [[PromptView alloc]initWithTitleString:@"提示" SubTitleString:[NSString stringWithFormat:@"可更新到版本:%@",service_Version]];
                        promptView.goonBlock = ^(){
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/us/app/瑞达国际/id1251809883?l=zh&ls=1&mt=8"]];
                        };
                        [promptView show];
                        
                    }else{
                        showMassage(@"已经是最新版本");
                    }
                    
                }
                
            }else{
                [MBProgressHUD showError:@"请求失败"];
            }
        });
        
    });


}

//输出YES（服务器大与本地） 输出NO（服务器小于本地）
- (BOOL)compareEditionNumber:(NSString *)serverNumberStr localNumber:(NSString*)localNumberStr {
    //剔除版本号字符串中的点
    serverNumberStr = [serverNumberStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    localNumberStr = [localNumberStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    //计算版本号位数差
    int placeMistake = (int)(serverNumberStr.length-localNumberStr.length);
    //根据placeMistake的绝对值判断两个版本号是否位数相等
    if (abs(placeMistake) == 0) {
        //位数相等
        return [serverNumberStr integerValue] > [localNumberStr integerValue];
    }else {
        //位数不等
        //multipleMistake差的倍数
        NSInteger multipleMistake = pow(10, abs(placeMistake));
        NSInteger server = [serverNumberStr integerValue];
        NSInteger local = [localNumberStr integerValue];
        if (server > local) {
            return server > local * multipleMistake;
        }else {
            return server * multipleMistake > local;
        }
    }
}
-(void)bindViewModel{
    
    WS(weakself)
    
    [[self.viewModel.labelClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        int index = [x intValue];

        switch (index) {
            case 1:
            {
                PrivacyStatementViewController * PVC = [[PrivacyStatementViewController alloc]init];
                [weakSelf.navigationController pushViewController:PVC animated:YES];
            }
                break;
            case 2:
            {//拨号
                NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"0085225342000"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
                break;
                
            default:
                break;
        }
        
    }];
    
    
}
-(void)updateViewConstraints{

    WS(weakself)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

-(AboutUsView *)mainView{

    if (!_mainView) {
        _mainView = [[AboutUsView alloc]initWithViewModel:self.viewModel];
        _mainView.backgroundColor = LIGHTGRAYCOLOR;
    }
    return _mainView;
}

-(AboutUsViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[AboutUsViewModel alloc]init];
    }
    return _viewModel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
