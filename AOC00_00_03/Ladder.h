//
//  Ladder.h
//  AOC00_00_03
//
//  Created by Ronn Hu on 16/11/13.
//
//

#import "cocos2d.h"
#include "SimpleAudioEngine.h"

@interface Ladder : CCSprite
{
    int _LadderType;
}
@property int LadderType;

-(id) init;
//+(id) initWithType:(int) Type;

-(void)Ladder_move;

//我把厦门的两个方法给注释了，因为暂时用不着，因为我们不要changeType和animation
// -(void)Ladder_ChangeType;
// -(void)Ladder_ChangeAnimation;

@end

//#include "cocos2d.h"
//#include "SimpleAudioEngine.h"
//using namespace cocos2d;
//
//class Ladder : public CCLayer
//{
//public:
//	Ladder(int type);
//	virtual ~Ladder();
//	virtual void onEnter();
//	virtual void onExit();
//	void Move();
//	void ChangeType();
//	void ChangAnimation();	//∂Øª≠
//
//	int type;
//	static int time;
//	int changTime; //image7«–ªª◊¥Ã¨”√
//	int state;
//	int index,index2;
//	CCSprite *s;
//	static CCArray* var;
