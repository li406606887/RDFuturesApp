//
//  OnlineServiceViewController.m
//  RDFuturesApp
//
//  Created by user on 17/3/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "OnlineServiceViewController.h"

@interface OnlineServiceViewController ()
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation OnlineServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.webView];
    self.title = @"我的客服";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-64)];
        NSURL *url = [NSURL URLWithString:@"http://p.qiao.baidu.com/cps/chat?siteId=10497801&userId=23236096"];
        // 3.创建Request
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        // 4.加载网页
        [_webView loadRequest:request];
    }
    return _webView;
}

@end
