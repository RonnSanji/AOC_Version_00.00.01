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
@synthesize spriteSheet =_spirteSheet;


-(id) init
{


    if(self = [super init])
    {
      screenSize = [[CCDirector sharedDirector] winSize];
      _spirteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Man_Action.png"];
        self = [super initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"front.png" ]];
        

    }
    return self;
}

//-(CCSpriteBatchNode*) Actor_move

-(void) Actor_walk
{
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
    
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"left_stand.png"]];
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"left_run.png"]];
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"left_jump.png"]];
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"left_run_2.png"]];
        CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.18f];
        _walkAction =[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    return;
}
-(void) Actor_move
{
    float distanceToMove ;
    float actorVelocity ;
    float moveDuration ;
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
    
    
    distanceToMove = ccpLength(moveDifference);
    actorVelocity = screenSize.width / 2.5;
    moveDuration = distanceToMove / actorVelocity;
    
    _moveAction =[CCSequence actions:
                [CCMoveTo actionWithDuration:moveDuration position:moveLocation],
                [CCCallFunc actionWithTarget:self selector:@selector( ChangeActorDirection)],nil];
    
    
    return ;
}

-(void) Actor_jump
{
    [self stopAction:_moveAction];
    [self stopAction:_walkAction];
    float distanceTojump;
    float jumpactorVelocity ;
    float jumpDuration;
    
    jumpDifference = ccpSub(ccp(self.position.x,self.position.y+40.f), self.position);
    jumpLocation = ccp(self.position.x, self.position.y+40.f);  //80 will be change to ladder position.y
    
     distanceTojump = ccpLength(jumpDifference);
     jumpactorVelocity = screenSize.height / 2.2;
     jumpDuration = distanceTojump / jumpactorVelocity;
    NSLog(@"jumpduration is %f" , jumpDuration);
    
    

    _jumpAction =  [CCSequence actions:
                   [CCJumpTo actionWithDuration:jumpDuration position:jumpLocation height:40 jumps:1],
                   [CCCallFunc actionWithTarget:self selector:@selector(Action_Derive)],nil];
    [self runAction:_jumpAction];
    
    return;
}

-(void)ChangeActorDirection
{
    [self stopAction:_moveAction];
    if(_actorDirection==Actor_left)
    {
        _actorDirection = Actor_right;
    }
    else
    {
        _actorDirection = Actor_left;
    }
    [self Actor_move];
    [self runAction:_moveAction];
   
}

-(void) Action_Derive{
    
    [self Actor_walk];
    [self Actor_move];
    [self stopAction:_jumpAction];
    [self runAction:_walkAction];
    [self runAction:_moveAction];
    
}




@end
