//
//  UIInputView+SafeKeyboard.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "UITextView+SafeKeyboard.h"
#import "UIView+KeyboardExtension.h"
#import <objc/runtime.h>
#define KeyboardType_Key_inputView @"keyboardTypeKey"
#define IsUseSafeKeyboard_Key_inputView @"isUseSafeKeyboardKey"
#define IsBeginEditing_Key_inputView @"isBeginEditingKeyboardKey"

@implementation UITextView (SafeKeyboard)

- (void)addNotification{
    [[NSNotificationCenter
      defaultCenter]
     addObserver:self
     selector:@selector(beginEditing:)
     name:UITextViewTextDidBeginEditingNotification
     object:nil];
    [[NSNotificationCenter
      defaultCenter]
     addObserver:self
     selector:@selector(stopEditing:)
     name:UITextViewTextDidEndEditingNotification
     object:nil];
   
}
- (void)beginEditing:(NSNotification*)notify{
    self.isBeginEditing = [NSNumber numberWithBool:YES];
}

- (void)stopEditing:(NSNotification*)notify{
    self.isBeginEditing = [NSNumber numberWithBool:NO];
}
-(void)setSafeKeyboardType:(NSNumber *)safeKeyboardType{
    
    objc_setAssociatedObject(self, KeyboardType_Key_inputView, safeKeyboardType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber*)isBeginEditing{
    
    return objc_getAssociatedObject(self, IsBeginEditing_Key_inputView);
}
-(void)setIsBeginEditing:(NSNumber *)isBeginEditing{
    
    objc_setAssociatedObject(self, IsBeginEditing_Key_inputView, isBeginEditing, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber*)safeKeyboardType{
    
    return objc_getAssociatedObject(self, KeyboardType_Key_inputView);
}
-(void)setIsUseSafeKeyboard:(NSNumber *)isUseSafeKeyboard{
    
    objc_setAssociatedObject(self, IsUseSafeKeyboard_Key_inputView, isUseSafeKeyboard, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber*)isUseSafeKeyboard{
    return objc_getAssociatedObject(self, IsUseSafeKeyboard_Key_inputView);
}

/**
 *  光标选择的范围
 *
 *  @return 获取光标选择的范围
 */
- (NSRange)keyboard_SelectedRange{

    return self.selectedRange;

}

/**
 *  设置光标选择的范围
 *
 *  @param range 光标选择的范围
 */
- (void)keyboard_SetSelectedRange:(NSRange) range{
    //解决设置text闪跳问题
    CGPoint lastOffset = self.contentOffset;
    self.selectedRange = range;
    [self setContentOffset:lastOffset animated:NO];
//    if (self.contentOffset.y>self.contentSize.height - self.keyboard_h||self.contentOffset.y<=0) {
//        [self scrollRangeToVisible:NSMakeRange(0, 0)];
//    }else{
//        [self setContentOffset:lastOffset animated:NO];
////        self.contentOffset = lastOffset;
//    }
   
}
@end
