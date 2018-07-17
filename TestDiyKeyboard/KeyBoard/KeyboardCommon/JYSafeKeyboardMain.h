//
//  JYSafeKeyboard.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYWebviewKeyboardManager.h"

typedef enum {
    SafeKeyboard_Type_Default=0,//字符
    SafeKeyboard_Type_Number,//常用数字键盘
    SafeKeyboard_Type_Number01,//定制数字键盘01
    SafeKeyboard_Type_Number02//定制数字键盘02
}SafeKeyboardType;

@interface JYSafeKeyboardMain : NSObject

/**
 调用输入框

 @param inputField 为UITextField或者UITextView类型，内部过滤掉其他类型
 */
+ (void)useJYSafeKeyboard:(id)inputField type:(SafeKeyboardType)keyboardType;


@end
