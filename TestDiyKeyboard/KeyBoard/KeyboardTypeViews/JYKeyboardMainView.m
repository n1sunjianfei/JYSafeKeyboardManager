//
//  JYKeyboardMainView.m
//  StockSDK
//
//  Created by ever-mac on 2018/7/31.
//  Copyright © 2018年 ever. All rights reserved.
//

#import "JYKeyboardMainView.h"
#import <UIKit/UIKit.h>
#import "JYNumberView.h"
#import "JYLetterView.h"
#import "JYNumberView01.h"
#import "JYNumberView02.h"
#import "JYSafeKeyboardConfigure.h"

@interface JYKeyboardMainView()<JYNumberViewDelegate,JYLetterViewDelegate,JYNumberView01Delegate,JYNumberView02Delegate>

@property(nonatomic,strong) UIView *keyBoardView;//键盘容器
@property(nonatomic,strong) JYLetterView *letterView;//字母键盘
@property(nonatomic,strong) JYNumberView *numberView;//数字键盘
@property(nonatomic,strong) JYNumberView01 *numberView01;//数字键盘01
@property(nonatomic,strong) JYNumberView02 *numberView02;//数字键盘01

@end
@implementation JYKeyboardMainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.keyBoardView];
        [self loadKeyboardView:SafeKeyboard_Type_Default];
    }
    return self;
}
#pragma mark - 键盘相关 view 懒加载

- (void)layoutSubviews{
    [super layoutSubviews];
    self.keyBoardView.frame = self.bounds;
}
- (UIView*)keyBoardView{
    if (!_keyBoardView) {
        _keyBoardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 210)];
        _keyBoardView.backgroundColor = [UIColor redColor];
    }
    return _keyBoardView;
}

- (JYLetterView*)letterView{
    if (!_letterView) {
        _letterView = [[JYLetterView alloc]init];
        _letterView.delegate = self;
    }
    return _letterView;
}

- (JYNumberView*)numberView{
    if (!_numberView) {
        _numberView = [[JYNumberView alloc]init];
        _numberView.delegate = self;
    }
    return _numberView;
}

- (JYNumberView01*)numberView01{
    if (!_numberView01) {
        _numberView01 = [[JYNumberView01 alloc]init];
        _numberView01.delegate = self;
    }
    return _numberView01;
}
- (JYNumberView02*)numberView02{
    if (!_numberView02) {
        _numberView02 = [[JYNumberView02 alloc]init];
        _numberView02.delegate = self;
    }
    return _numberView02;
}

#pragma mark - JYLetterView 代理方法
//点击输入类型的按钮
- (void)leterView_clickInputItem:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(clickInputItem:)]) {
        [self.delegate clickInputItem:sender];
    }
}
//点击删除按钮
- (void)leterView_clickDelete:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(deletCharacter)]) {
        [self.delegate deletCharacter];
    }
}
- (void)leterView_clickFinish:(UIButton *)sender{
    [self endEditing];
}
- (void)leterView_clickChangeInputWay:(UIButton *)sender{
    [self loadKeyboardView:SafeKeyboard_Type_Number];
}

//#pragma mark - JYAccessoryView 代理
//
//- (void)accessoryView_clickFinish:(id)sender{
////    [self endEditing];
//}


#pragma mark - JYNumberView 代理
- (void)numberView_clickChangeInputWay:(UIButton *)sender {
    [self loadKeyboardView:SafeKeyboard_Type_Default];
}

- (void)numberView_clickDelete:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deletCharacter)]) {
        [self.delegate deletCharacter];
    }
}

- (void)numberView_clickFinish:(UIButton *)sender {
    [self endEditing];
}

- (void)numberView_clickInputItem:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickInputItem:)]) {
        [self.delegate clickInputItem:sender];
    }
}
#pragma mark - JYNumberView01 代理
- (void)numberView01_clickChangeInputWay:(UIButton *)sender {
    [self loadKeyboardView:SafeKeyboard_Type_Default];
}

- (void)numberView01_clickDelete:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deletCharacter)]) {
        [self.delegate deletCharacter];
    }
}

- (void)numberView01_clickFinish:(UIButton *)sender {
    [self endEditing];
}

- (void)numberView01_clickInputItem:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickInputItem:)]) {
        [self.delegate clickInputItem:sender];
    }
}
- (void)numberView01_clickClear:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clearAllText)]) {
        [self.delegate clearAllText];
    }
}

#pragma mark - JYNumberView02 代理
- (void)numberView02_clickChangeInputWay:(UIButton *)sender {
    [self loadKeyboardView:SafeKeyboard_Type_Default];
}

- (void)numberView02_clickDelete:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deletCharacter)]) {
        [self.delegate deletCharacter];
    }
}

- (void)numberView02_clickFinish:(UIButton *)sender {
    [self endEditing];
}

- (void)numberView02_clickInputItem:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickInputItem:)]) {
        [self.delegate clickInputItem:sender];
    }
}
- (void)numberView02_clickClear:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clearAllText)]) {
        [self.delegate clearAllText];
    }
}
- (void)numberView02_clickStore:(float)storeValue{
    
    float store = [JYSafeKeyboardConfigure defaultManager].storeValue;
    if ([self.delegate respondsToSelector:@selector(changeTextFieldValue:)]) {
        [self.delegate changeTextFieldValue:[NSString stringWithFormat:@"%.2f",store*storeValue]];
    }
    
}


#pragma mark - desc
//切换键盘类型
- (void)loadKeyboardView:(SafeKeyboardType)keyBoardType{
    //重新加载的时候需要将字符小写
    [self.letterView lowerLetters];
    [self.keyBoardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (keyBoardType) {
        case SafeKeyboard_Type_Default:{
            [self.keyBoardView addSubview:self.letterView];
//            self.letterView.frame = CGRectMake(0 ,0 ,375,210);
                        [self.letterView setTranslatesAutoresizingMaskIntoConstraints:NO];
                        NSDictionary *views = NSDictionaryOfVariableBindings(_letterView,_keyBoardView);
                        [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_letterView]|" options:0 metrics:nil views:views]];
            
                        //view1高度为40，距离底端距离为0
                        [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_letterView(==_keyBoardView)]|" options:0 metrics:nil views:views]];
        }
            break;
        case SafeKeyboard_Type_Number:{
            
            [self.keyBoardView addSubview:self.numberView];
            [self.numberView setTranslatesAutoresizingMaskIntoConstraints:NO];
            NSDictionary *views = NSDictionaryOfVariableBindings(_numberView,_keyBoardView);
            //view1距离superview两端距离都为0
            [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_numberView]|" options:0 metrics:nil views:views]];
            //view1高度为40，距离底端距离为0
            
            [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_numberView(==_keyBoardView)]|" options:0 metrics:nil views:views]];
        }
            break;
        case SafeKeyboard_Type_Number01:{
            
            [self.keyBoardView addSubview:self.numberView01];
            [self.numberView01 setTranslatesAutoresizingMaskIntoConstraints:NO];
            NSDictionary *views = NSDictionaryOfVariableBindings(_numberView01,_keyBoardView);
            //view1距离superview两端距离都为0
            [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_numberView01]|" options:0 metrics:nil views:views]];
            //view1高度为40，距离底端距离为0
            [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_numberView01(==_keyBoardView)]|" options:0 metrics:nil views:views]];
            
        }
            break;
        case SafeKeyboard_Type_Number02:{
            
            [self.keyBoardView addSubview:self.numberView02];
            [self.numberView02 setTranslatesAutoresizingMaskIntoConstraints:NO];
            NSDictionary *views = NSDictionaryOfVariableBindings(_numberView02,_keyBoardView);
            //view1距离superview两端距离都为0
            [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_numberView02]|" options:0 metrics:nil views:views]];
            //view1高度为40，距离底端距离为0
            [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_numberView02(==_keyBoardView)]|" options:0 metrics:nil views:views]];
        }
            break;
        default:
            
            break;
    }
}
//结束输入
- (void)endEditing{
    if ([self.delegate respondsToSelector:@selector(endEditing)]) {
        [self.delegate endEditing];
    }
}
//获取当前响应输入框
+ (UIView*)getCurrentFirstResponder{
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView * firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    return firstResponder;
}
@end
