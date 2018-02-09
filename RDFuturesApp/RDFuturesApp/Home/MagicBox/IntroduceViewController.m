//
//  IntroduceViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/16.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "IntroduceViewController.h"
#import <WebKit/WebKit.h>
#import "AppDelegate.h"

@interface IntroduceViewController ()<UIWebViewDelegate>{
    BOOL isLoadingFinished;
}
@property(nonatomic, strong)UIWebView * webView;
@end

@implementation IntroduceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakself)
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/companyProfile/detail.api?contentId=%@",HostUrlBak,self.contentId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];


    [self.webView setScalesPageToFit:YES];

    self.webView.delegate = self;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.isForceLandscape=YES;
    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
}
//是否旋转
-(BOOL)shouldAutorotate{
    return YES;
}
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
-(void)viewWillDisappear:(BOOL)animated{
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.isForceLandscape=NO;
    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    if ([self.contentId isEqualToString:@"194"]) {
        
        [webView stringByEvaluatingJavaScriptFromString:@"var element = document.createElement('meta');  element.name = \"viewport\";  element.content = \"width=device-width,initial-scale=0.01,minimum-scale=0.5,maximum-scale=3,user-scalable=8\"; var head = document.getElementsByTagName('head')[0]; head.appendChild(element);"];
        return;
    }
    if ([self.contentId isEqualToString:@"193"]) {
        [webView stringByEvaluatingJavaScriptFromString:@"var element = document.createElement('meta');  element.name = \"viewport\";  element.content = \"width=device-width,initial-scale=0.75,minimum-scale=0.5,maximum-scale=3,user-scalable=5\"; var head = document.getElementsByTagName('head')[0]; head.appendChild(element);"];
        return;
    }
    if ([self.contentId isEqualToString:@"200"]) {
        [webView stringByEvaluatingJavaScriptFromString:@"var element = document.createElement('meta');  element.name = \"viewport\";  element.content = \"width=device-width,initial-scale=0.01,minimum-scale=0.5,maximum-scale=3,user-scalable=5\"; var head = document.getElementsByTagName('head')[0]; head.appendChild(element);"];
        return;
    }
    
    [webView stringByEvaluatingJavaScriptFromString:@"var element = document.createElement('meta');  element.name = \"viewport\";  element.content = \"width=device-width,initial-scale=1.0,minimum-scale=0.5,maximum-scale=3,user-scalable=1\"; var head = document.getElementsByTagName('head')[0]; head.appendChild(element);"];
    
    // "width=device-width,initial-scale=1.0,minimum-scale=0.5,maximum-scale=3,user-scalable=1\"
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
