//
//  JYSafeKeyboardManager.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>
#import "JYSafeKeyboardMain.h"
#import "JYWebviewKeyboardManager.h"

@interface JYSafeKeyboardManager : NSObject
+ (void)useWebViewSafeKeyboardWithType:(NSString*)keyboardType inputId:(NSString*)inputId webView:(id)webView frameDic:(NSDictionary*)frameDic;
+ (void)useSafeKeyboard:(id)inputField type:(SafeKeyboardType)keyboardType;

@end
