//
//  JYSafeKeyboard.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "JYSafeKeyboardMain.h"
#import <UIKit/UIKit.h>
#import "UITextView+SafeKeyboard.h"
#import "UITextField+SafeKeyboard.h"
#import "JYAccessoryView.h"
#import "JYNumberView.h"
#import "JYLetterView.h"
#import "JYNumberView01.h"
#import "JYNumberView02.h"
#import "UIButton+SafeKeyboard.h"
#import "UIView+KeyboardExtension.h"
#import "JYSafeKeyboardConfigure.h"
static JYSafeKeyboardMain *globalKeyBoard;

@interface JYSafeKeyboardMain()<JYAccessoryViewDelegate,JYKeyboardMainViewDelegate,UITextViewDelegate>

@property(nonatomic,strong) JYAccessoryView *inputAccessoryView;//顶部视图
@property(nonatomic,strong) JYKeyboardMainView *keyBoardView;//键盘容器

@property(nonatomic,strong) JYKeyboardMainView *webKeyBoardView;//键盘容器

@property(nonatomic,assign) BOOL isNewResponder;//朝向改变，前后台切换引起的键盘弹出
@property(nonatomic,assign) BOOL isWebInput;//是否是webview调起的
//@property(nonatomic,assign) BOOL isWebKeboardShowing;//是否是webview调起的

@end

@implementation JYSafeKeyboardMain

#pragma mark - 开启方法
+ (void)useJYSafeKeyboard:(id)inputField type:(SafeKeyboardType)keyboardType{
    if ([inputField isKindOfClass:[UITextField class]]) {
        UITextField *realInputField = (UITextField*)inputField;
        realInputField.isUseSafeKeyboard = @1;
        realInputField.safeKeyboardType = [NSNumber numberWithInteger:keyboardType];
        if ([JYSafeKeyboardConfigure defaultManager].isUsedInputAccessView) {
           realInputField.inputAccessoryView = [JYSafeKeyboardMain sharedKeyBoard].inputAccessoryView ;
        }else{
            realInputField.inputAccessoryView = nil ;
        }
        
        realInputField.inputView = [JYSafeKeyboardMain sharedKeyBoard].keyBoardView;
        [realInputField addTarget:[JYSafeKeyboardMain sharedKeyBoard] action:@selector(begin:) forControlEvents:UIControlEventEditingDidBegin];
        
    }else if([inputField isKindOfClass:[UITextView class]]){
        UITextView *realInputField = (UITextView*)inputField;
        realInputField.isUseSafeKeyboard = @1;
        realInputField.safeKeyboardType = [NSNumber numberWithInteger:keyboardType];
        if ([JYSafeKeyboardConfigure defaultManager].isUsedInputAccessView) {
            realInputField.inputAccessoryView = [JYSafeKeyboardMain sharedKeyBoard].inputAccessoryView ;
        }else{
            realInputField.inputAccessoryView = nil ;
        }
        realInputField.inputView = [JYSafeKeyboardMain sharedKeyBoard].keyBoardView;
        [realInputField addNotification];
        
    }else{
        return;
    }
}
#pragma mark -

+ (void)showJYSafeKeyboard:(id)inputField type:(SafeKeyboardType)keyboardType{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat boardHeight = [JYSafeKeyboardMain sharedKeyBoard].webKeyBoardView.keyboard_h;
    JYKeyboardMainView *keyboardMainView = [JYSafeKeyboardMain sharedKeyBoard].webKeyBoardView;
    keyboardMainView.delegate = [JYSafeKeyboardMain sharedKeyBoard];
    [keyboardMainView loadKeyboardView:keyboardType];
    [JYSafeKeyboardMain sharedKeyBoard].isWebInput = YES;
    
    //
    if (![window.subviews containsObject:keyboardMainView]) {
        keyboardMainView.frame = CGRectMake(0, screenHeight, screenWidth, boardHeight);
        [window addSubview:keyboardMainView];
        [UIView animateWithDuration:0.3 animations:^{
            keyboardMainView.transform = CGAffineTransformMakeTranslation(0,-boardHeight);
        }completion:^(BOOL finished) {

        }];
    }
   
    
}
+ (void)hideWebKeyboard{
    [JYSafeKeyboardMain sharedKeyBoard].isWebInput = NO;

    //等待0.2秒，若仍然使用web键盘会充值上面这个参数，不进行隐藏操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![JYSafeKeyboardMain sharedKeyBoard].isWebInput) {
            JYKeyboardMainView *keyboardMainView = [JYSafeKeyboardMain sharedKeyBoard].webKeyBoardView;
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            if ([window.subviews containsObject:keyboardMainView]) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    keyboardMainView.transform = CGAffineTransformMakeTranslation(0,keyboardMainView.keyboard_h);
                }completion:^(BOOL finished) {
                    [keyboardMainView removeFromSuperview];
                    keyboardMainView.transform = CGAffineTransformIdentity;
                }];
            }
        }
    });
}
#pragma mark - 键盘管理单例
+ (instancetype)sharedKeyBoard{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalKeyBoard = [[self alloc] init];
        // 监听键盘
        [[NSNotificationCenter defaultCenter] addObserver:globalKeyBoard selector:@selector(keyboardWillShowAction:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:globalKeyBoard selector:@selector(keyboardDidShowAction:) name:UIKeyboardDidShowNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:globalKeyBoard selector:@selector(keyboardWillHideAction:) name:UIKeyboardWillHideNotification object:nil];
    });
    
    return globalKeyBoard;
}

- (void)begin:(UITextField*)field{
    self.isNewResponder = YES;
}


#pragma mark - 键盘即将显示
- (void)keyboardWillShowAction:(NSNotification*)notify{
    //首先通过这两行代码获取第一相应
    UIView * firstResponder = [JYKeyboardMainView getCurrentFirstResponder];
//    //处理屏幕方向切换
//    if (self.isWebInput) {
//        CGSize size = [UIScreen mainScreen].bounds.size;
//        self.keyBoardView.frame = CGRectMake(0, size.height - 210, size.width, 210);
//    }
    [JYSafeKeyboardMain hideWebKeyboard];
    //然后再通过判断响应类做出相应的响应
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        UITextField *realInputField = (UITextField*)firstResponder;
        if ([realInputField.isUseSafeKeyboard boolValue]) {
            if (self.isNewResponder) {
                [[JYSafeKeyboardMain sharedKeyBoard] loadKeyboardView:[[JYSafeKeyboardMain sharedKeyBoard] changeToKeyboardType:realInputField.safeKeyboardType]];
                self.isNewResponder = NO;
               
            }
            
        }else{
            //NSLog(@"未开启安全键盘");
        }
        //NSLog(@"UITextField");
    } else if ([firstResponder isKindOfClass:[UITextView class]]) {
        UITextView *realInputField = (UITextView*)firstResponder;
        if ([realInputField.isUseSafeKeyboard boolValue]) {
            
            if (![realInputField.isBeginEditing boolValue]) {
                [[JYSafeKeyboardMain sharedKeyBoard] loadKeyboardView:[[JYSafeKeyboardMain sharedKeyBoard] changeToKeyboardType:realInputField.safeKeyboardType]];
                
            }
        }else{
            //NSLog(@"未开启安全键盘");
        }
        //NSLog(@"UITextView");
    }else{
        //NSLog(@"非 UITextField 或 UITextView 类型调起键盘");

//        [firstResponder resignFirstResponder];
    }
}
- (void)keyboardDidShowAction:(NSNotification*)notify{

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
        case 2:
            return SafeKeyboard_Type_Number01;
            break;
        case 3:
            return SafeKeyboard_Type_Number02;
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
- (JYKeyboardMainView*)keyBoardView{
    if (!_keyBoardView) {
        //
        _keyBoardView = [[JYKeyboardMainView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 210)];
        _keyBoardView.backgroundColor = [UIColor redColor];
        _keyBoardView.delegate = self;
        
    }
    return _keyBoardView;
}
- (JYKeyboardMainView*)webKeyBoardView{
    if (!_webKeyBoardView) {
        //
        _webKeyBoardView = [[JYKeyboardMainView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 210)];
        
        _webKeyBoardView.delegate = self;
        
    }
    return _webKeyBoardView;
}
#pragma mark - 键盘相关方法

//结束输入
- (void)endEditing{
    if (self.isWebInput) {
        [JYSafeKeyboardMain hideWebKeyboard];
    }else{
    [[JYKeyboardMainView getCurrentFirstResponder] endEditing:YES];
    }
}

//切换键盘类型
- (void)loadKeyboardView:(SafeKeyboardType)keyBoardType{

    [self.keyBoardView loadKeyboardView:keyBoardType];
}
//删除操作
- (void)deletCharacter{
    
    UIView * firstResponder = [JYKeyboardMainView getCurrentFirstResponder];
    if (self.isWebInput) {
        firstResponder = [JYWebviewKeyboardManager shareWebViewManager].tmpTextField;
    }
    //然后再通过判断响应类做出相应的响应
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        UITextField *realInputField = (UITextField*)firstResponder;
        
        NSRange range = [realInputField keyboard_SelectedRange];
        if (range.length==0&&range.location>0) {
            range = NSMakeRange(range.location-1, 1);
        }
        if (self.isWebInput&&realInputField.text.length>0) {
            range = NSMakeRange(realInputField.text.length-1, 1);
        }
        realInputField.text = [realInputField.text?:@"" stringByReplacingCharactersInRange:range withString:@""];
        [realInputField keyboard_SetSelectedRange:NSMakeRange(range.location, 0)];
        
        
        //NSLog(@"UITextField");
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
//清空操作
- (void)clearAllText{
    UIView * firstResponder = [JYKeyboardMainView getCurrentFirstResponder];
    if (self.isWebInput) {
        firstResponder = [JYWebviewKeyboardManager shareWebViewManager].tmpTextField;
    }
    //然后再通过判断响应类做出相应的响应
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        UITextField *realInputField = (UITextField*)firstResponder;
        realInputField.text = @"";
        //NSLog(@"UITextField");
    } else if ([firstResponder isKindOfClass:[UITextView class]]) {
        UITextView *realInputField = (UITextView*)firstResponder;
        realInputField.text = @"";
    }
}
//点击了输入按钮
- (void)clickInputItem:(UIButton*)sender{

    [self changeTextFieldValue:sender.titleLabel.text];
    
}
- (void)changeTextFieldValue:(NSString*)value{
    UIView * firstResponder = [JYKeyboardMainView getCurrentFirstResponder];
    if (self.isWebInput) {
        firstResponder = [JYWebviewKeyboardManager shareWebViewManager].tmpTextField;
    }
    //然后再通过判断响应类做出相应的响应
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        UITextField *realInputField = (UITextField*)firstResponder;
        
        NSRange range = [realInputField keyboard_SelectedRange];
        
        if (self.isWebInput) {
            range = NSMakeRange(realInputField.text.length, 0);
        }
        realInputField.text = [realInputField.text?:@"" stringByReplacingCharactersInRange:range withString:value];
        [realInputField keyboard_SetSelectedRange:NSMakeRange(range.location+value.length, 0)];
        
//        NSLog(@"UITextField");
    } else if ([firstResponder isKindOfClass:[UITextView class]]) {
        UITextView *realInputField = (UITextView*)firstResponder;
        
        NSRange range = [realInputField keyboard_SelectedRange];
        realInputField.text = [realInputField.text?:@"" stringByReplacingCharactersInRange:range withString:value];
        
        [realInputField keyboard_SetSelectedRange:NSMakeRange(range.location+value.length, 0)];
    }
}

#pragma mark - JYAccessoryView 代理

- (void)accessoryView_clickFinish:(id)sender{
        [[JYKeyboardMainView getCurrentFirstResponder] resignFirstResponder];
}
@end
