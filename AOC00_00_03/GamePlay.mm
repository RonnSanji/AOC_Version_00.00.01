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
#pragma mark - 添加移动的背景与移动背景 Ladder 也可以加里面。
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
    CCSpriteBatchNode *spriteSheet = _actor.spriteSheet;
    [_actor Action_Derive];
    [spriteSheet addChild:_actor z:2];
    
    [self addChild:spriteSheet];
   
     NSLog(@ "Actor retainCount = %d", [_actor retainCount]);
     [_actor release];
     NSLog(@ "Actor retainCount = %d", [_actor retainCount]);

    
    self.isTouchEnabled = YES;
    
}

#pragma mark -
#pragma mark - 创建梯子和障碍物
-(void) loadLadder
{

        ladderArray = [[CCArray alloc]init];

        for(int i=0; i<3; i++)
        {
             Ladder *l = [[Ladder alloc] init];

            
            l.tag = i+10;
   
            //设置每个梯子的位置，x的位子是0,y的位置递增100每个
            switch(i)
            {
                case 0:
                    l.position=(ccp(160,420));

                    break;
                    
                case 1:
                    l.position=(ccp(160,260));
     
                    break;
                    
                case 2:
                    l.position=(ccp(160,100));
                    break;

        }            
            //把梯子装进数组
        
        [ladderArray addObject:l];
        [self addChild:l z:1];

    }
}

#pragma mark -
#pragma mark - 怪物制作 怪物发射
- (void) madeMonster
{
    monsterArray = [[CCArray alloc] init];
    for(int i=0; i<3; i++)
    {
        Monster *m = [[Monster alloc] init];
        
        m.tag = i+20;
        //设置每个梯子的位置，x的位子是0,y的位置递增100每个
        switch(i)
        {
            case 0:

                m.position=(ccp(0,390));
                break;
                
            case 1:

                m.position=(ccp(0,230));
                break;
                
            case 2:
                m.position=(ccp(0,70));
                break;
                
        }
        [monsterArray addObject:m];
        [self addChild:m z:1];
    }
    
}


#pragma mark -
#pragma mark - 物品掉落
- (void) madeItems
{
    
}
-(void) update:(ccTime)delta
{
   [self scrollBackground];
   
    //new ladder
     for(int i=0; i<[ladderArray count]; i++)
       {

         
           currentL = [ladderArray objectAtIndex:i];
           [currentL Ladder_move];
           
           currentM = [monsterArray objectAtIndex:i];
           [currentM Monster_move];
       }

    
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
        
    }
    
    else
    {
        NSLog(@"Actor Jump !");
        [_actor Actor_jump];
        
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




-(void)dealloc{

    [super dealloc];
    
 }

@end
