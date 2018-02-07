//
//  WKWebViewController.m
//  HZGWKWebView
//
//  Created by Jack on 2018/2/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
/*
 *  系统要求iOS8以上
 *  官方文档
 *  https://developer.apple.com/documentation/webkit/wkwebview?language=objc
 *
 */
@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    WKWebView *_webView;
}

@end

@implementation WKWebViewController
//warning:use self in LoadView will crash
//-(void)loadView{
//    WKWebViewConfiguration *webCofiguration = [[WKWebViewConfiguration alloc] init];
//    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webCofiguration];
//    _webView.UIDelegate = self;
//    _webView.navigationDelegate = self;
//    self.view = _webView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *webCofiguration = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) configuration:webCofiguration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    NSURL *htmlUrl = [NSURL URLWithString:@"https://www.apple.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlUrl];
    [_webView loadRequest:request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"decidePolicyForNavigationAction:");
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"decidePolicyForNavigationResponse:");
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didStartProvisionalNavigation:");
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation:");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailProvisionalNavigation:");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didCommitNavigation:");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didFinishNavigation:");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailNavigation:");
}
//Invoked when the web view needs to respond to an authentication challenge.
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
//    NSLog(@"didReceiveAuthenticationChallenge:");
//}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"webViewWebContentProcessDidTerminate:");
}

#pragma mark - WKUIDelegate
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc] init];
}

-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    completionHandler(@"TextO");
}

-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    completionHandler(YES);
}

-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"runJavaScriptAlertPanelWithMessage: %@",message);
    completionHandler();
}



/*
 *  关于UIWebView转为 WKWebView
 *  WKWebView 继承了 UIWebView 大部分的接口  所以这个无须担心
 *  http://nshipster.cn/wkwebkit/
 */

-(void)WKWebKitClasses{
    //    WKBackForwardList 之前访问过的 web 页面的列表，可以通过后退和前进动作来访问到。
    //WKBackForwardListItem: webview 中后退列表里的某一个网页。
    
    //    WKFrameInfo: 包含一个网页的布局信息。
    
    //    WKNavigation: 包含一个网页的加载进度信息。
    //    WKNavigationAction: 包含可能让网页导航变化的信息，用于判断是否做出导航变化。
    //    WKNavigationResponse: 包含可能让网页导航变化的返回内容信息，用于判断是否做出导航变化。
    //    WKPreferences: 概括一个 webview 的偏好设置。
    //    WKProcessPool: 表示一个 web 内容加载池
    
    //    WKUserContentController: 提供使用 JavaScript post 信息和注射 script 的方法
    //    WKScriptMessage: 包含网页发出的信息。
    //    WKUserScript: 表示可以被网页接受的用户脚本。 > - WKWebViewConfiguration: 初始化 webview 的设置。
    
    //    WKWindowFeatures: 指定加载新网页时的窗口属性。
}

-(void)WKWebKitProtocols{
    //    WKNavigationDelegate: 提供了追踪主窗口网页加载过程和判断主窗口和子窗口是否进行页面加载新页面的相关方法。
    //    WKScriptMessageHandler: 提供从网页中收消息的回调方法。
    //    WKUIDelegate: 提供用原生控件显示网页的方法回调。
}

@end
