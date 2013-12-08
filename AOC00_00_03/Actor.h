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
    CCAction *_jumpAction;
    CGSize screenSize;
    CGPoint moveDifference ;
    CGPoint moveLocation ;
    CGPoint jumpDifference ;
    CGPoint jumpLocation ;
    


    
    bool _Actorismoving;
    
}
typedef enum :NSInteger
{
    Actor_left =0,
    Actor_right,
}ActorDirection;

typedef enum ordertype :NSInteger
{
    Actor_Jump_e = 0,
    Actor_Move_e,
    
}ActorMoveOrder;

@property NSInteger ActorDirection;
@property (readonly) CCSpriteBatchNode* spriteSheet;
-(id) init;

-(void) Action_Derive;
-(void) Actor_move;
-(void) Actor_jump;
-(void) ChangeActorDirection;
@end
