//
//  JYAccessoryView.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYNumberView.h"
#import "UIButton+SafeKeyboard.h"
#import "JYKeyboardConstant.h"
#import "UIView+KeyboardExtension.h"
@implementation JYNumberView
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
    numberView.backgroundColor = Keyboard_BackgroundColor;
    [self addSubview:numberView];
    CGFloat margin = 1;
    int lines = 4;
    int columns = 3;
    CGFloat itemWidth = (width - margin*(columns -1))/columns;
    CGFloat itemHeight = (height - margin*(lines -1))/lines;
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (int i = 0;i<12; i++) {
        int column = i % 3;
        int line = i/3;
        CGRect frame = CGRectMake(column*(margin+itemWidth), line*(margin+itemHeight), itemWidth, itemHeight);
        int titleInt = 0;
        
        switch (i) {
            case 9:{
                UIButton *button = [UIButton createButton:frame title:@"ABC" tag:i image:nil selector:@selector(click:)];
                button.backgroundColor = Keyboard_FunctionItem_BackgroundColor;
                [numberView addSubview:button];
            }
                break;
            case 11:{
                UIButton *button = [UIButton createButton:frame title:@"" tag:i image:[UIImage imageNamed:@"delete.png"] selector:@selector(click:)];
                CGFloat imageHeight = button.keyboard_h*2/3;
                
                [button setImageEdgeInsets:UIEdgeInsetsMake((button.keyboard_h-imageHeight)/2, (button.keyboard_w-imageHeight)/2, (button.keyboard_h-imageHeight)/2, (button.keyboard_w-imageHeight)/2)];
                [button setBackgroundColor:Keyboard_FunctionItem_BackgroundColor];
                //清楚按钮
                [numberView addSubview:button];
            }
                break;
            default:{
                //不重复的产生随机数
                do {
                    titleInt = arc4random() % 10;
                } while ([tmpArray containsObject:[NSNumber numberWithInt:titleInt]]);
                [tmpArray addObject:[NSNumber numberWithInt:titleInt]];
                UIButton *button = [UIButton createButton:frame title:[NSString stringWithFormat:@"%d",titleInt] tag:i image:nil selector:@selector(click:)];
                [button setBackgroundColor:Keyboard_InputItem_BackgroundColor];
                [numberView addSubview:button];
            }
                break;
        }
    }
    tmpArray = nil;
    
    
}
- (void)click:(UIButton*)sender{

    
    if (sender.tag == 9){//输入法切换
        if ([self.delegate respondsToSelector:@selector(numberView_clickChangeInputWay:)]) {
            [self.delegate numberView_clickChangeInputWay:sender];
        }
    }else if(sender.tag == 11){//删除
        if ([self.delegate respondsToSelector:@selector(numberView_clickDelete:)]) {
            [self.delegate numberView_clickDelete:sender];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(numberView_clickInputItem:)]) {
            [self.delegate numberView_clickInputItem:sender];
        } else {
            NSLog(@"JYAccessoryView 代理未实行");
        }
    }
}
@end
