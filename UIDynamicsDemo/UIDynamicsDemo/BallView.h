//
//  BallView.h
//  UIDynamicsDemo
//
//  Created by Tommy on 13-10-9.
//  Copyright (c) 2013年 xu_yunan@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tap_gesture_block)(UIView *view);

@interface BallView : UIView
@property (nonatomic, strong) tap_gesture_block TapGestureBlock;
@end
