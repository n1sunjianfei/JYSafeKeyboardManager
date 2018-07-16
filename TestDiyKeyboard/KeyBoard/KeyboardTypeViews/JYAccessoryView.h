//
//  JYAccessoryView.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYAccessoryViewDelegate <NSObject>

- (void)accessoryView_clickFinish:(id)sender;

@end

@interface JYAccessoryView : UIView
@property(nonatomic,weak) id <JYAccessoryViewDelegate> delegate;
@end
