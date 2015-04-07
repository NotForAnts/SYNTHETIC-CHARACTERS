// ******************************************************************************************
//  WXSCBehaviourAlarmManager
//  Created by Paul Webb on 04/10/2006.
// ******************************************************************************************

#import "WXSCBehaviourAlarmManager.h"


@implementation WXSCBehaviourAlarmManager
// ******************************************************************************************

-(id)	init
{
if(self=[super init])
	{
	hasThread=NO;
	theAlarms=[[NSMutableArray alloc]init];
	
	}
return self;	
}
// ******************************************************************************************
-(void)		dealloc
{
[theAlarms release];
[super dealloc];
}
// ******************************************************************************************
-(void)		addAlarmProcess:(id)alarm
{
[theAlarms addObject:alarm];
}
// ******************************************************************************************
-(void)		doStart
{
[theAlarms makeObjectsPerformSelector:@selector(doStart)];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
int t,size=[theAlarms count];

for(t=0;t<size;t++)
	{
	[[theAlarms objectAtIndex:t]doAllLoopUpdate:time];
	}
}
// ******************************************************************************************

@end
