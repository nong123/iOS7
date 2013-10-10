//
//  CollisionViewController.m
//  UIDynamicsDemo
//
//  Created by Tommy on 13-10-9.
//  Copyright (c) 2013年 xu_yunan@163.com. All rights reserved.
//

#import "CollisionViewController.h"
#import "BallView.h"

@interface CollisionViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation CollisionViewController

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
    
    UIView *stickView = [[UIView alloc] initWithFrame:CGRectMake(50.0f, 300, 220, 2)];
    stickView.backgroundColor = [UIColor greenColor];
    stickView.transform = CGAffineTransformMakeRotation(M_PI/180.0f*60.0f);
    [self.view addSubview:stickView];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[ballView]];
    [_animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ballView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:collisionBehavior];
    
    // 这里是设置了一条线段，其实还可以设置bezierPath，具体看UICollisionBehavior
    UICollisionBehavior *stickCollision = [[UICollisionBehavior alloc] initWithItems:@[ballView]];
    [stickCollision addBoundaryWithIdentifier:@"stick" fromPoint:stickView.frame.origin toPoint:CGPointMake(stickView.frame.origin.x+stickView.frame.size.width, stickView.frame.origin.y+stickView.frame.size.height)];
    [_animator addBehavior:stickCollision];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
