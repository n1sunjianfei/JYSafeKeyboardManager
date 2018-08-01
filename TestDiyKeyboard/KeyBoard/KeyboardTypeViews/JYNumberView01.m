//
//  JYAccessoryView.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYNumberView01.h"
#import "UIButton+SafeKeyboard.h"
#import "JYSafeKeyboardConfigure.h"
#import "UIView+KeyboardExtension.h"
@implementation JYNumberView01
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
    int columns = 4;
    CGFloat itemWidth = (width - margin*(columns -1))/columns;
    CGFloat itemHeight = (height - margin*(lines -1))/lines;
    
    //11个输入按钮
    for (int i = 0;i<12; i++) {
        int column = i % 3;
        int line = i/3;
        CGRect frame = CGRectMake(column*(margin+itemWidth), line*(margin+itemHeight), itemWidth, itemHeight);
        
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
        
        UIButton *button = [UIButton createButton:frame title:title tag:i image:nil];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[JYSafeKeyboardConfigure defaultManager].inputItemBackgroundColor];
        [numberView addSubview:button];
    }
    //右侧四个功能按钮
    for (int i =0 ; i<4; i++) {
        int column = 3;
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
            case 2:{//删除
                NSString *imageName = [NSString stringWithFormat:@"SafeKeyBoard.bundle/%@",@"delete.png"];
                NSBundle *bundle = [NSBundle bundleForClass:[self class]];
                image = [UIImage imageNamed:imageName
                                 inBundle:bundle compatibleWithTraitCollection:nil];
                
                       }
                break;
            case 3://确定
                title = @"下一项";
                break;
            default:
                break;
        }
        
        UIButton *button = [UIButton createButton:frame title:title tag:i+12 image:image];
         [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
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
            if ([self.delegate respondsToSelector:@selector(numberView01_clickInputItem:)]) {
                [self.delegate numberView01_clickInputItem:sender];
            } else {
                //NSLog(@"JYAccessoryView 代理未实行");
            }
        }
            break;
        case 12:{//隐藏键盘
            if ([self.delegate respondsToSelector:@selector(numberView01_clickFinish:)]) {
                [self.delegate numberView01_clickFinish:sender];
            } else {
                //NSLog(@"JYAccessoryView 代理未实行");
            }
        }
            break;
        case 13:{//清空
            if ([self.delegate respondsToSelector:@selector(numberView01_clickClear:)]) {
                [self.delegate numberView01_clickClear:sender];
            }
        }
            break;
        case 14:{//删除
            if ([self.delegate respondsToSelector:@selector(numberView01_clickDelete:)]) {
                [self.delegate numberView01_clickDelete:sender];
            }
        }
            break;
        case 15:{//确定
            if ([self.delegate respondsToSelector:@selector(numberView01_clickFinish:)]) {
                [self.delegate numberView01_clickFinish:sender];
            } else {
                //NSLog(@"JYAccessoryView 代理未实行");
            }
        }
            break;
        default:
            break;
    }

}
@end
