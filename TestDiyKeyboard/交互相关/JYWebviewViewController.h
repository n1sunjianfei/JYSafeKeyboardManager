//
//  ViewController.h
//  WebApp
//
//  Created by ever on 17/1/5.
//  Copyright © 2017年 ever. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface JYWebviewViewController : UIViewController

@property (nonatomic, copy) NSString *requsetUrl;

@property (nonatomic, copy) NSString *fileName;

// 默认10s
@property (nonatomic, assign) NSTimeInterval timeoutInterval;



@end

