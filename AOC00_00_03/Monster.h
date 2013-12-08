//
//  Monster.h
//  AOC00_00_03
//
//  Created by Ronn Hu on 24/11/13.
//
//

#import "cocos2d.h"

@interface Monster : CCSprite{

 int _MonsterType;
 CGSize screenSize;
}
@property int MonsterType;

-(id) init;

-(void)Monster_move;

@end
