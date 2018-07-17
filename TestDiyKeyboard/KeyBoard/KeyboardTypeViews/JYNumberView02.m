//
//  JYAccessoryView.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYNumberView02.h"
#import "UIButton+SafeKeyboard.h"
#import "JYSafeKeyboardConfigure.h"
#import "UIView+KeyboardExtension.h"
@implementation JYNumberView02
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
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    UIView *numberView = [[UIView alloc]initWithFrame:self.bounds];
    numberView.backgroundColor = [JYSafeKeyboardConfigure defaultManager].keyboardBackgroundColor;
    [self addSubview:numberView];
    CGFloat margin = 1;
    int lines = 4;
    int columns = 5;
    CGFloat itemWidth = (width - margin*(columns -1))/columns;
    CGFloat itemHeight = (height - margin*(lines -1))/lines;
    
    //11个输入按钮,tag:0~11
    for (int i = 0;i<12; i++) {
        int column = i % 3;
        int line = i/3;
        CGRect frame = CGRectMake((column+1)*(margin+itemWidth), line*(margin+itemHeight), itemWidth, itemHeight);
        
        NSString *title = @"";
        switch (i>8?(i):(0)) {
            case 0:{
                title = [NSString stringWithFormat:@"%d",i+1];
                
            }
                break;
            case 9:{// '.'
                title = @".";
            }
                break;
            case 10:{// '0'
                title = @"0";
            }
                break;
            case 11:{// 待填充
                
            }
                break;
            default:{

            }
                break;
        }
        
        UIButton *button = [UIButton createButton:frame title:title tag:i image:nil selector:@selector(click:)];
        [button setBackgroundColor:[JYSafeKeyboardConfigure defaultManager].inputItemBackgroundColor];
        [numberView addSubview:button];
    }

    
    //左侧四个“仓”按钮，tag:12~15
    for (int i =0 ; i<4; i++) {
        int column = 0;
        int line = i/1;
        CGRect frame = CGRectMake(column*(margin+itemWidth), line*(margin+itemHeight), itemWidth, itemHeight);
        NSString *title = @"";
        UIImage *image = nil;
        switch (i) {
            case 0://全仓
                image = [UIImage imageNamed:@""];
                title = @"全仓";
                break;
            case 1://半仓
                title = @"半仓";
                break;
            case 2://1/3仓
                title = @"1/3仓";
                break;
            case 3://1/4仓
                title = @"1/4仓";
                break;
            default:
                break;
        }
        
        UIButton *button = [UIButton createButton:frame title:title tag:i+12 image:image selector:@selector(click:)];
        [button setBackgroundColor:[JYSafeKeyboardConfigure defaultManager].inputItemBackgroundColor];
        if (i==2) {
            CGFloat imageHeight = button.keyboard_h*2/3;
            
            [button setImageEdgeInsets:UIEdgeInsetsMake((button.keyboard_h-imageHeight)/2, (button.keyboard_w-imageHeight)/2, (button.keyboard_h-imageHeight)/2, (button.keyboard_w-imageHeight)/2)];
        }
//        if (i==3) {
//            [button setBackgroundColor:Keyboard_Color(59, 135, 238, 1.0)];
//        }
        [numberView addSubview:button];
    }
    //右侧四个功能按钮 tag:16~19
    for (int i =0 ; i<4; i++) {
        int column = 4;
        int line = i/1;
        CGRect frame = CGRectMake(column*(margin+itemWidth), line*(margin+itemHeight), itemWidth, itemHeight);
        NSString *title = @"";
        UIImage *image = nil;
        switch (i) {
            case 0://隐藏键盘
                image = [UIImage imageNamed:@""];
                title = @"隐藏";
                break;
            case 1://清空
                title = @"清空";
                break;
            case 2://删除
                image = [UIImage imageNamed:@"delete.png"];
                
                break;
            case 3://确定
                title = @"确定";
                break;
            default:
                break;
        }
        
        UIButton *button = [UIButton createButton:frame title:title tag:i+16 image:image selector:@selector(click:)];
        [button setBackgroundColor:[JYSafeKeyboardConfigure defaultManager].inputItemBackgroundColor];
        if (i==2) {
            CGFloat imageHeight = button.keyboard_h*2/3;
            
            [button setImageEdgeInsets:UIEdgeInsetsMake((button.keyboard_h-imageHeight)/2, (button.keyboard_w-imageHeight)/2, (button.keyboard_h-imageHeight)/2, (button.keyboard_w-imageHeight)/2)];
        }
        if (i==3) {
            [button setBackgroundColor:Keyboard_Color(59, 135, 238, 1.0)];
        }
        [numberView addSubview:button];
    }
}
- (void)click:(UIButton*)sender{

    NSInteger tag = sender.tag;
    switch (tag>10?(tag):(0)) {
        case 0:{//"0~9"&&" . "
            if ([self.delegate respondsToSelector:@selector(numberView02_clickInputItem:)]) {
                [self.delegate numberView02_clickInputItem:sender];
            } else {
                NSLog(@"JYAccessoryView 代理未实行");
            }
        }
            break;
        case 12:{//全仓
            if ([self.delegate respondsToSelector:@selector(numberView02_clickStore:)]) {
                [self.delegate numberView02_clickStore:1];
            } else {
                NSLog(@"JYAccessoryView 代理未实行");
            }
        }
            break;
        case 13:{//半仓
            if ([self.delegate respondsToSelector:@selector(numberView02_clickStore:)]) {
                [self.delegate numberView02_clickStore:1.0/2];
            } else {
                NSLog(@"JYAccessoryView 代理未实行");
            }
           
        }
            break;
        case 14:{// 1/3仓
            if ([self.delegate respondsToSelector:@selector(numberView02_clickStore:)]) {
                [self.delegate numberView02_clickStore:1.0/3];
            } else {
                NSLog(@"JYAccessoryView 代理未实行");
            }
        }
            break;
        case 15:{// 1/4仓
            if ([self.delegate respondsToSelector:@selector(numberView02_clickStore:)]) {
                [self.delegate numberView02_clickStore:1.0/4];
            } else {
                NSLog(@"JYAccessoryView 代理未实行");
            }
        }
            break;
        case 16:{//隐藏键盘
            if ([self.delegate respondsToSelector:@selector(numberView02_clickFinish:)]) {
                [self.delegate numberView02_clickFinish:sender];
            } else {
                NSLog(@"JYAccessoryView 代理未实行");
            }
        }
            break;
        case 17:{//清空
            if ([self.delegate respondsToSelector:@selector(numberView02_clickClear:)]) {
                [self.delegate numberView02_clickClear:sender];
            }
        }
            break;
        case 18:{//删除
            if ([self.delegate respondsToSelector:@selector(numberView02_clickDelete:)]) {
                [self.delegate numberView02_clickDelete:sender];
            }
        }
            break;
        case 19:{//确定
            if ([self.delegate respondsToSelector:@selector(numberView02_clickFinish:)]) {
                [self.delegate numberView02_clickFinish:sender];
            } else {
                NSLog(@"JYAccessoryView 代理未实行");
            }
        }
            break;
        default:
            break;
    }

}
@end
