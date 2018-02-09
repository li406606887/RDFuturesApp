

//
//  SubscribeViewController.m
//  RDFuturesApp
//
//  Created by user on 2017/6/15.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "SubscribeViewController.h"


#define REQUESTURL self.web_url


@interface SubscribeViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,strong)WKWebViewConfiguration *webViewConfiguration;
@property (nonatomic,strong)UIProgressView *progressView;
@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleName;
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
-(void)addChildView{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];

}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    @weakify(self)
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"AppModel"]) {
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        // NSDictionary, and NSNull类型
        NSLog(@"%@", message.body);
    }
}

#pragma mark WKNavigationDelegate协议，监听网页加载周期
// 发送请求前决定是否跳转，并在此拦截拨打电话的URL
// 请求开始前，会先调用此代理方法
// 与UIWebView的
// - (BOOL)webView:(UIWebView *)webView
// shouldStartLoadWithRequest:(NSURLRequest *)request
// navigationType:(UIWebViewNavigationType)navigationType;
// 类型，在请求先判断能不能跳转（请求）

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
/// 发送请求前决定是否跳转，并在此拦截拨打电话的URL
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
//        && ![hostname containsString:@".baidu.com"]) {
//        // 对于跨域，需要手动跳转
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//        
//        // 不允许web内跳转
//        decisionHandler(WKNavigationActionPolicyCancel);
//    } else {
//        
//    }
    self.progressView.alpha = 1.0;
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"%s", __FUNCTION__);
}
/// 收到响应后决定是否跳转
// 在响应完成时，会回调此方法
// 如果设置为不允许响应，web内容就不会传过来
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"%s", __FUNCTION__);

}


/// 内容开始加载
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    self.progressView.alpha = 1.0;
}


/// 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    if (self.progressView.progress < 1.0) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.progressView.alpha = 0.0f;
        } completion:nil];
    }
    
//    /// 禁止长按弹窗，UIActionSheet样式弹窗
//    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
//    /// 禁止长按弹窗，UIMenuController样式弹窗（效果不佳）
//    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
}


//利用KVO实现进度条
-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"loading"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}


// 开始导航跳转时会回调
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

// 接收到重定向时会回调
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (error.code == NSURLErrorNotConnectedToInternet) {
        showMassage(@"加载失败");
        /// 无网络(APP第一次启动并且没有得到网络授权时可能也会报错)
        
    } else if (error.code == NSURLErrorCancelled){
        /// -999 上一页面还没加载完，就加载当下一页面，就会报这个错。
        return;
    }
    NSLog(@"%s", __FUNCTION__);
}



// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

// 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

// 9.0才能使用，web内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}
#pragma mark 懒加载 初始化配置
-(UIBarButtonItem *)leftButton{
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(gobackUpStep) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];

}
- (void)gobackUpStep{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:self.webViewConfiguration];
        
        /// 这个代理对应的协议方法常用来显示弹窗
        _webView.UIDelegate = self;
        /// 侧滑返回上一页，侧滑返回不会加载新的数据，选择性开启
        _webView.allowsBackForwardNavigationGestures = YES;
        /// 在这个代理相应的协议方法可以监听加载网页的周期和结果
        _webView.navigationDelegate = self;
        
        NSURL *url = [NSURL URLWithString:REQUESTURL];  //测试本地H5
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [_webView loadRequest:request];

        
        // 添加KVO监听
        [_webView addObserver:self
                       forKeyPath:@"loading"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
        [_webView addObserver:self
                       forKeyPath:@"title"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
        [_webView addObserver:self
                       forKeyPath:@"estimatedProgress"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
    }
    return _webView;
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading");
    } else if ([keyPath isEqualToString:@"title"]) {
        if ([self.title isEqualToString:@""]||[self.title isKindOfClass:[NSNull class]]||self.title.length<1) {
            return;
        }
        self.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    // 加载完成
    if (!self.webView.loading) {
//        // 手动调用JS代码
//        // 每次页面完成都弹出来，大家可以在测试时再打开
//        NSString *js = @"callJsAlert()";
//        [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//            NSLog(@"response: %@ error: %@", response, error);
//            NSLog(@"call js alert by native");
//        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
        }];
    }
}

-(WKWebViewConfiguration *)webViewConfiguration{
    if (!_webViewConfiguration) {
        /// 偏好设置,涉及JS交互
        _webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        _webViewConfiguration.preferences = [[WKPreferences alloc]init];
        _webViewConfiguration.preferences.javaScriptEnabled = YES;
        _webViewConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        _webViewConfiguration.processPool = [[WKProcessPool alloc]init];
        _webViewConfiguration.allowsInlineMediaPlayback = YES;
        _webViewConfiguration.userContentController = [[WKUserContentController alloc] init];
        _webViewConfiguration.processPool = [[WKProcessPool alloc] init];
    }
    return _webViewConfiguration;
}

-(UIProgressView*)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.frame = self.view.bounds;
        _progressView.trackTintColor = [UIColor whiteColor];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}
@end
