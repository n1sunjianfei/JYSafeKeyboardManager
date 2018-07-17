//
//  ViewController.m
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import "ViewController.h"
#import "JYWebviewViewController.h"
#import "JYSafeKeyboard.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.title = @"安全键盘";
    [JYSafeKeyboardManager useSafeKeyboard:self.pwdTextField type:SafeKeyboard_Type_Number01];
    [JYSafeKeyboardManager useSafeKeyboard:self.textView type:SafeKeyboard_Type_Number];
}

- (IBAction)jumpWeb:(id)sender {
    [self.view endEditing:YES];
    JYWebviewViewController *webVC = [[JYWebviewViewController alloc]init];
    webVC.fileName = @"test";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
