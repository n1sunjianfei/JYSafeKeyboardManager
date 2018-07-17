//
//  JYAppJSInteraction.m
//  WebApp
//
//  Created by ever on 17/1/5.
//  Copyright © 2017年 ever. All rights reserved.
//

#import "JYAppJSInteraction.h"
#import "JYSafeKeyboard.h"
static NSString * const methodNameLivenessDetectorFinished = @"livenessDetectorFinished";

@implementation JYAppJSInteractionModel

+ (instancetype)appJSInteractionModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initAppJSInteractionModelWithDict:dict];
}

- (instancetype)initAppJSInteractionModelWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
        self.classNameCall = [dict[@"classNameCall"] boolValue];
        self.callParam = dict[@"callBackParam"] ?: @"";
        self.callMethodName = dict[@"callMethodName"] ?: @"";
        if (self.callParam.length > 0) {
            self.callMethodName = [self.callMethodName stringByAppendingString:@":"] ?: @"";
        }

        self.isCallBackParam = [dict[@"isCallBackParam"] boolValue];
        self.callBackMethodName = dict[@"callBackMethodName"] ?: @"";
        
    }
    return self;
}

@end

@interface JYAppJSInteraction ()

@property (nonatomic, strong) UIWebView *webview;

@property (nonatomic, weak) JYWebviewViewController *webVC;

@end

@implementation JYAppJSInteraction


+ (instancetype)appJSInteractionWithWebView:(UIWebView *)webview {
    JYAppJSInteraction *interaction = [[JYAppJSInteraction alloc] init];
    interaction.webview = webview;
    return interaction;
}

#pragma mark - 将param 转换成字典
- (NSDictionary *)parseDictWithData:(NSData *)data {
    if (data == nil || data.length == 0) {
        return nil;
    }
    
    NSError *error = nil;
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"%s,%d,%@",__func__,__LINE__,error);
        return nil;
    }
    return dict;
}

- (NSDictionary *)parseDictWithJsonString:(NSString *)jsonStr {
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    return [self parseDictWithData:data];
}

- (JYAppJSInteractionModel *)dictToModelWithDict:(NSDictionary *)dict {
    return [JYAppJSInteractionModel appJSInteractionModelWithDict:dict];
}

- (JYAppJSInteractionModel *)jsonStringToModelWithString:(NSString *)jsonStr {
    NSDictionary *dict = [self parseDictWithJsonString:jsonStr];
    
    if (dict == nil) {
        return nil;
    }
    return [self dictToModelWithDict:dict];
}

#pragma mark - JS
// 执行js
- (void)evaluateJSWithString:(NSString *)jsStr {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webview stringByEvaluatingJavaScriptFromString:jsStr];
    });

}


// 执行有参js方法
- (void)evaluateJSMethodName:(NSString *)methodName para:(NSString *)param {
    
    NSString *jsStr = nil;
    
    if (param) {
        jsStr = [NSString stringWithFormat:@"%@('%@')",methodName, param];
    }
    else {
        jsStr = [NSString stringWithFormat:@"%@()",methodName];
    }
    
    [self evaluateJSWithString:jsStr];
    
}

// 执行无参js方法
- (void)evaluateJSMethodName:(NSString *)methodName {
    [self evaluateJSMethodName:methodName para:nil];
}


#pragma mark - AppJSProtocol

- (void)showKeyBoard:(NSString*)param{
    NSDictionary *dic = [self parseDictWithJsonString:param];
    NSDictionary *frameDic = dic[@"frame"];
    NSLog(@"%@",dic);
    [JYSafeKeyboardConfigure defaultManager].storeValue = [dic[@"store"] floatValue];
    [JYSafeKeyboardManager useWebViewSafeKeyboardWithType:[dic[@"type"] integerValue] inputId:dic[@"inputid"] webView:self.webview frameDic:frameDic];
}

- (void)dealloc {
}



@end
