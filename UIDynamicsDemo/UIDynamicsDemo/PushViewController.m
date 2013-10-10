//
//  PushViewController.m
//  UIDynamicsDemo
//
//  Created by xuyunan on 13-10-10.
//  Copyright (c) 2013年 xu_yunan@163.com. All rights reserved.
//

#import "PushViewController.h"
#import "BallView.h"

@interface PushViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation PushViewController

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
    blueBall.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueBall];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[blueBall]];
    [_animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[blueBall]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:collisionBehavior];
    
    [blueBall setTapGestureBlock:^(UIView *view){
        UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[view] mode:UIPushBehaviorModeInstantaneous];
        /*
         density
         质量，是描述物体的惯性的物理量。
         质量是决定物体受力时运动状态变化难易程度的唯一因素。
         如果将CGVectorMake(1, 0)作用于一个100 x 100的view，那么它的质量值为1，会受到一个加速度为100points/second²的正方向的作用力
         */
        
        pushBehavior.pushDirection = CGVectorMake(0, -8);   // 绝对值的大小决定了推力的大小
        [_animator addBehavior:pushBehavior];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
