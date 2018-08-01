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
6、是否使用InputAccessView

    [[JYSafeKeyboardConfigure defaultManager] setIsUsedInputAccessView:NO];
    
7、web调起键盘，因为系统焦点的转移，会出现键盘先隐藏再显示的过程，所以增加一种方式，允许直接添加键盘的view进行输入

    //web第一种输入方式，使用window上添加键盘view，这种方式处理使用比较麻烦，需要及时删除键盘view才行。
    [JYSafeKeyboardMain showJYSafeKeyboard:[JYWebviewKeyboardManager shareWebViewManager].tmpTextField type:[self returnKeyboardType:keyboardType]];
    
    //web第二种输入方式，使用类系统键盘方式，但是存在点击一个输入框就隐藏键盘然后重新显示的问题  
    [JYSafeKeyboardMain useJYSafeKeyboard:[JYWebviewKeyboardManager shareWebViewManager].tmpTextField type:[self returnKeyboardType:keyboardType]];
    [textField becomeFirstResponder];
    [scrollView addSubview:textField];

