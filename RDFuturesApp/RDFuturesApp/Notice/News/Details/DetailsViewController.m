//
//  DetailsViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/26.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (nonatomic,strong) WKWebView *webView;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleString;
    [self webView];
    
}


-(WKWebView *)webView{

    if (!_webView) {
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        NSURL *url = [NSURL URLWithString:_urlStr];
        [self.view addSubview:_webView];
        // 3.创建Request
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        // 4.加载网页
        [_webView loadRequest:request];
        
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
