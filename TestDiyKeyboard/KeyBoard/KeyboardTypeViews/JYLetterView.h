//
//  JYAccessoryView.h
//  TestDiyKeyboard
//
//  Created by ever-mac on 2018/7/11.
//  Copyright © 2018年 ever-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYLetterViewDelegate <NSObject>
- (void)leterView_clickInputItem:(UIButton*)sender;
- (void)leterView_clickFinish:(UIButton*)sender;
- (void)leterView_clickDelete:(UIButton*)sender;
- (void)leterView_clickChangeInputWay:(UIButton*)sender;

@end

@interface JYLetterView : UIView
@property(nonatomic,weak) id <JYLetterViewDelegate> delegate;
- (void)lowerLetters;
@end
