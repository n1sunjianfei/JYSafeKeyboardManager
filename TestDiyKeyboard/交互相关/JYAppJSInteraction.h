//
//  JYAppJSInteraction.h
//  WebApp
//
//  Created by ever on 17/1/5.
//  Copyright © 2017年 ever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class JYWebviewViewController;

#pragma mark - JYAppJSInteractionModel
@interface JYAppJSInteractionModel : NSObject

@property (nonatomic, copy) NSString *callMethodName;
@property (nonatomic, copy) NSString *callParam;
@property (nonatomic, copy) NSString *callBackMethodName;
// 需要调用的功能类的类名
@property (nonatomic, copy) NSString *callClassName;

@property (nonatomic, assign) BOOL isCallBackParam;

@property (nonatomic, assign, getter=isClassNameCall) BOOL classNameCall;

+ (instancetype)appJSInteractionModelWithDict:(NSDictionary *)dict;

@end

#pragma mark - AppJSProtocol
@protocol AppJSProtocol <JSExport>


- (void)showKeyBoard:(NSString*)param;

@end

@interface JYAppJSInteraction : NSObject <AppJSProtocol>

+ (instancetype)appJSInteractionWithWebView:(UIWebView *)webview;

@end
