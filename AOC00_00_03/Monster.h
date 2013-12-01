//
//  Monster.h
//  AOC00_00_03
//
//  Created by Ronn Hu on 24/11/13.
//
//

#import "CCSprite.h"

@interface Monster : CCSprite{

 int _MonsterType;

}
@property int MonsterType;

-(id) init;

-(void)Monster_move;

@end
