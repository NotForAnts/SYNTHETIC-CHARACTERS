// ******************************************************************************************
//  WXSCBehaviourActionBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCBehaviourActionBasic.h"


@implementation WXSCBehaviourActionBasic
// ******************************************************************************************
-(id)   initNullAction:(NSString*)name
{
if(self=[super init])
	{
	concreteAction=nil;
	concreteMethod=nil;	
	
	actionName=name;
	[actionName retain];
	isActive=NO;
	theTimer=[[WXPoller alloc]init];
	
	maxTimeInterval=0;
	processMaxTimes=0;
	processCount=0;
	}
return self;
}
// ******************************************************************************************
-(id)   initAction:(NSString*)name ob:(id)ob sel:(SEL)sel
{
if(self=[super init])
	{
	concreteAction=ob;
	concreteMethod=sel;	
	
	actionName=name;
	[actionName retain];
	isActive=NO;
	theTimer=[[WXPoller alloc]init];
	
	maxTimeInterval=0;
	processMaxTimes=0;
	processCount=0;
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[super dealloc];
}
// ******************************************************************************************
-(void) setActive:(BOOL)state			
{   
isActive=state;		
}
// ******************************************************************************************
-(void) setActionObject:(id)object				{	concreteAction=object;		}
-(void) setActionSelelector:(SEL)sel			{	concreteMethod=sel;			}
-(void) setMaxTimeInterval:(NSTimeInterval)mt   {   maxTimeInterval=mt;			}
-(void) setMaxCount:(int)mt						{   processMaxTimes=mt;			}
// ******************************************************************************************
-(void)		doStart
{
processCount=0;
[theTimer initialiseToNow];
}
// ******************************************************************************************
-(void)		doResetForStop
{
if(concreteAction==nil) return;
[concreteAction doResetForStop];
}
// ******************************************************************************************
-(void)		doResetForStart
{
if(concreteAction==nil) return;
[concreteAction doResetForStart];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
if(processCount>=processMaxTimes && processMaxTimes>0)   return;
timeActive=[theTimer timeSincePassedSinceInitialised];
if(timeActive>maxTimeInterval && maxTimeInterval>0) return;

if(concreteAction==nil) return;
[concreteAction performSelector:concreteMethod];
processCount++;
}

// ******************************************************************************************
-(void)		showMoreInfo:(NSPoint)pos
{
if(isActive)	[displayString textAt:pos.x y:pos.y text:actionName color:[NSColor greenColor]];
else			[displayString textAt:pos.x y:pos.y text:actionName color:[NSColor grayColor]];

if(processCount>=processMaxTimes && processMaxTimes>0 && isActive) 
	[displayString textAt:pos.x-10 y:pos.y text:@"#" color:[NSColor greenColor]];

[displayString textAt:pos.x+80 y:pos.y text:[concreteAction className] color:[NSColor greenColor]];
[displayString textAt:pos.x+180 y:pos.y text:NSStringFromSelector(concreteMethod) color:[NSColor greenColor]];
[displayString timeDisplayAt:pos.x+250 y:pos.y value:timeActive*1000 color:[NSColor greenColor]];
//[displayString numberAt:pos.x+230 y:pos.y value:processCount color:[NSColor greenColor]];

if(concreteAction==nil) [displayString textAt:pos.x+50 y:pos.y text:@"No Concrete Action" color:[NSColor greenColor]];
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
if(isActive)	[displayString textAt:pos.x y:pos.y text:actionName color:[NSColor greenColor]];
else			[displayString textAt:pos.x y:pos.y text:actionName color:[NSColor grayColor]];
}
// ******************************************************************************************
-(void)		printInfo
{
printf("Action Name=%s\n",[actionName cString]);
}
// ******************************************************************************************

@end
