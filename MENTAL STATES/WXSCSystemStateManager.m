// ******************************************************************************************
//  WXSCSystemStateManager
//  Created by Paul Webb on Tue May 17 2005.
// ******************************************************************************************

#import "WXSCSystemStateManager.h"


static  WXSCSystemStateManager*   myWXSCSystemStateManagerSharedInstance=nil;
// ***************************************************************************************

@implementation WXSCSystemStateManager
// ***************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	myWXSCSystemStateManagerSharedInstance=self;
	
	flipObjects=[[NSMutableArray alloc]init];
	}
return self;
}

// ***************************************************************************************
-(void) dealloc 
{
[flipObjects release];
[super dealloc];
}
// *************************************************************************************************************
+(id)		sharedInstance
{
if(myWXSCSystemStateManagerSharedInstance==nil)
	{
	printf("error WXSCSystemStateManager ....set one up before\n");
	myWXSCSystemStateManagerSharedInstance=[[WXSCSystemStateManager alloc]init];
	}
	
return myWXSCSystemStateManagerSharedInstance;
}
// *************************************************************************************************************
-(void)		addFlipObject:(WXSCSystemState*)state
{
printf("added flip %s\n",[[state stateName]cString]);
[flipObjects addObject:state];
}
// *************************************************************************************************************
-(void)		doSlowUpdates:(long)timePoint
{
int t=0;
while(t<[flipObjects count])
	{
	if([[flipObjects objectAtIndex:t]checkShouldFlip:timePoint])
		[flipObjects removeObjectAtIndex:t];
	else
		t++;
	}
}
// *************************************************************************************************************
-(void)		doReset
{
[flipObjects removeAllObjects];
}
// *************************************************************************************************************




@end
