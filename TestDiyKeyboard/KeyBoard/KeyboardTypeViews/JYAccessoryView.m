//
//  JYAccessoryView.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYAccessoryView.h"
#import "JYSafeKeyboardConfigure.h"
#import "UIButton+SafeKeyboard.h"
@implementation JYAccessoryView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setupUI];
}
- (void)setupUI{

    UIView *toolbar = [[UIView alloc]initWithFrame:self.bounds];
    toolbar.backgroundColor = [JYSafeKeyboardConfigure defaultManager].inputAccessViewBgColor;

    UIButton *button = [UIButton createButton:CGRectMake(0, 0, 50, CGRectGetHeight(toolbar.bounds)) title:@"完成" tag:0 image:nil];
    [button addTarget:self action:@selector(clickFinished:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:toolbar.backgroundColor];
    [button setTitleColor:[JYSafeKeyboardConfigure defaultManager].inputAccessViewTextColor forState:UIControlStateNormal];
    [toolbar addSubview:button];
    [self addSubview:toolbar];
}
- (void)clickFinished:(id)sender{
    if ([self.delegate respondsToSelector:@selector(accessoryView_clickFinish:)]) {
        [self.delegate accessoryView_clickFinish:sender];
    } else {
        //NSLog(@"JYAccessoryView 代理未实行");
    }
}

@end
