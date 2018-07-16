//
//  JYSafeKeyboardManager.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYSafeKeyboardManager.h"

@implementation JYSafeKeyboardManager
+ (void)useWebViewSafeKeyboardWithType:(NSInteger)keyboardType inputId:(NSString*)inputId webView:(UIWebView*)webview frameDic:(NSDictionary*)frameDic{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat ratio = frameDic[@"screen_ratio"]?[frameDic[@"screen_ratio"] floatValue]:1;
        CGFloat x = (frameDic[@"left"]?[frameDic[@"left"] floatValue]:0)/ratio;
        CGFloat y = (frameDic[@"top"]?[frameDic[@"top"] floatValue]:0)/ratio;
        CGFloat width = (frameDic[@"width"]?[frameDic[@"width"] floatValue]:0)/ratio;
        CGFloat height = (frameDic[@"height"]?[frameDic[@"height"] floatValue]:0)/ratio;

        CGRect textFrame = CGRectMake(x, y, width, height);
        [JYWebviewKeyboardManager showKeyboardWithType:keyboardType inputId:inputId webView:webview frame:textFrame];
    });
    
}
+ (void)useSafeKeyboard:(id)inputField type:(SafeKeyboardType)keyboardType{
    [JYSafeKeyboard useJYSafeKeyboard:inputField type:keyboardType];
}

@end
