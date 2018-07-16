//
//  JYSafeKeyboard.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYSafeKeyboard.h"
#import <UIKit/UIKit.h>
#import "UITextView+SafeKeyboard.h"
#import "UITextField+SafeKeyboard.h"
#import "JYAccessoryView.h"
#import "JYNumberView.h"
#import "JYLetterView.h"
#import "UIButton+SafeKeyboard.h"
#import "UIView+KeyboardExtension.h"

static JYSafeKeyboard *globalKeyBoard;

@interface JYSafeKeyboard()<JYAccessoryViewDelegate,JYNumberViewDelegate,JYLetterViewDelegate,UITextViewDelegate>

@property(nonatomic,strong) JYAccessoryView *inputAccessoryView;//顶部视图
@property(nonatomic,strong) UIView *keyBoardView;//键盘容器
@property(nonatomic,strong) JYLetterView *letterView;//字母键盘
@property(nonatomic,strong) JYNumberView *numberView;//数字键盘
@property(nonatomic,assign) BOOL isNewResponder;//朝向改变，前后台切换引起的键盘弹出

//@property(nonatomic,copy) NSArray *numberView;//数字键盘

@end

@implementation JYSafeKeyboard
#pragma mark - 开启方法


+ (void)useJYSafeKeyboard:(id)inputField type:(SafeKeyboardType)keyboardType{
    if ([inputField isKindOfClass:[UITextField class]]) {
        UITextField *realInputField = (UITextField*)inputField;
        realInputField.isUseSafeKeyboard = @1;
        realInputField.keyboardType = [NSNumber numberWithInteger:keyboardType];
        realInputField.inputAccessoryView = [JYSafeKeyboard sharedKeyBoard].inputAccessoryView ;
        realInputField.inputView = [JYSafeKeyboard sharedKeyBoard].keyBoardView;
        [realInputField addTarget:[JYSafeKeyboard sharedKeyBoard] action:@selector(begin:) forControlEvents:UIControlEventEditingDidBegin];
        
    }else if([inputField isKindOfClass:[UITextView class]]){
        UITextView *realInputField = (UITextView*)inputField;
        realInputField.isUseSafeKeyboard = @1;
        realInputField.keyboardType = [NSNumber numberWithInteger:keyboardType];
        realInputField.inputAccessoryView = [JYSafeKeyboard sharedKeyBoard].inputAccessoryView;
        realInputField.inputView = [JYSafeKeyboard sharedKeyBoard].keyBoardView;
        [realInputField addNotification];
        
    }else{
        return;
    }
}
#pragma mark - 键盘管理单例
+ (instancetype)sharedKeyBoard{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalKeyBoard = [[self alloc] init];
        // 监听键盘
        [[NSNotificationCenter defaultCenter] addObserver:globalKeyBoard selector:@selector(keyboardWillShowAction:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:globalKeyBoard selector:@selector(keyboardWillHideAction:) name:UIKeyboardWillHideNotification object:nil];
        [globalKeyBoard addConstraint];
    });
    
    return globalKeyBoard;
}
- (void)addConstraint{
    [self.numberView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.letterView setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSDictionary *views = NSDictionaryOfVariableBindings(_numberView,_letterView);
    //view1距离superview两端距离都为0
    [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_numberView]|" options:0 metrics:nil views:views]];
    //view1高度为40，距离底端距离为0
    [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_numberView(==200)]" options:0 metrics:nil views:views]];
    
    //view1距离superview两端距离都为0
    [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_letterView]|" options:0 metrics:nil views:views]];
    //view1高度为40，距离底端距离为0
    [self.keyBoardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_letterView(==200)]" options:0 metrics:nil views:views]];
}

- (void)begin:(UITextField*)field{
    self.isNewResponder = YES;
}
#pragma mark - 键盘即将显示
- (void)keyboardWillShowAction:(NSNotification*)notify{
    //首先通过这两行代码获取第一相应
    UIView * firstResponder = [self getCurrentFirstResponder];
    //然后再通过判断响应类做出相应的响应
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        UITextField *realInputField = (UITextField*)firstResponder;
        
        if ([realInputField.isUseSafeKeyboard boolValue]) {
            if (self.isNewResponder) {
                [[JYSafeKeyboard sharedKeyBoard] loadKeyboardView:[[JYSafeKeyboard sharedKeyBoard] changeToKeyboardType:realInputField.keyboardType]];
                self.isNewResponder = NO;

            }
            
        }else{
            NSLog(@"未开启安全键盘");
        }
        NSLog(@"UITextField");
    } else if ([firstResponder isKindOfClass:[UITextView class]]) {
        UITextView *realInputField = (UITextView*)firstResponder;
        if ([realInputField.isUseSafeKeyboard boolValue]) {
            if (![realInputField.isBeginEditing boolValue]) {
                [[JYSafeKeyboard sharedKeyBoard] loadKeyboardView:[[JYSafeKeyboard sharedKeyBoard] changeToKeyboardType:realInputField.keyboardType]];
            }
        }else{
            NSLog(@"未开启安全键盘");
        }
        NSLog(@"UITextView");
    }else{
        NSLog(@"非 UITextField 或 UITextView 类型调起键盘");

    }
}
- (void)keyboardWillChangeAction:(NSNotification*)notify{

}


#pragma mark - NSNumber 类型转 SafeKeyboardType

- (SafeKeyboardType)changeToKeyboardType:(NSNumber*)typeNumber{
    switch ([typeNumber integerValue]) {
        case 0:
            return SafeKeyboard_Type_Default;
            break;
        case 1:
            return SafeKeyboard_Type_Number;
            break;
        default:
            return SafeKeyboard_Type_Default;

            break;
    }
    return SafeKeyboard_Type_Default;
}
//键盘即将隐藏
- (void)keyboardWillHideAction:(NSNotification*)notify{
    
}

#pragma mark - 键盘相关 view 懒加载

- (JYAccessoryView*)inputAccessoryView{
    if (!_inputAccessoryView) {
        //
        _inputAccessoryView = [[JYAccessoryView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40)];
       
        _inputAccessoryView.delegate = self;

    }
    return _inputAccessoryView;
}

- (UIView*)keyBoardView{
    if (!_keyBoardView) {
        _keyBoardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 200)];
        [_keyBoardView addSubview:self.letterView];
        [_keyBoardView addSubview:self.numberView];

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


#pragma mark - 键盘相关方法

//结束输入
- (void)endEditing{
    [[self getCurrentFirstResponder] endEditing:YES];
    
}
//切换键盘类型
- (void)loadKeyboardView:(SafeKeyboardType)keyBoardType{
    //重新加载的时候需要将字符小写
    [self.letterView lowerLetters];
    switch (keyBoardType) {
        case SafeKeyboard_Type_Default:
            self.letterView.hidden = NO;
            self.numberView.hidden = YES;
            break;
        case SafeKeyboard_Type_Number:
            self.letterView.hidden = YES;
            self.numberView.hidden = NO;
            break;
        default:
            self.letterView.hidden = NO;
            self.numberView.hidden = YES;
            break;
    }
}
//删除操作
- (void)deletCharacter{
    UIView * firstResponder = [self getCurrentFirstResponder];
    //然后再通过判断响应类做出相应的响应
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        UITextField *realInputField = (UITextField*)firstResponder;
        
        NSRange range = [realInputField keyboard_SelectedRange];
        if (range.length==0&&range.location>0) {
            range = NSMakeRange(range.location-1, 1);
        }
        
        realInputField.text = [realInputField.text?:@"" stringByReplacingCharactersInRange:range withString:@""];
        [realInputField keyboard_SetSelectedRange:NSMakeRange(range.location, 0)];
        
        
        NSLog(@"UITextField");
    } else if ([firstResponder isKindOfClass:[UITextView class]]) {
        UITextView *realInputField = (UITextView*)firstResponder;
        
        NSRange range = [realInputField keyboard_SelectedRange];
        if (range.length==0&&range.location>0) {
            range = NSMakeRange(range.location-1, 1);
        }
        realInputField.text = [realInputField.text?:@"" stringByReplacingCharactersInRange:range withString:@""];
        
        [realInputField keyboard_SetSelectedRange:NSMakeRange(range.location, 0)];
        
    }
}
//点击了输入按钮
- (void)clickInputItem:(UIButton*)sender{

        UIView * firstResponder = [self getCurrentFirstResponder];
        //然后再通过判断响应类做出相应的响应
        if ([firstResponder isKindOfClass:[UITextField class]]) {
            UITextField *realInputField = (UITextField*)firstResponder;
            
            NSRange range = [realInputField keyboard_SelectedRange];
            realInputField.text = [realInputField.text?:@"" stringByReplacingCharactersInRange:range withString:sender.titleLabel.text];
            [realInputField keyboard_SetSelectedRange:NSMakeRange(range.location+sender.titleLabel.text.length, 0)];
            
            NSLog(@"UITextField");
        } else if ([firstResponder isKindOfClass:[UITextView class]]) {
            UITextView *realInputField = (UITextView*)firstResponder;
            
            NSRange range = [realInputField keyboard_SelectedRange];
            realInputField.text = [realInputField.text?:@"" stringByReplacingCharactersInRange:range withString:sender.titleLabel.text];
            
            [realInputField keyboard_SetSelectedRange:NSMakeRange(range.location+sender.titleLabel.text.length, 0)];
        }
}
//获取当前响应输入框
- (UIView*)getCurrentFirstResponder{
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView * firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    return firstResponder;
}
#pragma mark - JYLetterView 代理方法
//点击输入类型的按钮
- (void)leterView_clickInputItem:(UIButton *)sender{
    [self clickInputItem:sender];
}
//点击删除按钮
- (void)leterView_clickDelete:(UIButton *)sender{
    [self deletCharacter];
}
- (void)leterView_clickFinish:(UIButton *)sender{
    [self endEditing];
}
- (void)leterView_clickChangeInputWay:(UIButton *)sender{
    [self loadKeyboardView:SafeKeyboard_Type_Number];
}

#pragma mark - JYAccessoryView 代理

- (void)accessoryView_clickFinish:(id)sender{
    [self endEditing];
}


#pragma mark - JYNumberView 代理
- (void)numberView_clickChangeInputWay:(UIButton *)sender {
    [self loadKeyboardView:SafeKeyboard_Type_Default];
}

- (void)numberView_clickDelete:(UIButton *)sender {
    [self deletCharacter];
}

- (void)numberView_clickFinish:(UIButton *)sender {
    [self endEditing];
}

- (void)numberView_clickInputItem:(UIButton *)sender {
    [self clickInputItem:sender];
}

@end
