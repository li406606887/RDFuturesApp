//
//  PrivacyStatementViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/26.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "PrivacyStatementViewController.h"
#import <WebKit/WebKit.h>
@interface PrivacyStatementViewController ()
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation PrivacyStatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐私声明";
    [self webView];
    
}
-(void)loadDocument:(NSString *)documentName inView:(UIWebView *)webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

-(UIWebView *)webView{
    
    if (!_webView) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];

        [self loadDocument:@"免责声明.doc" inView:_webView];
        [self.view addSubview:_webView];
        
        ///自动适应大小
        _webView.scalesPageToFit = YES;
        
        ///关闭下拉刷新效果
        _webView.scrollView.bounces = NO;
    }
    return _webView;
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
