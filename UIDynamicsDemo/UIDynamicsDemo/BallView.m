//
//  BallView.m
//  UIDynamicsDemo
//
//  Created by Tommy on 13-10-9.
//  Copyright (c) 2013年 xu_yunan@163.com. All rights reserved.
//

#import "BallView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BallView

- (id)initWithFrame:(CGRect)frame
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat ballWidth = 60.0f;
    
    self = [super initWithFrame:CGRectMake((screenSize.width-ballWidth)/2.0f, 100.0f, ballWidth, ballWidth)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = MIN(self.frame.size.width, self.frame.size.height)/2.0f;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setTapGestureBlock:(tap_gesture_block)TapGestureBlock
{
    _TapGestureBlock = TapGestureBlock;
    [self addTapGesture];
}

- (void)addTapGesture
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ballTapped:)];
    [self addGestureRecognizer:gesture];
}

- (void)ballTapped:(UITapGestureRecognizer*)gestureRecognizer
{
    if (_TapGestureBlock) {
        _TapGestureBlock(self);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
