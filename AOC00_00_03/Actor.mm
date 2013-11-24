//
//  Actor.m
//  AOC00_00_03
//
//  Created by Ronn Hu on 16/11/13.
//
//

#import "Actor.h"

@interface Actor()

@property (nonatomic, strong) CCSprite *actor;
@property (nonatomic, strong) CCAction *walkAction;
@property (nonatomic, strong) CCAction *moveAction;
@end



@implementation Actor


@synthesize _actordirection;

+(id)init{
    
    if(self=[super init]);
    {
       self = [CCSprite spriteWithSpriteFrameName:@"front.png"];
       
       [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Man_Action.plist"];

        NSMutableArray *walkAnimFrames = [NSMutableArray array];
       
       [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"left_stand.png"]];
       [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"left_run.png"]];
       [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"left_jump.png"]];
       [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"left_run_2.png"]];
       CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.18f];
      
        //CCAction *walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
      // walkAction =[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
        
    }
    return self;
}

- (void)ActorMoveDirection:(actordiraction)direction
{
    
}

@end
