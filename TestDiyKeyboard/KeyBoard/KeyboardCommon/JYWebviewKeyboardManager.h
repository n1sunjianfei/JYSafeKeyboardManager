//
//  JYWebviewKeyboardManager.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>
#import "JYTextField.h"

@interface JYWebviewKeyboardManager : NSObject
@property(nonatomic,strong) JYTextField *tmpTextField;

+ (instancetype)shareWebViewManager;
+ (void)showKeyboardWithType:(NSString*)keyboardType inputId:(NSString*)inputId webView:(id)webview frame:(CGRect)textFieldFrame;
@end
