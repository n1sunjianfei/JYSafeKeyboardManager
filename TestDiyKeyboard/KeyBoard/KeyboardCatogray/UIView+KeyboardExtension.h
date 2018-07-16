// 代码地址: https://github.com/CoderkeyboardLee/keyboardRefresh
// 代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIView+Extension.h
//  keyboardRefreshExample
//
//  Created by keyboard Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KeyboardExtension)
@property (assign, nonatomic) CGFloat keyboard_x;
@property (assign, nonatomic) CGFloat keyboard_y;
@property (assign, nonatomic) CGFloat keyboard_w;
@property (assign, nonatomic) CGFloat keyboard_h;
@property (assign, nonatomic) CGSize keyboard_size;
@property (assign, nonatomic) CGPoint keyboard_origin;
@end
