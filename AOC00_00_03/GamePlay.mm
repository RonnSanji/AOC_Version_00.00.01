//
//  GamePlay.mm
//  AOC_00.00.02
//
//  Created by Ronn Hu on 4/11/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

// Import the interfaces
#import "GamePlay.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "BackGround.h"
#import "Ladder.h"
#import "Monster.h"
@interface GamePlay()
{
    BOOL ActorisMoving;
    BackGround * bg1 ;
    BackGround * bg2 ;
    NSInteger adjustmentBG;
    //我新增加一个数组来装梯子
    CCArray *ladderArray;
    Ladder * currentL;
    
    //声明monster
    CCArray *monsterArray;
    Monster * currentM;

}
@property (nonatomic, strong) CCSprite *actor;
@property NSInteger ActorDirection;
@property (nonatomic, strong) CCAction *walkAction;
@property (nonatomic, strong) CCAction *moveAction;
@end

@implementation GamePlay

@synthesize ActorDirection= _actorDirection;
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GamePlay *layer = [GamePlay node];
	[scene addChild: layer];
	return scene;
}

    
-(id) init
{
        adjustmentBG = 480;
	if( (self=[super init])) {
		
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        
        //加入  BG
        bg1 = [BackGround init];
        [bg1 setAnchorPoint:ccp(0.5,0)];
        bg1.position=ccp(160,0);
        
        bg2 = [BackGround  init];
        [bg2 setAnchorPoint:ccp(0.5,0)];
        bg2.position=ccp(160, adjustmentBG - 1);
        
        //l = [Ladder init];
        
        [self addChild:bg1 z:0];
        [self addChild:bg2 z:0];
        
//        l= [[Ladder alloc]init];
//        l.position = ccp(150.0f, 400.0f);
       
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Man_Action.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Man_Action.png"];
        [self addChild:spriteSheet];
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"left_stand.png"]];
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"left_run.png"]];
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"left_jump.png"]];
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"left_run_2.png"]];
        CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.18f];
        self.actor = [CCSprite spriteWithSpriteFrameName:@"front.png"];
        [self.actor setPosition:ccp(winSize.width/2, winSize.height/2)];
        _actorDirection = arc4random()%1;
        self.walkAction =[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];

        [self Actor_Move];
        
      
 
        
        [spriteSheet addChild:self.actor z:2];
        self.isTouchEnabled = YES;
      

  
        ladderArray = [[CCArray alloc]init];
        monsterArray = [[CCArray alloc] init];
        for(int i=0; i<3; i++)
        {
             Ladder *l = [[Ladder alloc] init];
             Monster *m = [[Monster alloc] init];
            
            l.tag = i+10;
            m.tag = i+20;
            //设置每个梯子的位置，x的位子是0,y的位置递增100每个
            switch(i)
            {
                case 0:
                    l.position=(ccp(160,420));
                    m.position=(ccp(0,390));
                    break;
                    
                case 1:
                    l.position=(ccp(160,260));
                    m.position=(ccp(0,230));
                    break;
                    
                case 2:
                    l.position=(ccp(160,100));
                    m.position=(ccp(0,70));
                    break;

        }


            //把梯子装进数组
        
        [ladderArray addObject:l];
        [self addChild:l z:1];
        [monsterArray addObject:m];
        [self addChild:m z:1];
    }
       [self scheduleUpdate];
	}
	return self;
   
}

-(void) update:(ccTime)delta
{
   [self scrollBackground];
   [self Ladder_move ];

    
}
- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:
     self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    float actorVelocity = screenSize.width / 2.5;
    CGPoint moveDifference = ccpSub(touchLocation, self.actor.position);
    
    
    float distanceToMove = ccpLength(moveDifference);
    
    float moveDuration = distanceToMove / actorVelocity;
    
    
    if (moveDifference.x < 0) {
        self.actor.flipX = NO;
    } else {
        self.actor.flipX = YES;
    }
    [self.actor stopAction:self.moveAction];
    
    if (!ActorisMoving) {
        [self.actor runAction:self.walkAction];
    }
    
    CGPoint moveLocation = ccp(touchLocation.x, self.actor.position.y);
    
    
    
    self.moveAction = [CCSequence actions:
                       [CCMoveTo actionWithDuration:moveDuration position:moveLocation],
                       [CCCallFunc actionWithTarget:self selector:@selector(actorMoveEnded)],
                       nil];
    
    [self.actor runAction:self.moveAction];
    ActorisMoving = YES;
    
}
- (void)actorMoveEnded
{
    [self.actor stopAction:self.walkAction];
    ActorisMoving = NO;
}



//背景移动
- (void) scrollBackground
{
    adjustmentBG --;
    
    if (adjustmentBG <= 0)
    {
        adjustmentBG = 480;
    }
    
    [bg1 setPosition:ccp(160,adjustmentBG - 480)];
    [bg2 setPosition:ccp(160, adjustmentBG - 1)];
}

// ladder move
-(void)Ladder_move {
    
       for(int i=0; i<[ladderArray count]; i++)
       {
           //Ladder * l =[[Ladder alloc]init];
           currentL = [[Ladder alloc]init];
           currentL = [ladderArray objectAtIndex:i];
           currentM = [[Monster alloc] init];
           currentM = [monsterArray objectAtIndex:i];
           
           
           [currentL setPosition:ccp(currentL.position.x, currentL.position.y - 0.8)];
           [currentM setPosition:ccp(currentM.position.x+2, currentM.position.y - 0.8)];
           
           CGSize winSize = [[CCDirector sharedDirector] winSize];
           if(currentL.position.y + currentL.contentSize.height/2 <  0){
           //这个时候重新设置梯子的位子，让梯子从顶部从新出现
           	currentL.position = ccp(currentL.position.x,winSize.height);
           }
           if(currentM.position.x + currentM.contentSize.width/2 > winSize.width){
               
               //这个时候重新设置梯子的位子，让梯子从底部从新出现
                currentM.position = ccp(0,currentM.position.y);
               //currentL.position = ccp(currentL.position.x,winSize.height);
           }
           
           if(currentM.position.y + currentM.contentSize.height/2 <  0){
               
               //这个时候重新设置梯子的位子，让梯子从底部从新出现
               currentM.position = ccp(currentM.position.x,currentL.position.y-30);
           }
           
           
    
       }

}

-(void) Actor_Move
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGPoint moveDifference ;
    CGPoint moveLocation ;
   
    if(_actorDirection == Actor_left)
    {
        self.actor.flipX = NO;
        moveDifference = ccpSub(ccp(0,self.actor.position.y), self.actor.position);
         moveLocation = ccp(0, self.actor.position.y);

        
    }
    else if(_actorDirection == Actor_right)
    {
        self.actor.flipX = YES;
         moveDifference = ccpSub(ccp(screenSize.width,self.actor.position.y), self.actor.position);
         moveLocation = ccp(screenSize.width, self.actor.position.y);
    }
    
    
        float distanceToMove = ccpLength(moveDifference);
        float actorVelocity = screenSize.width / 2.5;
        float moveDuration = distanceToMove / actorVelocity;
    
        self.moveAction =  [CCSequence actions:
                           [CCMoveTo actionWithDuration:moveDuration position:moveLocation],
                           [CCCallFunc actionWithTarget:self selector:@selector(ChangeActorDirection)],
                           nil];
    

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
   [self Actor_Move];
}



@end
