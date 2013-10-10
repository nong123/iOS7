//
//  GravityViewController.m
//  UIDynamicsDemo
//
//  Created by Tommy on 13-10-9.
//  Copyright (c) 2013年 xu_yunan@163.com. All rights reserved.
//

#import "GravityViewController.h"
#import "BallView.h"

@interface GravityViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation GravityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    BallView *ballView = [[BallView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:ballView];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[ballView]];
    // gravityBehavior.gravityDirection = CGVectorMake(-0.5, 1);    // 改变重力方向
    // gravityBehavior.angle = M_PI/180.0f * 30.0f;                 // 也可改变重力放下, 3点方向为0度, 顺时针依次增加, 90度正好向下
    // gravityBehavior.magnitude = 0.2f;                            // 量值，控制下路的速度，值越大速度越快，默认值为1.0f
    [_animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ballView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:collisionBehavior];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
