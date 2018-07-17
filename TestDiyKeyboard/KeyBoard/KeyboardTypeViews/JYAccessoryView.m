//
//  JYAccessoryView.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYAccessoryView.h"
#import "JYSafeKeyboardConfigure.h"
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
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:self.bounds];
//    toolbar.backgroundColor = [JYSafeKeyboardConfigure defaultManager].inputAccessViewBgColor;
    toolbar.barTintColor = [JYSafeKeyboardConfigure defaultManager].inputAccessViewBgColor;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickFinished:)];
    [item setTintColor:[JYSafeKeyboardConfigure defaultManager].inputAccessViewTextColor];
    toolbar.items = @[item];
    [self addSubview:toolbar];
}
- (void)clickFinished:(id)sender{
    if ([self.delegate respondsToSelector:@selector(accessoryView_clickFinish:)]) {
        [self.delegate accessoryView_clickFinish:sender];
    } else {
        NSLog(@"JYAccessoryView 代理未实行");
    }
}

@end
