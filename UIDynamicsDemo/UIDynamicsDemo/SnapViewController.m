//
//  SnapViewController.m
//  UIDynamicsDemo
//
//  Created by xuyunan on 13-10-10.
//  Copyright (c) 2013年 xu_yunan@163.com. All rights reserved.
//

#import "SnapViewController.h"
#import "BallView.h"

@interface SnapViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@end

@implementation SnapViewController

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
    
    BallView *blueBall = [[BallView alloc] initWithFrame:CGRectZero];
    blueBall.tag = 1000;
    blueBall.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueBall];

    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[blueBall]];
    [_animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[blueBall]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:collisionBehavior];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)viewTapped:(UITapGestureRecognizer *)gesture
{
    CGPoint loc = [gesture locationInView:self.view];
    UIView *view = [self.view viewWithTag:1000];
    
    if (_snapBehavior) {
        [_animator removeBehavior:_snapBehavior];
        _snapBehavior = nil;
    }
    
    // 让物体运动到一个指定的点，在终点附近会有一个弹簧的效果
    _snapBehavior = [[UISnapBehavior alloc] initWithItem:view snapToPoint:loc];
    _snapBehavior.damping = 0.4;    // 默认值0.5

    [_animator addBehavior:_snapBehavior];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
