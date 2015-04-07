// ******************************************************************************************
//  WXSCBehaviourActionManager
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCBehaviourActionManager.h"


@implementation WXSCBehaviourActionManager
// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	currentActions=[[NSMutableArray alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[currentActions release];
[super dealloc];
}
// ******************************************************************************************
-(void)		addAction:(id)action
{
[currentActions addObject:action];
[action setActive:YES];

[action doResetForStart];				// init the concrete task to start again
[action doStart];						// init action to reset timer etc
}
// ******************************************************************************************
-(void)		removeAction:(id)action
{
if([currentActions containsObject:action])
	{
	[action doResetForStop];
	[action setActive:NO];
	[currentActions removeObject:action];
	}
}
// ******************************************************************************************
-(void)		setTaskRequestManager:(id)tm		{	taskRequestManager=tm;		}
// ******************************************************************************************
-(void)		doStart
{
[currentActions removeAllObjects];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
int t,size=[currentActions count];

for(t=0;t<size;t++)
	[[currentActions objectAtIndex:t] doAllLoopUpdate:time];
}
// ******************************************************************************************
-(void)		processTaskRequests
{

}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
int t;
[displayString  textAt:pos.x y:pos.y text:@"ACTIONS MANAGER" color:[NSColor greenColor]];
[displayString  textAt:pos.x y:pos.y+10 text:@"Name                   Object                        Method             Time" color:[NSColor greenColor]];
for(t=0;t<[currentActions count];t++)
	[[currentActions objectAtIndex:t] showMoreInfo:NSMakePoint(pos.x,pos.y+20+t*10)];

}
// ******************************************************************************************

@end
