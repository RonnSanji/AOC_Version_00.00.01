//
//  HelloWorldLayer.h
//  AOC_00.00.02
//
//  Created by Ronn Hu on 4/11/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//



// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Actor.h"
#import "AppDelegate.h"
#import "BackGround.h"
#import "Ladder.h"
#import "Monster.h"


// GamePlay
@interface GamePlay : CCLayer
{
    NSInteger _actorDirection;
    Actor * _actor;
}



// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
