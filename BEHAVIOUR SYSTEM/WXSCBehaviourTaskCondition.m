// ******************************************************************************************
//  WXSCBehaviourTaskCondition
//  Created by Paul Webb on Thu Feb 09 2006.
// ******************************************************************************************

#import "WXSCBehaviourTaskCondition.h"


@implementation WXSCBehaviourTaskCondition
// ******************************************************************************************

-(id)		initTaskCondition:(NSString*)name
{
if(self=[super init])
	{
	conditionMet=NO;
	taskConditionName=name;
	[taskConditionName retain];
	
	perceptBlackboard=[WXSCPerceptionBlackboard sharedInstance];
	
	theConditionObject=nil;
	theConditionState=nil;
	type=0;
	}
return self;
}
// ******************************************************************************************
-(void)		setDriveCentre:(id)dc		{	theDriveCentre=dc;			}
-(void)		setEmotionCentre:(id)ec		{	theEmotionCentre=ec;		}
// ******************************************************************************************
-(void)		makePerceptCondition:(NSString*)name state:(id)state
{
type=1;
theConditionObject=name;
[theConditionObject retain];
theConditionState=state;
}
// ******************************************************************************************
-(void)		makeDriveCondition:(NSString*)name state:(id)state
{
type=2;
theConditionObject=[theDriveCentre getDriveObjectNamed:name];
[theConditionObject retain];
theConditionState=state;
}
// ******************************************************************************************
-(void)		makeEmotionCondition:(NSString*)name state:(id)state
{
type=3;
theConditionObject=[theEmotionCentre getEmotionObjectNamed:name];
[theConditionObject retain];
theConditionState=state;
}
// ******************************************************************************************
-(BOOL)		conditionMet
{
switch(type)
	{
	case 1:		return [self doPerceptCondition];				break;
	case 2:		return [self doDriveCondition];					break;
	case 3:		return [self doEmotionCondition];				break;
	case 4:		return [self doAffectivePerceptCondition];		break;
	}
	
	
testCounter++;
if(testCounter>20) conditionMet=YES;
return conditionMet;
}
// ******************************************************************************************
-(BOOL)		doPerceptCondition
{
id perceptObject=[perceptBlackboard getPerceptObjectOfName:theConditionObject];
if(perceptObject==nil)  return NO;

conditionMet=[theConditionState compareToFloat:[perceptObject floatValue]];
return conditionMet;
}
// ******************************************************************************************
-(BOOL)		doDriveCondition
{
if(theConditionObject==nil)  return NO;

conditionMet=[theConditionState compareToFloat:[theConditionObject driveLevel]];
return conditionMet;
}
// ******************************************************************************************
-(BOOL)		doEmotionCondition
{
if(theConditionObject==nil)  return NO;

conditionMet=[theConditionState compareToFloat:[theConditionObject emotionLevel]];
return conditionMet;
}
// ******************************************************************************************
-(BOOL)		doAffectivePerceptCondition
{
return NO;
}
// ******************************************************************************************
-(void)		doReset
{
conditionMet=NO;
testCounter=0;
}

// ******************************************************************************************
-(void)		showAllInfo:(NSPoint)pos
{
if(conditionMet)	[displayString textAt:pos.x y:pos.y text:taskConditionName color:[NSColor greenColor]];
else				[displayString textAt:pos.x y:pos.y text:taskConditionName color:[NSColor yellowColor]];

[displayString numberAt:pos.x+50 y:pos.y value:type color:[NSColor yellowColor]];
[theConditionState showInfo:NSMakePoint(pos.x+65,pos.y)];
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
if(conditionMet)	[displayString textAt:pos.x y:pos.y text:taskConditionName color:[NSColor greenColor]];
else				[displayString textAt:pos.x y:pos.y text:taskConditionName color:[NSColor yellowColor]];
}
// ******************************************************************************************

@end
