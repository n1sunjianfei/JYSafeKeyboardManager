//
//  JYKeyboardMainView.h
//  StockSDK
//
//  Created by ever-mac on 2018/7/31.
//  Copyright © 2018年 ever. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SafeKeyboard_Type_Default=0,//字符
    SafeKeyboard_Type_Number,//常用数字键盘
    SafeKeyboard_Type_Number01,//定制数字键盘01
    SafeKeyboard_Type_Number02//定制数字键盘02
}SafeKeyboardType;

@protocol JYKeyboardMainViewDelegate <NSObject>
- (void)endEditing;
- (void)deletCharacter;
- (void)clearAllText;
- (void)clickInputItem:(UIButton*)sender;
- (void)changeTextFieldValue:(NSString*)value;
@end

@interface JYKeyboardMainView : UIView

@property(nonatomic,weak) id<JYKeyboardMainViewDelegate> delegate;

- (void)loadKeyboardView:(SafeKeyboardType)keyBoardType;
+ (UIView*)getCurrentFirstResponder;
@end
