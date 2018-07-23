//
//  UIInputView+SafeKeyboard.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JYSafeKeyboard.h"
@interface UITextView (SafeKeyboard)
@property(nonatomic,strong) NSNumber *safeKeyboardType;
@property(nonatomic,strong) NSNumber *isUseSafeKeyboard;
@property(nonatomic,strong) NSNumber *isBeginEditing;//用于处理键盘弹出时，区分是首次弹出还是横屏切换或者前后台切换弹出

/**
 *  光标选择的范围
 *
 *  @return 获取光标选择的范围
 */
- (NSRange)keyboard_SelectedRange;
/**
 *  设置光标选择的范围
 *
 *  @param range 光标选择的范围
 */
- (void)keyboard_SetSelectedRange:(NSRange) range;
- (void)addNotification;
@end
