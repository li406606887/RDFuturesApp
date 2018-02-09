//
//  BankInformationViewController.m
//  RDFuturesApp
//
//  Created by user on 17/4/12.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BankInformationViewController.h"

@interface BankInformationViewController ()
@property(nonatomic,strong)WKWebView *webView;

@end

@implementation BankInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    self.title = @"银行信息";
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
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-64)];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/companyProfile/detail.api?contentId=192",HostUrlBak]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    return _webView;
}
@end
