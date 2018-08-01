//
//  UIButton+SafeKeyboard.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SafeKeyboard)
#pragma mark - 创建按钮
+ (UIButton*)createButton:(CGRect)frame title:(NSString*)title tag:(NSInteger)tag image:(UIImage*)image;
@end
