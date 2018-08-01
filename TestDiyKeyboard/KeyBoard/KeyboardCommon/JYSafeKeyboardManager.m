//
//  JYSafeKeyboardManager.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYSafeKeyboardManager.h"

@implementation JYSafeKeyboardManager
+ (void)useWebViewSafeKeyboardWithType:(NSString*)keyboardType inputId:(NSString*)inputId webView:(id)webView frameDic:(NSDictionary*)frameDic{
    dispatch_async(dispatch_get_main_queue(), ^{
    
        __block CGFloat ratio = 1;
        CGFloat x = 0;
        __block CGFloat y = 0;
        CGFloat width = 0;
        CGFloat height = 0;
        if ([webView isKindOfClass:[WKWebView class]] ) {
            WKWebView *wkWebview = (WKWebView*)webView;
            [wkWebview evaluateJavaScript:@"document.body.scrollWidth" completionHandler:^(id _Nullable string, NSError * _Nullable error) {
                //拿文档比例
                ratio = [string floatValue]/[UIScreen mainScreen].bounds.size.width;
                //拿输入框底部距离窗口位置
                [wkWebview evaluateJavaScript:[NSString stringWithFormat:@"document.getElementById('%@').getBoundingClientRect().top+document.getElementById('%@').getBoundingClientRect().height",inputId,inputId] completionHandler:^(id _Nullable string, NSError * _Nullable error) {
                    
                    y = [string floatValue]/ratio;
                    CGRect textFrame = CGRectMake(x, y, width, height);
                    [JYWebviewKeyboardManager showKeyboardWithType:keyboardType inputId:inputId webView:wkWebview frame:textFrame];
                }];
                
            }];
        }else if ([webView isKindOfClass:[UIWebView class]]){
            UIWebView *uiWebview = (UIWebView*)webView;
            ratio = [[uiWebview stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"] floatValue]/[UIScreen mainScreen].bounds.size.width;
            y = [[uiWebview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').getBoundingClientRect().top+document.getElementById('%@').getBoundingClientRect().height",inputId,inputId]] floatValue]/ratio;
                //拿输入框底部距离窗口位置
            CGRect textFrame = CGRectMake(x, y, width, height);
            [JYWebviewKeyboardManager showKeyboardWithType:keyboardType inputId:inputId webView:uiWebview frame:textFrame];
        }else{
            //
        }
    
    });
    
}
+ (void)useSafeKeyboard:(id)inputField type:(SafeKeyboardType)keyboardType{
    [JYSafeKeyboardMain useJYSafeKeyboard:inputField type:keyboardType];
}

@end
