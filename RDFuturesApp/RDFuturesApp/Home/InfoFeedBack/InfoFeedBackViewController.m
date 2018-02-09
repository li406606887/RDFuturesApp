//
//  InfoFeedBackViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "InfoFeedBackViewController.h"
#import <WebKit/WebKit.h>
@interface InfoFeedBackViewController ()<UIWebViewDelegate>
@property(nonatomic, strong)UIWebView * webView;
@end

@implementation InfoFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"信息反馈";
    [self.view addSubview:self.webView];
    WS(weakself)
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://p.qiao.baidu.com/cps/chat?siteId=10801271&userId=23236096"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        _webView.delegate = self;//
    
        [_webView setScalesPageToFit:YES];
    }
    return _webView;
}
- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    //半 0.25
    CGSize contentSize = theWebView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    theWebView.scrollView.minimumZoomScale = rw/4;
    theWebView.scrollView.maximumZoomScale = rw;
    theWebView.scrollView.zoomScale = rw;

    
//    NSString * javascript = [NSString stringWithFormat:@"var viewPortTag=document.createElement('meta');  \
//                  viewPortTag.id='viewport';  \
//                  viewPortTag.name = 'viewport';  \
//                  viewPortTag.content = 'width=%d; initial-scale=0.75; maximum-scale=0.5; user-scalable=0;';  \
//                  document.getElementsByTagName('head')[0].appendChild(viewPortTag);" , (int)theWebView.bounds.size.width];
//    
//    [theWebView stringByEvaluatingJavaScriptFromString:javascript];
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
