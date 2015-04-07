// ******************************************************************************************
//  WXSCBehaviourTaskManager
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCBehaviourTaskManager.h"


@implementation WXSCBehaviourTaskManager

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	theTimer=[[WXPoller alloc]init];
	theTaskRequests=[[NSMutableArray alloc]init];
	theTaskOwner=[[NSMutableArray alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[theTaskOwner release];
[theTaskRequests release];
[super dealloc];
}
// ******************************************************************************************
-(void)		setActionManager:(id)am			{	theActionManager=am;		}
// ******************************************************************************************
-(void) addsTaskFromArray:(NSArray*)tasks sender:(id)sender
{
int t;
for(t=0;t<[tasks count];t++)
	{
	[[tasks objectAtIndex:t] setActionManager:theActionManager];
	[[tasks objectAtIndex:t] resetWasSucess];
	[[tasks objectAtIndex:t] doReset];
	[[tasks objectAtIndex:t] makeActive];
	[theTaskRequests addObject:[tasks objectAtIndex:t]];
	[theTaskOwner addObject:sender];
	}
}
// ******************************************************************************************
-(void) removeTaskFromArray:(NSArray*)tasks sender:(id)sender
{
int t=0;
while(t<[theTaskRequests count])
	{
	if([theTaskOwner objectAtIndex:t]==sender)
		{
		[[theTaskRequests objectAtIndex:t] resetWasSucess];
		[[theTaskRequests objectAtIndex:t] makeInActive];
		[theTaskOwner removeObjectAtIndex:t];
		[theTaskRequests removeObjectAtIndex:t];
		}
	else
		t++;
	}

}
// ******************************************************************************************
-(void)		doStart
{
[theTimer  initialiseToNow];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
int t=0;
if(![theTimer checkUpdateWithIncrement:1.0])   return;

/*
printf("TASK MANAGER DO TASKS ");
if([theTaskRequests count]==0) printf(": NO TASKS\n"); 
else 
	{
	printf(": THERE ARE TASKS ACTIVE...\n");
	for(t=0;t<[theTaskRequests count];t++)
		{
		[[theTaskRequests objectAtIndex:t]printInfo];
		}
	printf("-----oOo-------\n");
	}
	*/

[theTaskRequests makeObjectsPerformSelector:@selector(updateTaskRequest)];
[self removeSuccessfulTask];
}
// ******************************************************************************************
-(void)		removeSuccessfulTask
{
int t=0;
while(t<[theTaskRequests count])
	{
	if([[theTaskRequests objectAtIndex:t] isSuccess])
		{
		[[theTaskRequests objectAtIndex:t]doReset];
		[theTaskOwner removeObjectAtIndex:t];
		[theTaskRequests removeObjectAtIndex:t];
		}
	else
		t++;
	}
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
int t;
[displayString  textAt:pos.x y:pos.y text:@"TASK MANAGEMENT" color:[NSColor greenColor]];

pos.y=pos.y+12;
for(t=0;t<[theTaskRequests count];t++)
	{
	[[theTaskRequests objectAtIndex:t] showAllInfo:NSMakePoint(pos.x,pos.y)];
	pos.y=pos.y+12+[[theTaskRequests objectAtIndex:t] numberConditions]*12;
	}

}
// ******************************************************************************************

@end
