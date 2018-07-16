//
//  JYSafeKeyboardManager.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JYSafeKeyboard.h"
#import "JYWebviewKeyboardManager.h"
#import "JYKeyBoardListener.h"
@interface JYSafeKeyboardManager : NSObject
+ (void)useWebViewSafeKeyboardWithType:(NSInteger)keyboardType inputId:(NSString*)inputId webView:(UIWebView*)webview frameDic:(NSDictionary*)frameDic;
+ (void)useSafeKeyboard:(id)inputField type:(SafeKeyboardType)keyboardType;
@end
