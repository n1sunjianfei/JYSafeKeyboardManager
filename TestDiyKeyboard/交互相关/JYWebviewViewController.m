//
//  ViewController.m
//  WebApp
//
//  Created by ever on 17/1/5.
//  Copyright © 2017年 ever. All rights reserved.
//

#import "JYWebviewViewController.h"
#import "JYAppJSInteraction.h"
#import <JavaScriptCore/JavaScriptCore.h>

static NSString * const JY_JSContextPath = @"documentView.webView.mainFrame.javaScriptContext";

@interface JYWebviewViewController () <UIWebViewDelegate>

@property (nonatomic, strong) JSContext *context;

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURLRequest *originRequest;

@property (nonatomic, strong) JYAppJSInteraction *appJSInteraction;

/**
 跳转到设置超时时间，单位：秒，如果跳转到设置后，超过这个时间，会放弃本地跳转操作时所记录的url，下次启动应用会打开首页
 */
@property (nonatomic, assign) NSUInteger jumpTimeout;

@end

@implementation JYWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JS 交互测试安全键盘";
    // Do any additional setup after loading the view, typically from a nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.jumpTimeout = 5 * 60;
    [self setupWebView];
    [self loadRequest];
    [self setupAppJSInteraction];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.extendedLayoutIncludesOpaqueBars = NO;

    self.webView.frame = self.view.bounds;
}

// 设置app和js交互
- (void)setupAppJSInteraction {
    self.appJSInteraction = [JYAppJSInteraction appJSInteractionWithWebView:self.webView];
}

- (void)setupWebView {
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    
    if (@available(iOS 11.0, *)) {
        webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    webView.keyboardDisplayRequiresUserAction = NO;
    self.webView = webView;
    [self.view addSubview:webView];
    
}

- (void)loadRequest {
    
//    NSURL *url = nil;
    if (self.requsetUrl) {
        //URL 中含空格将其转码
        if([self.requsetUrl containsString:@" "]){
            self.requsetUrl = [self.requsetUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        NSURL *url = [NSURL URLWithString:self.requsetUrl];
        NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:self.timeoutInterval ?: (20)];
        [self.webView loadRequest:mutableRequest.copy];
    }else if (self.fileName){
        [self loadLocalHtmlWithFileName:self.fileName];
    }
    
   
}

- (void)loadLocalHtmlWithFileName:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:fileName
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
}





#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    
    // 禁用选中效果
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none'"];
    
    // BasilicaNative or AppJS
    self.context = [self.webView valueForKeyPath:JY_JSContextPath];
    
    __weak typeof(self.appJSInteraction) weakAppJS = self.appJSInteraction;
    self.context[@"AppJS"] = weakAppJS;

    self.context[@"alert"] = ^(NSString *message){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
    };
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}
#pragma mark - NSNotificationEvent

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
- (void)dealloc{
    [self.webView stopLoading];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.webView.delegate = nil;
}
@end
