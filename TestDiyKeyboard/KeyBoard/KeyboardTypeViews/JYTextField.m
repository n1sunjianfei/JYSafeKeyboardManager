//
//  JYTextField.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYTextField.h"
#import "JYSafeKeyboardConfigure.h"
@implementation JYTextField

- (void)setText:(NSString *)text{
    [super setText:text];
    if (self.tmpWebView&&self.inputId) {
        
        NSString *callBackName = [JYSafeKeyboardConfigure defaultManager].callBackFinishedName;
        if (callBackName&&![callBackName isEqual:@""]) {
            NSString *str = [NSString stringWithFormat:@"%@('{\"inputId\":\"%@\",\"value\":\"%@\"}')",callBackName, self.inputId, text];
            if ([self.tmpWebView isKindOfClass:[WKWebView class]]) {
                [self.tmpWebView evaluateJavaScript:str completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                    
                }];
            }else if ([self.tmpWebView isKindOfClass:[UIWebView class]]){
                [self.tmpWebView stringByEvaluatingJavaScriptFromString:str];

            }
            
        }else{
            if ([self.tmpWebView isKindOfClass:[WKWebView class]]) {
                //WKWebview
                [self.tmpWebView evaluateJavaScript:[NSString stringWithFormat:@"document.getElementById('%@').value = '%@'",self.inputId,text] completionHandler:nil];
                
            }else if ([self.tmpWebView isKindOfClass:[UIWebView class]]){
                [self.tmpWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').value = '%@'",self.inputId,text]];
            }
        }
    }
}
- (BOOL)endEditing:(BOOL)force{
    
    self.tmpWebView = nil;
    self.inputId = nil;
    [self removeFromSuperview];
    return [super endEditing:force];
}
- (BOOL)resignFirstResponder{
    self.tmpWebView = nil;
    self.inputId = nil;
    return [super resignFirstResponder];
}
@end
