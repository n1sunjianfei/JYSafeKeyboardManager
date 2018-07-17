//
//  JYAccessoryView.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYNumberView01Delegate <NSObject>
- (void)numberView01_clickInputItem:(UIButton*)sender;
- (void)numberView01_clickFinish:(UIButton*)sender;
- (void)numberView01_clickDelete:(UIButton*)sender;
- (void)numberView01_clickClear:(UIButton*)sender;
- (void)numberView01_clickChangeInputWay:(UIButton*)sender;
@end

@interface JYNumberView01 : UIView
@property(nonatomic,weak) id <JYNumberView01Delegate> delegate;
@end
