//
//  WKWebViewBridgeViewController.m
//  HZGWKWebView
//
//  Created by Jack on 2018/2/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "WKWebViewBridgeViewController.h"
#import <WebKit/WebKit.h>
//实现文件有针对WKWebView做处理
#import "WebViewJavascriptBridge.h"
@interface WKWebViewBridgeViewController ()<WKNavigationDelegate>
@property WebViewJavascriptBridge *bridge;
@end

@implementation WKWebViewBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    if (_bridge) { return; }
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
    
//    [_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    
    [self renderButtons:webView];
    [self loadExamplePage:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init
-(void)loadExamplePage:(WKWebView*)webView{
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *basrUrl = [NSURL URLWithString:htmlPath];
    [webView loadHTMLString:appHtml baseURL:basrUrl];
}

- (void)renderButtons:(WKWebView*)webView {
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"Call handler" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:webView];
    callbackButton.frame = CGRectMake(10, 400, 100, 35);
    callbackButton.titleLabel.font = font;
    
//    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [reloadButton setTitle:@"Reload webview" forState:UIControlStateNormal];
//    [reloadButton addTarget:webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
//    [self.view insertSubview:reloadButton aboveSubview:webView];
//    reloadButton.frame = CGRectMake(110, 400, 100, 35);
//    reloadButton.titleLabel.font = font;
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidStartLoad");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidFinishLoad");
}

#pragma mark - Action
-(void)callHandler:(UIButton *)button{
    [_bridge callHandler:@"testJavascriptHandler" data:@{@"so":@"任性咯"} responseCallback:^(id responseData) {
        NSLog(@"testJavascriptHandler responded: %@", responseData);
    }];
    
}

-(void)reload{
    NSLog(@"-------------");
}


@end
