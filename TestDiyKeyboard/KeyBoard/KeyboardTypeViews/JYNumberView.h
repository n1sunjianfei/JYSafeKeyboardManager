//
//  JYAccessoryView.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYNumberViewDelegate <NSObject>
- (void)numberView_clickInputItem:(UIButton*)sender;
- (void)numberView_clickFinish:(UIButton*)sender;
- (void)numberView_clickDelete:(UIButton*)sender;
- (void)numberView_clickChangeInputWay:(UIButton*)sender;
@end

@interface JYNumberView : UIView
@property(nonatomic,weak) id <JYNumberViewDelegate> delegate;
@end
