//
//  StartScene.m
//  AOC00_00_03
//
//  Created by Ronn Hu on 9/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StartScene.h"
#import "LevelScene.h"

@implementation StartScene

+ (id) scene {
    CCScene *sc = [CCScene node];
    StartScene *ss = [StartScene node];
    [sc addChild:ss];
    return sc;
}
+ (id) node {
    return [[[[self class] alloc] init] autorelease];
}
- (id) init {
    self = [super init];
    if (self) {
        // 创建菜单
        CGSize s = [[CCDirector sharedDirector] winSize];
        // 得到屏幕宽高
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"level.png"];
        [bgSprite setPosition:ccp(s.width/2.0f, s.height/2.0f)];
        // 以图片startbg.png创建背景精灵
        // 然后设置精灵的位置为屏幕的中心点
        [self addChild:bgSprite];
        
        
        CCSprite* beginSprite = [CCSprite spriteWithFile:@"newGame.png"];
        CCSprite* beginSpriteDown = [CCSprite spriteWithFile:@"newGame_down.png"];
        CCMenuItemSprite *beginMenuItem = [CCMenuItemSprite itemFromNormalSprite:beginSprite selectedSprite:beginSpriteDown target:self selector:@selector(beginGame:)];
        
        
        CCSprite* continueSprite = [CCSprite spriteWithFile:@"continue.png"];
        CCSprite* continueSpriteDown = [CCSprite spriteWithFile:@"continue_down.png"];
        CCMenuItemSprite *continueMenuItem = [CCMenuItemSprite itemFromNormalSprite:continueSprite selectedSprite:continueSpriteDown target:self selector:@selector(continueGame:)];
        
        CCSprite* optioneSprite = [CCSprite spriteWithFile:@"option.png"];
        CCSprite* optionSpriteDown = [CCSprite spriteWithFile:@"option_down.png"];
        CCMenuItemSprite *optionMenuItem = [CCMenuItemSprite itemFromNormalSprite:optioneSprite selectedSprite:optionSpriteDown target:self selector:@selector(optionGame:)];
        
        
        
        CCSprite* helpSprite = [CCSprite spriteWithFile:@"help.png"];
        CCSprite* helpSpriteDown = [CCSprite spriteWithFile:@"help_down.png"];
        CCMenuItemSprite *helpMenuItem = [CCMenuItemSprite itemFromNormalSprite:helpSprite selectedSprite:helpSpriteDown target:self selector:@selector(helpGame:)];
        
        CCMenu *menu = [CCMenu menuWithItems:beginMenuItem, continueMenuItem,optionMenuItem,helpMenuItem,nil];
        [menu setPosition:ccp((s.width)/2, (s.height)/2)];
        [menu alignItemsVertically];
        [self addChild:menu];
        
        

    }
    return self;
}

- (void) beginGame:(id)arg {
    NSLog(@"开始游戏");
    CCScene *level = [LevelScene scene];
    // 1. 竖向动画
    //    CCTransitionScene *trans = [[CCTransitionSplitCols alloc] initWithDuration:5.0f scene:level];
    // 2. 横向剧场
    //    CCTransitionScene *trans = [[CCTransitionSplitRows alloc] initWithDuration:5.0f scene:level];
    // 3. 雷达效果(2种)
    //    CCTransitionScene *trans = [[CCTransitionRadialCCW alloc] initWithDuration:5.0f scene:level];
    // 4. 小格子动画
    //    CCTransitionScene *trans = [[CCTransitionTurnOffTiles alloc] initWithDuration:5.0f scene:level];
    // 5. 左右滑动
    //    CCTransitionScene *trans = [[CCTransitionSlideInL alloc] initWithDuration:5.0f scene:level];
    // 6. 翻转效果
    //    CCTransitionScene *trans = [[CCTransitionFlipX alloc] initWithDuration:5.0f scene:level];
    
    // 7. 翻转效果
    //    CCTransitionScene *trans = [[CCTransitionZoomFlipAngular alloc] initWithDuration:1.0f scene:level];
    
    CCTransitionScene *trans = [[CCTransitionSplitRows alloc] initWithDuration:1.0f scene:level];
    
    // 给一个时间5s 让他CCTransitionSplitCols动画到level剧场
    // trans也是一个剧场
    [[CCDirector sharedDirector] replaceScene:trans];
    // 导演切换到动画剧场 trans
    [trans release];
    
}

-(void)continueGame:(id)arg{
       NSLog(@"继续游戏");
}

-(void)optionGame:(id)arg{
    NSLog(@"游戏选项");
}

-(void)helpGame:(id)arg{
    NSLog(@"游戏帮助");
}
@end
