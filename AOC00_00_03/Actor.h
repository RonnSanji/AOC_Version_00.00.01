//
//  Actor.h
//  AOC00_00_03
//
//  Created by Ronn Hu on 24/11/13.
//
//

#import "cocos2d.h"

@interface Actor : CCSprite
{
    CCSpriteBatchNode * _spirteSheet;
    CCAction *_walkAction;
    CCAction *_moveAction;
}
typedef enum :NSInteger
{
    Actor_left =0,
    Actor_right,
}ActorDirection;

@property NSInteger ActorDirection;

-(id) init;

-(CCSpriteBatchNode*) Actor_move;
-(void) ChangeActorDirection;
@end
