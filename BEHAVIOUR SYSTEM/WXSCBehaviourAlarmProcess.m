// ******************************************************************************************
//  WXSCBehaviourAlarmProcess
//  Created by Paul Webb on 04/10/2006.
// ******************************************************************************************


#import "WXSCBehaviourAlarmProcess.h"


@implementation WXSCBehaviourAlarmProcess


// ******************************************************************************************
-(id)	init
{
if(self=[super init])
	{
	
	}
return self;
}
// ******************************************************************************************
-(void)	dealloc
{
[bahaveGroupObjectParent release];
[bahaveGroupObject release];
[super dealloc];
}
// ******************************************************************************************
-(void) setWatchNotificationName:(NSString*)nn
{
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AlarmNotification:) name:nn object:nil];
}
// ******************************************************************************************
-(void)		AlarmNotification:(NSNotification *)notification
{
//printf("ALARM NOTIFICATION RECIEVED\n");

if([bahaveGroupObject isActive])
	{
	//printf("BEHAVE GROUP ALREADY ACTIVE\n");
	}
else
	{
	//printf("do alarm bahaviour >----------------------- \n");
	
	[self doAlarmStuff];
	}
}
// ******************************************************************************************
-(void)		doAlarmStuff
{
[bahaveGroupObjectParent resetBehaveGroup];
[bahaveGroupObjectParent setSubAlarms:-10.0];
[bahaveGroupObject setAlarmLevel:10.0];
[bahaveGroupObjectParent chooseSubBehaviour];
}
// ******************************************************************************************
-(void)		setBehaviourGroup:(id)anObject
{
bahaveGroupObject=anObject;
[bahaveGroupObject retain];
}
// ******************************************************************************************
-(void)		setBehaviourGroupParent:(id)anObject
{
bahaveGroupObjectParent=anObject;
[bahaveGroupObjectParent retain];
}
// ******************************************************************************************
-(void)		doStart
{
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
}
// ******************************************************************************************

@end
