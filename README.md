# JYSafeKeyboardManager
安全键盘（原生+网页js+遮挡适配）

1、键盘遮挡输入框处理：
//开启

    [JYKeyBoardListener useJYKeyboardListener];

2、给某个输入框使用安全键盘：
    
    [JYSafeKeyboardManager useSafeKeyboard:self.pwdTextField type:SafeKeyboard_Type_Default];
    
    [JYSafeKeyboardManager useSafeKeyboard:self.textView type:SafeKeyboard_Type_Number];
    
3、js端调用安全键盘

    - (void)showKeyBoard:(NSString*)param{
    NSDictionary *dic = [self parseDictWithJsonString:param];
    NSDictionary *frameDic = dic[@"frame"];
    NSLog(@"%@",dic);
    [JYSafeKeyboardManager useWebViewSafeKeyboardWithType:[dic[@"type"] integerValue] inputId:dic[@"inputid"] webView:self.webview frameDic:frameDic];
    }
4、设置各种键盘的颜色属性
    
    [[JYSafeKeyboardConfigure defaultManager] setKeyboardBackgroundColor:[UIColor redColor]];

5、设置仓储值
    
    [JYSafeKeyboardConfigure defaultManager].storeValue = 5000.0;

