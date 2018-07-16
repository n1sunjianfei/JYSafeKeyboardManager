//
//  JYWebviewKeyboardManager.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JYWebviewKeyboardManager : NSObject
+ (void)showKeyboardWithType:(NSInteger)keyboardType inputId:(NSString*)inputId webView:(UIWebView*)webview frame:(CGRect)textFieldFrame;
@end
