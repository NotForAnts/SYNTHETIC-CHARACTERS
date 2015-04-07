// ******************************************************************************************
//  WXSCBehaviourTaskSucessCondition
//  Created by Paul Webb on Wed Feb 08 2006.
// ******************************************************************************************


#import "WXSCBehaviourTaskSucessCondition.h"


@implementation WXSCBehaviourTaskSucessCondition

// ******************************************************************************************
-(id)		initTaskCondition:(NSString*)name
{
if(self=[super init])
	{
	conditionMet=NO;
	taskConditionName=name;
	[taskConditionName retain];
	
	perceptBlackboard=[WXSCPerceptionBlackboard sharedInstance];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[super dealloc];
}
// ******************************************************************************************
-(BOOL)		conditionMet
{
conditionMet=YES;
return conditionMet;
}
// ******************************************************************************************
-(void)		doReset
{
conditionMet=NO;
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
if(conditionMet)	[displayString textAt:pos.x y:pos.y text:taskConditionName color:[NSColor greenColor]];
else				[displayString textAt:pos.x y:pos.y text:taskConditionName color:[NSColor yellowColor]];
}
// ******************************************************************************************
@end
