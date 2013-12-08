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

@interface GamePlay()
{
    BOOL ActorisMoving;
    BackGround * bg1 ;
    BackGround * bg2 ;
    NSInteger adjustmentBG;
    CGSize winSize;
    //我新增加一个数组来装梯子
    CCArray *ladderArray;
    Ladder * currentL;
    //声明monster
    CCArray *monsterArray;
    Monster * currentM;

}

@end

@implementation GamePlay


+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GamePlay *layer = [GamePlay node];
	[scene addChild: layer];
	return scene;
}

    
-(id) init
{
    
	if( (self=[super init])) {
        //播放音乐
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"game_music.mp3" loop:YES];
        
        //初始化数据
        [self initData];
        
        //载入背景
        [self loadBackground];
        
        //载入玩家
        [self loadPlayer];

        //载入梯子和障碍物
        [self loadLadder];
                
        //加入怪物
        [self madeMonster];
        
        //加入物品
        [self madeItems];
		      
    }
       [self scheduleUpdate];
	}
	return self;
   
}
#pragma mark -
#pragma mark - 初始化数据
- (void) initData
{
    winSize = [[CCDirector sharedDirector] winSize];
    adjustmentBG = 480;
    
}

#pragma mark -
#pragma mark - 添加移动的背景与移动背景
- (void) loadBackground
{
    //加入  BG
    bg1 = [BackGround init];
    [bg1 setAnchorPoint:ccp(0.5,0)];
    bg1.position=ccp(160,0);
    
    bg2 = [BackGround  init];
    [bg2 setAnchorPoint:ccp(0.5,0)];
    bg2.position=ccp(160, adjustmentBG - 1);
    
    
    [self addChild:bg1 z:0];
    [self addChild:bg2 z:0];
    
}

#pragma mark -
#pragma mark - 玩家加载
- (void) loadPlayer
{
    _actor = [[Actor alloc] init];
    [_actor setPosition:ccp(winSize.width/2, winSize.height/2)];
    
    CCSpriteBatchNode *spriteSheet = [_actor Actor_move];
    
    [spriteSheet addChild:_actor z:2];
    
    [self addChild:spriteSheet];
    
    
    self.isTouchEnabled = YES;
    
}

#pragma mark -
#pragma mark - 创建梯子和障碍物
-(void) loadLadder
{

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

#pragma mark -
#pragma mark - 怪物制作 怪物发射
- (void) madeMonster
{
    
}


#pragma mark -
#pragma mark - 物品掉落
- (void) madeItems
{
    
}
-(void) update:(ccTime)delta
{
   [self scrollBackground];
   //[self Ladder_move ];
   
    //new ladder
     for(int i=0; i<[ladderArray count]; i++)
       {
           //Ladder * l =[[Ladder alloc]init];
           currentL = [[Ladder alloc]init];
           currentL = [ladderArray objectAtIndex:i];
           currentM = [[Monster alloc] init];
           currentM = [monsterArray objectAtIndex:i];

           [currentL Ladder_move];
           [currentM Monster_move];
       }



    //end of new ladder

    
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
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    if(touchLocation.x<screenSize.width/2 && touchLocation.y<screenSize.height)
    {
        NSLog(@"Actor change position!");
        [_actor ChangeActorDirection];
        [_actor Actor_move];
    }
    
    else
    {
        NSLog(@"Actor Jump !");
    }
    
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
// -(void)Ladder_move {
    
//        for(int i=0; i<[ladderArray count]; i++)
//        {
//            //Ladder * l =[[Ladder alloc]init];
//            currentL = [[Ladder alloc]init];
//            currentL = [ladderArray objectAtIndex:i];
//            currentM = [[Monster alloc] init];
//            currentM = [monsterArray objectAtIndex:i];
           
           
//            [currentL setPosition:ccp(currentL.position.x, currentL.position.y - 0.8)];
//            [currentM setPosition:ccp(currentM.position.x+2, currentM.position.y - 0.8)];
  
//            if(currentL.position.y + currentL.contentSize.height/2 <  0){
//            //这个时候重新设置梯子的位子，让梯子从顶部从新出现
//            	currentL.position = ccp(currentL.position.x,winSize.height);
//            }
//            if(currentM.position.x + currentM.contentSize.width/2 > winSize.width){
               
//                //这个时候重新设置梯子的位子，让梯子从底部从新出现
//                 currentM.position = ccp(0,currentM.position.y);
//                //currentL.position = ccp(currentL.position.x,winSize.height);
//            }
           
//            if(currentM.position.y + currentM.contentSize.height/2 <  0){
               
//                //这个时候重新设置梯子的位子，让梯子从底部从新出现
//                currentM.position = ccp(currentM.position.x,currentL.position.y-30);
//            }
           
           
    
//        }

// }

//-(void) Actor_Move
//{
//    CGSize screenSize = [[CCDirector sharedDirector] winSize];
//    CGPoint moveDifference ;
//    CGPoint moveLocation ;
//   
//    if(_actorDirection == Actor_left)
//    {
//        self.actor.flipX = NO;
//        moveDifference = ccpSub(ccp(0,self.actor.position.y), self.actor.position);
//         moveLocation = ccp(0, self.actor.position.y);
//
//        
//    }
//    else if(_actorDirection == Actor_right)
//    {
//        self.actor.flipX = YES;
//         moveDifference = ccpSub(ccp(screenSize.width,self.actor.position.y), self.actor.position);
//         moveLocation = ccp(screenSize.width, self.actor.position.y);
//    }
//    
//    
//        float distanceToMove = ccpLength(moveDifference);
//        float actorVelocity = screenSize.width / 2.5;
//        float moveDuration = distanceToMove / actorVelocity;
//    
//        self.moveAction =  [CCSequence actions:
//                           [CCMoveTo actionWithDuration:moveDuration position:moveLocation],
//                           [CCCallFunc actionWithTarget:self selector:@selector(ChangeActorDirection)],
//                           nil];
//    
//
//}

//-(void)ChangeActorDirection
//{
//    if(_actorDirection==Actor_left)
//    {
//        _actorDirection = Actor_right;
//    }
//    else
//    {
//        _actorDirection = Actor_left;
//    }
//   [self Actor_Move];
//}




@end
