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
        //self=[CCSprite spriteWithFile:@"ladder1.png"];
	    self=[super initWithFile:@"ladder1.png"];
  
    	return self;
}


-(void)Ladder_move {
	//这一行代码的用处是，设置 梯子移动时候的位置，设置梯子x的位置为它的x的位置，设置它的y的位置为它的y位置加2，表示移动2,这个2可以改为background的speed在以后
	//self.position = ccp(self.position.x,self.position.y - 3);
    //[self setPosition:ccp(self.position.x, self.position.y - 3)];

	//如果梯子的y加上自身一半高度小于0,这是说梯子往上移动时候，超出的屏幕范围
	//CGSize winSize = [[CCDirector sharedDirector] winSize];
	//if(self.position.y + self.contentSize.height/2 <  0){

		//这个时候重新设置梯子的位子，让梯子从底部从新出现
	//	self.position = ccp(0,winSize.height);
	//}



	// this->setPosition(ccp(this->getPosition().x, this->getPosition().y + Background::speed));

	// if(this->getPosition().y + this->getContentSize().height/2 > HelloWorld::screenHeight)
	// {
	// 	//ÆÁÄ»µÄ¿í+ÌÝ×Ó¿í¶ÈÒ»°ë
	// 	int x = rand()%HelloWorld::screenWidth + 48;
	// 	this->setPosition(ccp(x > 432?  432 : x , 0));
	// 	this->changTime = 30;
	// 	this->ChangeType();
	// }


	 [self setPosition:ccp(self.position.x, self.position.y - 0.8)];
	    if(self.position.y + self.contentSize.height/2 <  0){
           //这个时候重新设置梯子的位子，让梯子从顶部从新出现
            self.position = ccp(self.position.x,winSize.height);
           }
        
           
}






@end

