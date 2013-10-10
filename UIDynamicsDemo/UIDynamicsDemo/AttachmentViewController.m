//
//  AttachmentViewController.m
//  UIDynamicsDemo
//
//  Created by xuyunan on 13-10-10.
//  Copyright (c) 2013年 xu_yunan@163.com. All rights reserved.
//

#import "AttachmentViewController.h"
#import "BallView.h"

@interface AttachmentViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation AttachmentViewController

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
    
    BallView *greenBall = [[BallView alloc] initWithFrame:CGRectZero];
    greenBall.backgroundColor = [UIColor greenColor];
    greenBall.center = CGPointMake(blueBall.center.x+100, blueBall.center.y-20);
    [self.view addSubview:greenBall];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[blueBall, greenBall]];
    [_animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[blueBall, greenBall]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:collisionBehavior];
    
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:greenBall attachedToItem:blueBall];
    attachmentBehavior.length = 120;    // 物体中心点间的距离
    attachmentBehavior.damping = 0.2;   // 阻尼，默认值0
    attachmentBehavior.frequency = 1;   // 震动频率，默认值0
    
    [_animator addBehavior:attachmentBehavior];

    [blueBall setTapGestureBlock:^(UIView *view){
        UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[view] mode:UIPushBehaviorModeInstantaneous];
        pushBehavior.pushDirection = CGVectorMake(0, -8);
        [_animator addBehavior:pushBehavior];
    }];
    
    [greenBall setTapGestureBlock:^(UIView *view){
        UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[view] mode:UIPushBehaviorModeInstantaneous];
        pushBehavior.pushDirection = CGVectorMake(0, -1);
        [_animator addBehavior:pushBehavior];
    }];
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
