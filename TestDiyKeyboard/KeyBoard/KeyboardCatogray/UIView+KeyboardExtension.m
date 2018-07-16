//  代码地址: https://github.com/CoderkeyboardLee/keyboardRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIView+Extension.m
//  keyboardRefreshExample
//
//  Created by keyboard Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "UIView+KeyboardExtension.h"

@implementation UIView (KeyboardExtension)
- (void)setKeyboard_x:(CGFloat)keyboard_x
{
    CGRect frame = self.frame;
    frame.origin.x = keyboard_x;
    self.frame = frame;
}

- (CGFloat)keyboard_x
{
    return self.frame.origin.x;
}

- (void)setKeyboard_y:(CGFloat)keyboard_y
{
    CGRect frame = self.frame;
    frame.origin.y = keyboard_y;
    self.frame = frame;
}

- (CGFloat)keyboard_y
{
    return self.frame.origin.y;
}

- (void)setKeyboard_w:(CGFloat)keyboard_w
{
    CGRect frame = self.frame;
    frame.size.width = keyboard_w;
    self.frame = frame;
}

- (CGFloat)keyboard_w
{
    return self.frame.size.width;
}

- (void)setKeyboard_h:(CGFloat)keyboard_h
{
    CGRect frame = self.frame;
    frame.size.height = keyboard_h;
    self.frame = frame;
}

- (CGFloat)keyboard_h
{
    return self.frame.size.height;
}

- (void)setKeyboard_size:(CGSize)keyboard_size
{
    CGRect frame = self.frame;
    frame.size = keyboard_size;
    self.frame = frame;
}

- (CGSize)keyboard_size
{
    return self.frame.size;
}

- (void)setKeyboard_origin:(CGPoint)keyboard_origin
{
    CGRect frame = self.frame;
    frame.origin = keyboard_origin;
    self.frame = frame;
}

- (CGPoint)keyboard_origin
{
    return self.frame.origin;
}
@end
