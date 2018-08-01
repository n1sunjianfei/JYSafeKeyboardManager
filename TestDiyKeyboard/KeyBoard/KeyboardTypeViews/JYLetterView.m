//
//  JYAccessoryView.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYLetterView.h"
#import "UIButton+SafeKeyboard.h"
#import "JYSafeKeyboardConfigure.h"
#import "UIView+KeyboardExtension.h"
@interface JYLetterView()
@property(nonatomic,copy) NSString *lowercaseString;
@property(nonatomic,copy) NSArray *lowercaseLetters;
@property(nonatomic,copy) NSArray *uppercaseLetters;
@property(nonatomic,assign) BOOL isLower;

@end

@implementation JYLetterView
#pragma mark - 懒加载，数据
- (NSString*)lowercaseString{
    if (!_lowercaseString) {
        _lowercaseString = @"qwertyuiopasdfghjklzxcvbnm";
    }
    return _lowercaseString;
}

- (NSArray*)lowercaseLetters{
    if (!_lowercaseLetters) {
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:0];
        [self.lowercaseString enumerateSubstringsInRange:NSMakeRange(0, self.lowercaseString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            
            [tmpArr addObject:substring];
        }];
        _lowercaseLetters = [tmpArr copy];
    }
    return _lowercaseLetters;
}
- (NSArray*)uppercaseLetters{
    if (!_uppercaseLetters) {
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:0];
        [self.lowercaseString enumerateSubstringsInRange:NSMakeRange(0, self.lowercaseString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            
            [tmpArr addObject:[substring uppercaseString]];
        }];
        _uppercaseLetters = [tmpArr copy];
    }
    return _uppercaseLetters;
}
#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isLower = YES;
        [self setupUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setupUI];
}
#pragma mark - 小写
- (void)lowerLetters{
    self.isLower = YES;
    [self layoutSubviews];
}

#pragma mark - 绘制按钮
- (void)setupUI{
    
    NSArray *dataSource = [self.lowercaseLetters copy];
    
    if (!self.isLower) {
        dataSource = [self.uppercaseLetters copy];
    }
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    UIView *numberView = [[UIView alloc]initWithFrame:self.bounds];
    numberView.backgroundColor = [JYSafeKeyboardConfigure defaultManager].keyboardBackgroundColor;
    [self addSubview:numberView];
    CGFloat midMargin = 5;
    CGFloat minMaigin = 2;//第一行的左右边界。
    CGFloat letterItemWidth = (width - 2*minMaigin - 9*midMargin)/10;
    CGFloat itemHeight = (height - midMargin*5)/4;
    CGFloat leftMargin02 = (width - 9*letterItemWidth - 8 *midMargin)/2;//第2行的左右边界。
    CGFloat leftMargin03 = (width - 7*letterItemWidth - 6 *midMargin)/2;//第3行的左右边界。

    CGFloat functionItemWidth = (leftMargin03 + letterItemWidth - minMaigin - midMargin)/2;

    for (int i = 0;i<dataSource.count+5; i++) {
        CGRect frame ;
        UIColor *btnColor = nil;
        NSString *title = @"";
        UIImage *image = nil;
        switch (i>9?((i>18)?(i>25?(i):2):1):0) {
            case 0:{//0~9 第一行字母
                CGFloat leftMargin = minMaigin;
                frame = CGRectMake(leftMargin + i*(midMargin+letterItemWidth), midMargin, letterItemWidth, itemHeight);
            }
                break;
            case 1:{//10~18 第二行字母
                CGFloat leftMargin = leftMargin02;
                frame = CGRectMake(leftMargin + (i-10)*(midMargin+letterItemWidth), midMargin*2+itemHeight, letterItemWidth, itemHeight);
            }
                break;
            case 2:{//19~25 第三行字母
                CGFloat leftMargin = leftMargin03;
                frame = CGRectMake(leftMargin + (i-19)*(midMargin+letterItemWidth), midMargin*3+itemHeight*2, letterItemWidth, itemHeight);
            }
                break;
            case 26:{//第三行大小写锁定按钮
                CGFloat leftMargin = minMaigin;
                frame = CGRectMake(leftMargin, midMargin*3+itemHeight*2, functionItemWidth, itemHeight);
                btnColor = [JYSafeKeyboardConfigure defaultManager].functionItemBackgroundColor;
                if(self.isLower){
                    NSString *imageName = [NSString stringWithFormat:@"SafeKeyBoard.bundle/%@",@"up1.png"];
                    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
                    image = [UIImage imageNamed:imageName
                                       inBundle:bundle compatibleWithTraitCollection:nil];
//                    image = [UIImage imageNamed:@"up1.png"];
                }else{
                    NSString *imageName = [NSString stringWithFormat:@"SafeKeyBoard.bundle/%@",@"up2.png"];
                    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
                    image = [UIImage imageNamed:imageName
                                       inBundle:bundle compatibleWithTraitCollection:nil];
//                    image = [UIImage imageNamed:@"up2.png"];
                    
                }
            }
                break;
            case 27:{//第三行删除按钮
                CGFloat leftMargin = minMaigin;
                frame = CGRectMake(width - leftMargin - functionItemWidth, midMargin*3+itemHeight*2, functionItemWidth, itemHeight);
                btnColor = [JYSafeKeyboardConfigure defaultManager].functionItemBackgroundColor;
//                image = [UIImage imageNamed:@"delete.png"];
                NSString *imageName = [NSString stringWithFormat:@"SafeKeyBoard.bundle/%@",@"delete.png"];
                NSBundle *bundle = [NSBundle bundleForClass:[self class]];
                image = [UIImage imageNamed:imageName
                                   inBundle:bundle compatibleWithTraitCollection:nil];
            }
                break;
            case 28:{//第四行切换输入法按钮
                CGFloat leftMargin = minMaigin;
                frame = CGRectMake(leftMargin, midMargin*4+itemHeight*3, leftMargin03-minMaigin - midMargin, itemHeight);
                btnColor = [JYSafeKeyboardConfigure defaultManager].functionItemBackgroundColor;
                title = @"123";
            }
                break;
            case 29:{//第四行空格按钮
                CGFloat leftMargin = leftMargin03;
                frame = CGRectMake(leftMargin, midMargin*4+itemHeight*3,6*(letterItemWidth+midMargin)+letterItemWidth, itemHeight);
                btnColor = [JYSafeKeyboardConfigure defaultManager].inputItemBackgroundColor;
                //            image = [UIImage imageNamed:@"space.png"];
                title = @"久雅安全键盘";
            }
                break;
            case 30:{//第四行完成按钮
                CGFloat leftMargin = width - (leftMargin03-minMaigin - midMargin) - minMaigin;
                frame = CGRectMake(leftMargin, midMargin*4+itemHeight*3, leftMargin03-minMaigin - midMargin, itemHeight);
                btnColor = [JYSafeKeyboardConfigure defaultManager].functionItemBackgroundColor;
                title = @"完成";
            }
                break;
            default:
                frame = CGRectZero;
                break;
        }

        if(i<26){
            title = dataSource[i];
            btnColor = [JYSafeKeyboardConfigure defaultManager].inputItemBackgroundColor;
        }
        
        UIButton *button = [UIButton createButton:frame title:title tag:i image:image];
         [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        if (btnColor) {
            [button setBackgroundColor:btnColor];
        }
        if (image) {
            CGFloat imageHeight = button.keyboard_h*2/3;
            
            [button setImageEdgeInsets:UIEdgeInsetsMake((button.keyboard_h-imageHeight)/2, (button.keyboard_w-imageHeight)/2, (button.keyboard_h-imageHeight)/2, (button.keyboard_w-imageHeight)/2)];
        }
        if (i==29) {
            [button setTitleColor:[JYSafeKeyboardConfigure defaultManager].whiteSpaceTextColor forState:UIControlStateNormal];
        }
        button.layer.cornerRadius = 10;
        [numberView addSubview:button];

    }
}

#pragma mark - 按钮点击事件

- (void)click:(UIButton*)sender{

    NSInteger tag = sender.tag;
    switch (tag>25?(tag):0) {
        case 0:{//0~25
            if ([self.delegate respondsToSelector:@selector(leterView_clickInputItem:)]) {
                [self.delegate leterView_clickInputItem:sender];
            }
        }
            break;
        case 26:{//大小写切换
            self.isLower = !self.isLower;
            [self layoutSubviews];
            
        }
            break;
        case 27:{//删除
            if ([self.delegate respondsToSelector:@selector(leterView_clickDelete:)]) {
                [self.delegate leterView_clickDelete:sender];
            }
            
        }
            break;
        case 28:{//切换输入方式
            if ([self.delegate respondsToSelector:@selector(leterView_clickChangeInputWay:)]) {
                [self.delegate leterView_clickChangeInputWay:sender];
            }
            
        }
            break;
        case 29:{//空格
            
        }
            break;
        case 30:{//完成输入
            if ([self.delegate respondsToSelector:@selector(leterView_clickFinish:)]) {
                [self.delegate leterView_clickFinish:sender];
            }
            
        }
            break;
        
        default:
            //NSLog(@"字母键盘点击了其他按钮");

            break;
            
    }
}
@end
