//
//  UITextField+SafeKeyboard.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "UITextField+SafeKeyboard.h"
#import <objc/runtime.h>

#define KeyboardType_Key_textField @"keyboardTypeKey"
#define IsUseSafeKeyboard_Key_textField @"isUseSafeKeyboardKey"

@implementation UITextField (SafeKeyboard)

-(void)setSafeKeyboardType:(NSNumber *)safeKeyboardType{
    
    objc_setAssociatedObject(self, KeyboardType_Key_textField, safeKeyboardType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber*)safeKeyboardType{
    
    return objc_getAssociatedObject(self, KeyboardType_Key_textField);
}

-(void)setIsUseSafeKeyboard:(NSNumber *)isUseSafeKeyboard{
    
    objc_setAssociatedObject(self, IsUseSafeKeyboard_Key_textField, isUseSafeKeyboard, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber*)isUseSafeKeyboard{
    return objc_getAssociatedObject(self, IsUseSafeKeyboard_Key_textField);
}

/**
 *  光标选择的范围
 *
 *  @return 获取光标选择的范围
 */
- (NSRange)keyboard_SelectedRange{
    //开始位置
    UITextPosition* beginning = self.beginningOfDocument;
    //光标选择区域
    UITextRange* selectedRange = self.selectedTextRange;
    //选择的开始位置
    UITextPosition* selectionStart = selectedRange.start;
    //选择的结束位置
    UITextPosition* selectionEnd = selectedRange.end;
    //选择的实际位置
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    //选择的长度
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

/**
 *  设置光标选择的范围
 *
 *  @param range 光标选择的范围
 */
- (void)keyboard_SetSelectedRange:(NSRange) range{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}
@end
