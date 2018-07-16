//
//  JYTextField.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYTextField.h"

@implementation JYTextField

- (void)setText:(NSString *)text{
    [super setText:text];
    if (self.tmpWebView&&self.inputId) {
       [self.tmpWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').value = '%@'",self.inputId,text]];
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
