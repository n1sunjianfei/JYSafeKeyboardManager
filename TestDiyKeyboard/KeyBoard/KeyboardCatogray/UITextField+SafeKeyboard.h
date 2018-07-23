//
//  UITextField+SafeKeyboard.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SafeKeyboard)
@property(nonatomic,strong) NSNumber *safeKeyboardType;
@property(nonatomic,strong) NSNumber *isUseSafeKeyboard;
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
@end
