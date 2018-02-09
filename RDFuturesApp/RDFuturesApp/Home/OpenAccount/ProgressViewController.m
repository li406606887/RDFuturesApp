//
//  ProgressViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ProgressViewController.h"
#import "IntroduceViewController.h"
@interface ProgressViewController ()
{
    NSString * statesStr;
}
@property (weak, nonatomic) IBOutlet UILabel *huifangStatusLabel;//回访状态
@property (weak, nonatomic) IBOutlet UILabel *jianzhengStatusLabel;//见证状态
@property (weak, nonatomic) IBOutlet UILabel *checkStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *AccountLabel;
@property (weak, nonatomic)  IBOutlet UIImageView *statesImgView;
@property (weak, nonatomic) IBOutlet UIView *whiteBGView;
@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"进度查询";
    
    [self loadingGetData];
    [self changeImageViewAndData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.PuchStyle ==YES) {
        [self hiddenCloseBtnClick];
    }
}
-(void)loadingGetData{
    loading(@"");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *error;
        RDRequestModel *model = [RDRequest postSpeedInfoWithParam:nil
                                                            error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error ==nil) {
                if ([model.State  isEqualToString:@"1"]) {
                    NSDictionary *dic = model.Data;
                    self.nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"chinese_name"]];
                    self.AccountLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"customer_id"]];
                    statesStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"speed_status"]];
                    [self changeImageViewAndData];
                }else{
                    showMassage(model.Message)
                }
            }else{
                [MBProgressHUD showError:promptString];
            }
            
        });
    });
}
#pragma mark - 指引按钮
- (IBAction)guideBtnClick:(id)sender {
    
    IntroduceViewController * IVC = [[IntroduceViewController alloc]init];
    IVC.title = @"出入金流程";
    IVC.contentId = @"197";
    [self.navigationController pushViewController:IVC animated:YES];
}
#pragma mark - 完成按钮
- (IBAction)finishBtnClick:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)changeImageViewAndData{
    //progress_zero_red  progress_one_red progress_two_red progress_three_red   progress_four_red

    switch ([statesStr intValue]) {
        case 0:{
            _statesImgView.image = [UIImage imageNamed:@"progress_zero_red"];
            _checkStatusLabel.text = @"未开户";
        }
            break;
        case 1:{//1：资料审核
            _statesImgView.image = [UIImage imageNamed:@"progress_one_red"];
            _checkStatusLabel.text = @"等待审核";
        }
            break;
        case 2:{//2：资料审核完成（见证客户中）
            _statesImgView.image = [UIImage imageNamed:@"progress_two_red"];
            _checkStatusLabel.text = @"审核通过";
            _jianzhengStatusLabel.text = @"见证中";
        }
            break;
        case 3:{//3：资料审核失败
            _statesImgView.image = [UIImage imageNamed:@"progress_zero_red"];
            _checkStatusLabel.text = @"审核未通过";
        }
            break;
        case 4:{//4：见证客户完成（客服回访中）
            _statesImgView.image = [UIImage imageNamed:@"progress_three_red"];
            _checkStatusLabel.text = @"审核通过";
            _jianzhengStatusLabel.text = @"见证完成";
            _huifangStatusLabel.text = @"正在回访……";
        }
            break;
        case 5:{// 5：见证客户失败
            _statesImgView.image = [UIImage imageNamed:@"progress_zero_red"];
            _checkStatusLabel.text = @"审核通过";
            _jianzhengStatusLabel.text = @"客户见证未通过";
        }
            break;
        case 6:{//客服回访完成
            _statesImgView.image = [UIImage imageNamed:@"progress_three_red"];
            _checkStatusLabel.text = @"审核通过";
            _jianzhengStatusLabel.text = @"见证完成";
            _huifangStatusLabel.text = @"回访完成";
        }
            break;
        case 7:{//	7：客服回访失败
            _statesImgView.image = [UIImage imageNamed:@"progress_zero_red"];
            _checkStatusLabel.text = @"审核通过";
            _jianzhengStatusLabel.text = @"见证完成";
            _huifangStatusLabel.text = @"客服回访未通过";
        }
            break;
        case 8:{//8：开户成功
            _statesImgView.image = [UIImage imageNamed:@"progress_four_red"];
            _checkStatusLabel.text = @"审核通过";
            _jianzhengStatusLabel.text = @"见证完成";
            _huifangStatusLabel.text = @"回访完成";
        }
            break;
        case 9:{//9：开户失败）
            _statesImgView.image = [UIImage imageNamed:@"progress_zero_red"];
            _checkStatusLabel.text =_jianzhengStatusLabel.text =_huifangStatusLabel.text= @"开户未通过";
        
        }
            break;
            
        default:
            break;
    }
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
