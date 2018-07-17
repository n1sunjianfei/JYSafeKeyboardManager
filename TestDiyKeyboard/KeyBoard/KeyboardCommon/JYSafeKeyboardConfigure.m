//
//  JYSafeKeyboardConfigure.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/17.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYSafeKeyboardConfigure.h"

//特殊按钮的背景颜色
#define Keyboard_FunctionItem_BackgroundColor Keyboard_Color(41,36,36,1.0)
//普通输入按钮的背景颜色
#define Keyboard_InputItem_BackgroundColor Keyboard_Color(27,30,34,1.0)
//普通输入按钮字符的颜色
#define Keyboard_InputCharacter_TextColor [UIColor whiteColor]
//键盘背景颜色
#define Keyboard_BackgroundColor Keyboard_Color(24,26,28,1.0)
//空格文字颜色
#define Keyboard_WhiteSpace_TextColor Keyboard_Color(51, 161,251, 1.0)

static JYSafeKeyboardConfigure *globalConfigure;

@interface JYSafeKeyboardConfigure()

@end
@implementation JYSafeKeyboardConfigure

#pragma mark - 键盘管理单例
+ (instancetype)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalConfigure = [[self alloc] init];
        globalConfigure.storeValue = 0.0;
    });
    
    return globalConfigure;
}
- (UIColor*)inputCharacterTextColor{
    return _inputCharacterTextColor?:Keyboard_InputCharacter_TextColor;
}
- (UIColor*)functionItemBackgroundColor{
    return _functionItemBackgroundColor?:Keyboard_FunctionItem_BackgroundColor;
}
- (UIColor*)inputItemBackgroundColor{
    return _inputItemBackgroundColor?:Keyboard_InputItem_BackgroundColor;
}
- (UIColor*)keyboardBackgroundColor{
    return _keyboardBackgroundColor?:Keyboard_BackgroundColor;
}
- (UIColor*)whiteSpaceTextColor{
    return _whiteSpaceTextColor?:Keyboard_WhiteSpace_TextColor;
}
@end
