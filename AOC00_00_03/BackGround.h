//
//  BackGround.h
//  AOC00_00_03
//
//  Created by Ronn Hu on 10/11/13.
//
//

#import "CCLayer.h"
#import"cocos2d.h"


@interface BackGround : CCSprite
{
    int speed;
}


+(id) init;


@property(nonatomic,assign) int speed;

@end
