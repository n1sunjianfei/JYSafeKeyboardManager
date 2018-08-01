//
//  JYWebviewKeyboardManager.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYWebviewKeyboardManager.h"
#import "JYSafeKeyboardMain.h"
#import "UITextField+SafeKeyboard.h"
#import "UIView+KeyboardExtension.h"
#import <WebKit/WKWebView.h>

static JYWebviewKeyboardManager *globalManager;

@interface JYWebviewKeyboardManager()

@property(nonatomic,strong) NSString *inputId;
@property(nonatomic,assign) NSInteger keyboardType;
@property(nonatomic,strong) id tmpWebView;

@end;
@implementation JYWebviewKeyboardManager

+ (void)showKeyboardWithType:(NSString*)keyboardType inputId:(NSString*)inputId webView:(id)webview frame:(CGRect)textFieldFrame{
    [JYWebviewKeyboardManager shareWebViewManager].tmpWebView = webview;
    [JYWebviewKeyboardManager shareWebViewManager].inputId = inputId;
    
    JYTextField *textField = [JYWebviewKeyboardManager shareWebViewManager].tmpTextField;
    
    
    
    textField.inputId = inputId;
    textField.tmpWebView = webview;
    textField.safeKeyboardType = [NSNumber numberWithInteger:[self returnKeyboardType:keyboardType]];

    __block NSString *text = @"";
    
    UIScrollView *scrollView = nil;
    
    if ([webview isKindOfClass:[WKWebView class]]) {
        WKWebView *wkWebview = (WKWebView*)webview;
        [wkWebview evaluateJavaScript:[NSString stringWithFormat:@"document.getElementById('%@').value;",inputId] completionHandler:^(id _Nullable string, NSError * _Nullable error) {
            text = string;
            textField.text = text;
            
        }];
        textFieldFrame.origin.y+=wkWebview.scrollView.contentOffset.y;
        textField.frame = textFieldFrame;
    
        scrollView = wkWebview.scrollView;
        
        
    }else if([webview isKindOfClass:[UIWebView class]]){
        UIWebView *uiWebview = (UIWebView*)webview;
        text = [uiWebview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').value;",inputId]];
        textField.text = text;
        textFieldFrame.origin.y+=uiWebview.scrollView.contentOffset.y;
        textField.frame = textFieldFrame;
        

        scrollView = uiWebview.scrollView;
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //第一种处理方式，使用window上添加键盘view
        //[JYSafeKeyboardMain showJYSafeKeyboard:[JYWebviewKeyboardManager shareWebViewManager].tmpTextField type:[self returnKeyboardType:keyboardType]];
        
        //第二种处理方式，使用类系统键盘方式，但是存在点击一个输入框就隐藏键盘然后重新显示的问题
        [JYSafeKeyboardMain useJYSafeKeyboard:[JYWebviewKeyboardManager shareWebViewManager].tmpTextField type:[self returnKeyboardType:keyboardType]];
        [textField becomeFirstResponder];
        [scrollView addSubview:textField];
    });
}
+ (SafeKeyboardType)returnKeyboardType:(NSString*)typeStr{
    if ([typeStr isEqualToString:@"normal"]) {
        return SafeKeyboard_Type_Default;
    }else if ([typeStr isEqualToString:@"stockNumber"]){
        return SafeKeyboard_Type_Number01;
    }else if ([typeStr isEqualToString:@"stockPrice"]){
        return SafeKeyboard_Type_Number02;

    }else if ([typeStr isEqualToString:@"number"]){
        return SafeKeyboard_Type_Number;
    }else{
        return SafeKeyboard_Type_Default;
    }
    
    
}
#pragma mark - 键盘管理单例
+ (instancetype)shareWebViewManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalManager = [[self alloc] init];
        globalManager.tmpTextField = [[JYTextField alloc]init];
        globalManager.tmpTextField.hidden = YES;
        globalManager.tmpTextField.backgroundColor = [UIColor redColor];
//        globalManager.tmpTextField.frame =
        CGRectMake(10.0/980*375, 500.1875/980*375, 608.15625/980*375, 86.0/980*375);
//        [JYSafeKeyboardMain useJYSafeKeyboard:globalManager.tmpTextField type:SafeKeyboard_Type_Default];
    });
    
    return globalManager;
}

@end
