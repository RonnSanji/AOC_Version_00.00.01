//
//  BackGround.m
//  AOC00_00_03
//
//  Created by Ronn Hu on 10/11/13.
//
//

#import "BackGround.h"


@implementation BackGround

@synthesize speed = _speed;


+(id) init{
    self =[CCSprite spriteWithFile:@"level.png"];
    return self;
}



@end
