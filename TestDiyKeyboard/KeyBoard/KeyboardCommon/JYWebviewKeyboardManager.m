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
#import "JYTextField.h"
#import "UIView+KeyboardExtension.h"
static JYWebviewKeyboardManager *globalManager;

@interface JYWebviewKeyboardManager()
@property(nonatomic,strong) JYTextField *tmpTextField;
@property(nonatomic,strong) NSString *inputId;
@property(nonatomic,assign) NSInteger keyboardType;
@property(nonatomic,strong) UIWebView *tmpWebView;

@end;
@implementation JYWebviewKeyboardManager

+ (void)showKeyboardWithType:(NSInteger)keyboardType inputId:(NSString*)inputId webView:(UIWebView*)webview frame:(CGRect)textFieldFrame{
//    [JYWebviewKeyboardManager shareWebViewManager].tmpWebView = webview;
    [JYWebviewKeyboardManager shareWebViewManager].inputId = inputId;
    [JYWebviewKeyboardManager shareWebViewManager].tmpWebView = webview;
    
    JYTextField *textField = [JYWebviewKeyboardManager shareWebViewManager].tmpTextField;

    NSString *string = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').value;",inputId]];
    textField.text = string;
    textField.safeKeyboardType = [NSNumber numberWithInteger:keyboardType];
    textField.inputId = inputId;
    textField.tmpWebView = webview;
    textField.frame = textFieldFrame;
//    textField.keyboard_y -= webview.scrollView.contentOffset.y;
//    [webview addSubview:textField];
    [webview.scrollView addSubview:textField];
    [textField becomeFirstResponder];
}

#pragma mark - 键盘管理单例
+ (instancetype)shareWebViewManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalManager = [[self alloc] init];
        globalManager.tmpTextField = [[JYTextField alloc]init];
        globalManager.tmpTextField.hidden = YES;
//        globalManager.tmpTextField.frame =
        CGRectMake(10.0/980*375, 500.1875/980*375, 608.15625/980*375, 86.0/980*375);
        [JYSafeKeyboardMain useJYSafeKeyboard:globalManager.tmpTextField type:SafeKeyboard_Type_Default];
    });
    
    return globalManager;
}

@end
