//
//  JYTextField.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/13.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>
@interface JYTextField : UITextField
@property(nonatomic,strong) NSString *inputId;
@property(nonatomic,strong) id tmpWebView;

@end
