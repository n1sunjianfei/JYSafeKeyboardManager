//
//  JYAccessoryView.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYNumberView02Delegate <NSObject>
- (void)numberView02_clickInputItem:(UIButton*)sender;
- (void)numberView02_clickFinish:(UIButton*)sender;
- (void)numberView02_clickDelete:(UIButton*)sender;
- (void)numberView02_clickClear:(UIButton*)sender;
- (void)numberView02_clickStore:(float)storeValue;
- (void)numberView02_clickChangeInputWay:(UIButton*)sender;
@end

@interface JYNumberView02 : UIView
@property(nonatomic,weak) id <JYNumberView02Delegate> delegate;
@end
