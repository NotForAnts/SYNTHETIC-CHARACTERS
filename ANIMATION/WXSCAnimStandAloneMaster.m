// ******************************************************************************************
//  WXSCAnimStandAloneMaster
//  Created by Paul Webb on Sun Feb 05 2006.
// ******************************************************************************************

#import "WXSCAnimStandAloneMaster.h"


@implementation WXSCAnimStandAloneMaster

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	isActive=NO;
	[self initStuff];
	}
return self;
}
// ******************************************************************************************
-(void) setStageView:(id)v		{ stageView=v;  }
// ******************************************************************************************
-(void) initStuff
{
theBody=[[WXSCAnimBodyWhole alloc]init];
sequenceBank=[[WXSCAnimSequenceBank alloc]init];

[sequenceBank setBody:theBody];
}
// ******************************************************************************************
-(void) loadSequence
{
[sequenceBank doLoadApplication:nil];
[theBody setUseBlocks:NO];	
[theBody setShowPivot:NO];	
}
// ******************************************************************************************
-(void) doStop
{
isActive=NO;
}
// ******************************************************************************************
-(void) doFlipStart
{
isActive=!isActive;
if(isActive) [self runSequence];
}
// ******************************************************************************************
-(void) runSequence
{
if([sequenceBank numberSequences]==0)
	{
	isActive=NO;
	return;
	}
[theBody setUseBlocks:NO];	
[theBody setShowPivot:NO];	

[[sequenceBank current] doStart];
[[sequenceBank current] renderSequence];

isActive=YES;
[NSThread detachNewThreadSelector:@selector(backGroundThread) toTarget:self withObject:self];
}
// ******************************************************************************************
-(void)		doDraw
{
[sequenceBank doDrawBody];
}
// ******************************************************************************************
-(void)		backGroundThread
{
NSAutoreleasePool *pool2;
pool2 = [[NSAutoreleasePool alloc] init];


do{
	[sequenceBank playCurrentSequence];
	[stageView setNeedsDisplay:YES];

	[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.05]];

	}while(isActive);


[pool2 release];

}
// ******************************************************************************************



@end
