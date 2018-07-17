//
//  UIButton+SafeKeyboard.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "UIButton+SafeKeyboard.h"
#import "JYSafeKeyboardConfigure.h"
@implementation UIButton (SafeKeyboard)
#pragma mark - 创建按钮
+ (UIButton*)createButton:(CGRect)frame title:(NSString*)title tag:(NSInteger)tag image:(UIImage*)image selector:(SEL)seletcor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    [button setBackgroundColor:[UIColor whiteColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitleColor:[JYSafeKeyboardConfigure defaultManager].inputCharacterTextColor forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:nil action:seletcor forControlEvents:UIControlEventTouchUpInside];
    return button;
}
@end
