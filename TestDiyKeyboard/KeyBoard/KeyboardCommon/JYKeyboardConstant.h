//
//  JYKeyboardConstant.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#ifndef JYKeyboardConstant_h
#define JYKeyboardConstant_h

#define Keyboard_Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//特殊按钮的背景颜色
#define Keyboard_FunctionItem_BackgroundColor Keyboard_Color(220,220,220,1.0)
//普通输入按钮的背景颜色
#define Keyboard_InputItem_BackgroundColor [UIColor whiteColor]
//普通输入按钮字符的颜色
#define Keyboard_InputCharacter_BackgroundColor Keyboard_Color(41,36,33,1.0)
//键盘背景颜色
#define Keyboard_BackgroundColor [UIColor lightTextColor]
//空格文字颜色
#define Keyboard_WhiteSpace_TextColor Keyboard_Color(51, 161,251, 1.0)

#endif /* JYKeyboardConstant_h */
