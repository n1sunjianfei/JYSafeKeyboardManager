//
//  JYSafeKeyboard.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYWebviewKeyboardManager.h"
#import "JYKeyboardMainView.h"


@interface JYSafeKeyboardMain : NSObject

/**
 调用输入框

 @param inputField 为UITextField或者UITextView类型，内部过滤掉其他类型
 */
+ (void)useJYSafeKeyboard:(id)inputField type:(SafeKeyboardType)keyboardType;

+ (void)showJYSafeKeyboard:(id)inputField type:(SafeKeyboardType)keyboardType;


@end
