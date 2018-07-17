//
//  JYSafeKeyboardConfigure.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/17.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define Keyboard_Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface JYSafeKeyboardConfigure : NSObject

//特殊按钮的背景颜色
@property(nonatomic,assign) UIColor *functionItemBackgroundColor;
//普通输入按钮的背景颜色
@property(nonatomic,strong) UIColor *inputItemBackgroundColor;
//普通输入按钮文字的颜色
@property(nonatomic,strong) UIColor *inputCharacterTextColor;
//键盘背景颜色
@property(nonatomic,strong) UIColor *keyboardBackgroundColor;
//空格文字颜色
@property(nonatomic,strong) UIColor *whiteSpaceTextColor;
//InputAccessView背景颜色
@property(nonatomic,strong) UIColor *inputAccessViewBgColor;
//InputAccessView文字颜色
@property(nonatomic,strong) UIColor *inputAccessViewTextColor;

//仓库数量
@property(nonatomic,assign) float storeValue;
//是否使用InputAccessView
@property(nonatomic,assign) BOOL isUsedInputAccessView;

+ (instancetype)defaultManager;

@end
