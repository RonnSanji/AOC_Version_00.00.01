//
//  Monster.m
//  AOC00_00_03
//
//  Created by Ronn Hu on 24/11/13.
//
//

#import "Monster.h"

@implementation Monster

@synthesize MonsterType = _MonsterType;

//对梯子初始化，我们的梯子都是一样的，所以type先用1，如果以后有更多的梯子可以用这个方法扩充
-(id) init
{       
		
	    self=[super initWithFile:@"monster.png"];
        screenSize = [[CCDirector sharedDirector] winSize];
   	    return self;
}


-(void)Monster_move {

	 [self setPosition:ccp(self.position.x+2, self.position.y - 3)];
    
	 if(self.position.x + self.contentSize.width/2 > screenSize.width){
               
               //这个时候重新设置梯子的位子，让梯子从底部从新出现
                self.position = ccp(0,self.position.y);
   
           }
           
           if(self.position.y + self.contentSize.height/2 <  0){
               
               //这个时候重新设置梯子的位子，让梯子从底部从新出现
               self.position = ccp(self.position.x,self.position.y-30);
           }


}






@end
