// ******************************************************************************************
//  WXSCSystemState
//  Created by Paul Webb on Wed May 11 2005.
// ******************************************************************************************


#import "WXSCSystemState.h"
#import "WXSCSystemStateManager.h"


// ******************************************************************************************
@implementation WXSCSystemState

// ******************************************************************************************
-(id)   initState:(NSString*)name
{
if(self=[super init])
	{
	externalVarPointer=nil;
	flipStateActive=NO;
	stateName=name;
	[stateName retain];
	changeCount=0;
	symbolValue=[[NSMutableString alloc]initWithString:@""];
	
	systemStateManager=[WXSCSystemStateManager sharedInstance];
	}
return self;
}
// ******************************************************************************************
-(id)   initStateWithPointer:(NSString*)name vp:(int*)vp
{
if(self=[super init])
	{
	externalVarPointer=vp;
	flipStateActive=NO;
	stateName=name;
	[stateName retain];
	changeCount=0;
	symbolValue=[[NSMutableString alloc]initWithString:@""];
	
	systemStateManager=[WXSCSystemStateManager sharedInstance];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[super dealloc];
}
// ******************************************************************************************
-(void) resetTo:(int)value
{
changeCount=1;
stateValue=value;
stateDidChange=NO;
}
// ******************************************************************************************
-(void) reset
{
changeCount=0;
stateValue=-666;
stateDidChange=NO;
}
// ******************************************************************************************
-(BOOL)		boolValue		{	return (BOOL)stateValue;		}
-(int)		intValue		{	return stateValue;				}
-(float)	floatValue		{	return (float)stateValue;		}
-(NSString*)	stateName   {   return stateName;				}
// ******************************************************************************************
-(int)		decrement:(long)timePoint
{
stateValue--;
lastStateChangeTime=timePoint;
return stateValue;
}
// ******************************************************************************************
-(int)		increment:(long)timePoint
{
stateValue++;
lastStateChangeTime=timePoint;
return stateValue;
}
// ******************************************************************************************
-(BOOL)		checkShouldFlip:(long)timePoint
{
if(!flipStateActive)	return NO;

if(timePoint>flipTimePoint)
	{
	printf("flipped %s to %d\n",[stateName cString],flipValue);
	stateValue=flipValue;
	flipStateActive=NO;
	return YES;
	}
return NO;
}
// ******************************************************************************************
-(BOOL)		setStateToFlip:(int)value time:(long)timePoint delay:(int)delay flip:(int)flip
{
flipStateActive=YES;
flipTimePoint=timePoint+delay;
flipValue=flip;
stateValue=value;
[systemStateManager addFlipObject:self];
return YES;
}
// ******************************************************************************************
-(BOOL)		setStateWithUpdateRange:(int)value time:(long)timePoint range:(int)range
{
//flipStateActive=NO;
if(value!=stateValue || changeCount==0)
	{
	stateDidChange=!WXUNear(value,stateValue,range);
	stateValue=value;
	changeCount++;
	lastStateChangeTime=timePoint;
	return stateDidChange;
	}
return NO;
}

// ******************************************************************************************
-(BOOL)		setStateBoolIfTimeDifference:(long)checkTime time:(long)timePoint diff:(int)diff
{
int value=(timePoint-checkTime)<diff;

//flipStateActive=NO;
if(value!=stateValue || changeCount==0)
	{
	stateValue=value;
	changeCount++;
	stateDidChange=YES;
	lastStateChangeTime=timePoint;
	return YES;
	}
return NO;

}
// ******************************************************************************************
-(BOOL)		setState:(int)value time:(long)timePoint
{
//flipStateActive=NO;
if(value!=stateValue || changeCount==0)
	{
	stateValue=value;
	changeCount++;
	stateDidChange=YES;
	lastStateChangeTime=timePoint;
	return YES;
	}
return NO;
}
// ******************************************************************************************
-(BOOL)		setSymbol:(NSMutableString*)value time:(long)timePoint
{
}
// ******************************************************************************************
-(int)		getChangePeriod:(long)timePoint
{
return timePoint-lastStateChangeTime;
}
// ******************************************************************************************

@end
