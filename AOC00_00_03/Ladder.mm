//
//  Ladder.m
//  AOC00_00_03
//
//  Created by Ronn Hu on 16/11/13.
//
//

#import "Ladder.h"


@implementation Ladder
@synthesize LadderType = _LadderType;

//对梯子初始化，我们的梯子都是一样的，所以type先用1，如果以后有更多的梯子可以用这个方法扩充
-(id) init
{
     screenSize = [[CCDirector sharedDirector] winSize];
    self=[super initWithFile:@"ladder1.png"];

    	return self;
}


-(void)Ladder_move {


	 [self setPosition:ccp(self.position.x, self.position.y - 3)];
	    if(self.position.y + self.contentSize.height/2 <  0){
           //这个时候重新设置梯子的位子，让梯子从顶部从新出现
            self.position = ccp(self.position.x,screenSize.height);
           }
           
}






@end

