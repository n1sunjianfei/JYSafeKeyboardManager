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
static NSString * const methodNameCallKeyboardFinished = @"callKeyboardFinished";

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

- (void)callKeyboard:(NSString*)param{
    NSDictionary *dic = [self parseDictWithJsonString:param];
    [JYSafeKeyboardConfigure defaultManager].storeValue = [dic[@"store"] floatValue]?:1000;
    [JYSafeKeyboardConfigure defaultManager].callBackFinishedBlock = ^(NSString *text, NSString *inputId) {
        NSDictionary *dict = @{@"inputId":inputId,@"value":text};
        NSString *str = [self toJsonString:dict];
        [self evaluateJSMethodName:methodNameCallKeyboardFinished para:str];
    };
    [JYSafeKeyboardConfigure defaultManager].isUsedInputAccessView = NO;
    [JYSafeKeyboardManager useWebViewSafeKeyboardWithType:dic[@"keyboardType"] inputId:dic[@"inputId"] webView:self.webview frameDic:nil];

}
#pragma mark --
- (NSString *)toJsonString:(id)JSONObject {
    
    if (JSONObject == nil) {
        return nil;
    }
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:JSONObject options:0 error:&error];
    if(!data) {
//        [StockUtil showLog:@"jsonObject转换为json字符串失败：", error];
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
- (void)dealloc {
    
}

@end
