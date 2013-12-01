//{
//   <#code#>
//}
//  Actor.m
//  AOC00_00_03
//
//  Created by Ronn Hu on 24/11/13.
//
//

#import "Actor.h"

@implementation Actor
@synthesize ActorDirection= _actorDirection;


-(id) init
{

    if(self = [super init])
    {
        
      _spirteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Man_Action.png"];
        self = [super initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"front.png" ]];
    }
    return self;
}
-(CCSpriteBatchNode*) Actor_move
{

    [self stopAction:_walkAction];
    [self stopAction:_moveAction];
    
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    
    [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"left_stand.png"]];
    [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"left_run.png"]];
    [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"left_jump.png"]];
    [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"left_run_2.png"]];
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.18f];
    
    _walkAction =[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGPoint moveDifference ;
    CGPoint moveLocation ;
    
    if(_actorDirection == Actor_left)
    {
        self.flipX = NO;
        moveDifference = ccpSub(ccp(0,self.position.y), self.position);
        moveLocation = ccp(0, self.position.y);
        
    }
    else if(_actorDirection == Actor_right)
    {
        self.flipX = YES;
        moveDifference = ccpSub(ccp(screenSize.width,self.position.y), self.position);
        moveLocation = ccp(screenSize.width, self.position.y);
    }
    
    
    float distanceToMove = ccpLength(moveDifference);
    float actorVelocity = screenSize.width / 2.5;
    float moveDuration = distanceToMove / actorVelocity;
    
    _moveAction =  [CCSequence actions:
                   [CCMoveTo actionWithDuration:moveDuration position:moveLocation],
                   [CCCallFunc actionWithTarget:self selector:@selector(ChangeActorDirection)],
                   [CCCallFunc actionWithTarget:self selector:@selector(Actor_move)],nil];
    [self runAction:_walkAction];
    [self runAction:_moveAction];
    
    return _spirteSheet;
}

-(void)ChangeActorDirection
{

    
    if(_actorDirection==Actor_left)
    {
        _actorDirection = Actor_right;
    }
    else
    {
        _actorDirection = Actor_left;
    }
    
    
}

@end
