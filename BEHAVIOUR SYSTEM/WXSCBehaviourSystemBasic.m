// ******************************************************************************************
//  WXSCBehaviourSystemBasic
//  Created by Paul Webb on Tue Jan 10 2006.
// ******************************************************************************************

#import "WXSCBehaviourSystemBasic.h"


@implementation WXSCBehaviourSystemBasic
// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	taskRequestManager=[[WXSCBehaviourTaskManager alloc]init];
	actionManager=[[WXSCBehaviourActionManager alloc]init];
	alarmManager=[[WXSCBehaviourAlarmManager alloc]init];
	
	[actionManager setTaskRequestManager:taskRequestManager];
	[taskRequestManager setActionManager:actionManager];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[topLevelBehaviours release];
[taskRequestManager release];
[alarmManager release];
[actionManager release];

[super dealloc];
}
// ******************************************************************************************
-(id)		taskRequestManager			{   return taskRequestManager;		}
-(void)		setMotivationCentre:(id)mc	{   motivationCentre=mc;			}
-(void)		setPerceptionSystem:(id)pc	{	perceptCentre=pc;				}
// ******************************************************************************************
-(void)		doStart
{
[alarmManager doStart];
[taskRequestManager doStart];
[topLevelBehaviours doStart];
[actionManager doStart];
[topLevelBehaviours setIsActive:YES];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
//	[alarmManager doAllLoopUpdate:time];		// REMOVE FOR NOW
[topLevelBehaviours doUpdate];
[taskRequestManager doAllLoopUpdate:time];		// checks conditions for doing actions
[actionManager doAllLoopUpdate:time];			// does actually stuff
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString  textAt:pos.x y:pos.y text:@"BEHAVE SYSTEM" color:[NSColor greenColor]];
[topLevelBehaviours showInfo:NSMakePoint(pos.x,pos.y+12)];

[taskRequestManager showInfo:NSMakePoint(pos.x,pos.y+400)];
[actionManager showInfo:NSMakePoint(pos.x,pos.y+450)];
}
// ******************************************************************************************
// OVERRIDE THIS
// ******************************************************************************************
-(void)		maketopLevelBehaviours
{
topLevelBehaviours=[[WXSCBehaviourGroupBasic alloc]initBehaviour:@"TopLevelBehaviour"];
[topLevelBehaviours	setMotivationCentre:motivationCentre];

//
WXSCBehaviourGroupBasic		*behaviour;
WXSCBehaviourGroupBasic		*sub;

// ---- behaviour main 1 ----

behaviour=[[WXSCBehaviourGroupBasic alloc]initBehaviour:@"SatiateHappy"];
[behaviour setPersistMultiple:0.99];
[behaviour setMotivationCentre:motivationCentre];
[behaviour setTaskManager:taskRequestManager];
[behaviour addEmotionContribution:@"Happy" map:@"0.3 0.6 0.2 1.0"];
[behaviour addDriveContribution:@"StimulationDrive" map:@"0.3 0.6 0.2 1.0"];
[behaviour addPerceptContribution:@"Sensor1" map:@"70 90 0.2 1.0"];
[behaviour addPerceptContribution:@"Sensor2" map:@"80 95 0.2 0.3"];
// TASK ONE
[behaviour addBehaviourTaskAndRelease:[[WXSCBehaviourTaskRequest alloc]initTaskRequest:@"Task1"]];
[[behaviour lastTask] addSuccessEmotionGain:@"Happy" gain:1.0];
[[behaviour lastTask] addSuccessEmotionGain:@"Frustration" gain:-0.8];
[behaviour addActionToTask:@"Task1" action:[[WXSCBehaviourActionBasic alloc]initNullAction:@"Action1"]];

WXSCBehaviourTaskCondition  *condition1=[[WXSCBehaviourTaskCondition alloc]initTaskCondition:@"Cond1"];
[condition1 makePerceptCondition:@"Sensor1" state:[[WXSCStateFloatGreater alloc]initGreater:50]];
//[behaviour addConditionToTask:@"Task1" condition:condition1];

WXSCBehaviourTaskCondition  *scondition1=[[WXSCBehaviourTaskCondition alloc]initTaskCondition:@"SCon1"];
[scondition1 makePerceptCondition:@"Sensor1" state:[[WXSCStateFloatGreater alloc]initGreater:85]];
[behaviour addSucessConditionToTask:@"Task1" condition:scondition1];

[[behaviour lastAction] setActionObject:[WXSCTestAnAction sharedInstance]];
[[behaviour lastAction] setActionSelelector:@selector(doFill1)];

// TASK TWO
[behaviour addBehaviourTaskAndRelease:[[WXSCBehaviourTaskRequest alloc]initTaskRequest:@"Task3"]];
[[behaviour lastTask] addSuccessEmotionGain:@"Happy" gain:0.7];
[[behaviour lastTask] addSuccessEmotionGain:@"Frustration" gain:-0.5];
[behaviour addActionToTask:@"Task3" action:[[WXSCBehaviourActionBasic alloc]initNullAction:@"Action3"]];
WXSCBehaviourTaskCondition  *condition3=[[WXSCBehaviourTaskCondition alloc]initTaskCondition:@"Cond3"];
[condition3 makePerceptCondition:@"Sensor2" state:[[WXSCStateFloatGreater alloc]initGreater:70]];
[behaviour addConditionToTask:@"Task3" condition:condition3];
WXSCBehaviourTaskCondition  *scondition2=[[WXSCBehaviourTaskCondition alloc]initTaskCondition:@"SCon2"];
[scondition1 makePerceptCondition:@"Sensor1" state:[[WXSCStateFloatGreater alloc]initGreater:93]];
[behaviour addSucessConditionToTask:@"Task3" condition:scondition2];

[[behaviour lastAction] setActionObject:[WXSCTestAnAction sharedInstance]];
[[behaviour lastAction] setActionSelelector:@selector(doFill2)];


[topLevelBehaviours addSubBehaviourAndRelease:behaviour];

sub=[[WXSCBehaviourGroupBasic alloc]initBehaviour:@"subOne"];
[sub setMotivationCentre:motivationCentre];
[sub setTaskManager:taskRequestManager];
[sub addEmotionContribution:@"Happy" map:@"0.9 0.95 0.1 1.0"];
[sub addDriveContribution:@"StimulationDrive" map:@"0.8 0.9 0.2 1.0"];
[sub addBehaviourTaskAndRelease:[[WXSCBehaviourTaskRequest alloc]initTaskRequest:@"Task4"]];
[[sub lastTask] addSuccessEmotionGain:@"Happy" gain:0.7];
[[sub lastTask] addSuccessEmotionGain:@"Frustration" gain:-0.8];
[sub addActionToTask:@"Task4" action:[[WXSCBehaviourActionBasic alloc]initNullAction:@"Action4"]];
[sub addConditionToTask:@"Task4" condition:[[WXSCBehaviourTaskCondition alloc]initTaskCondition:@"Cond4"]];
WXSCBehaviourTaskCondition  *scondition3=[[WXSCBehaviourTaskCondition alloc]initTaskCondition:@"SCon4"];
[scondition3 makePerceptCondition:@"Sensor1" state:[[WXSCStateFloatGreater alloc]initGreater:83]];
[sub addSucessConditionToTask:@"Task4" condition:scondition3];
[[sub lastAction] setActionObject:[WXSCTestAnAction sharedInstance]];
[[sub lastAction] setActionSelelector:@selector(doFill3)];
[behaviour addSubBehaviourAndRelease:sub];

// ---- behaviour main 2 ----

behaviour=[[WXSCBehaviourGroupBasic alloc]initBehaviour:@"SatiateSad"];
[behaviour setPersistMultiple:0.90];
[behaviour setMotivationCentre:motivationCentre];
[behaviour setTaskManager:taskRequestManager];
[behaviour addEmotionContribution:@"Frustration" map:@"0.1 0.6 0.2 0.8"];
[behaviour addDriveContribution:@"FatigueDrive" map:@"0.6 0.95 0.2 0.7"];
[behaviour addBehaviourTaskAndRelease:[[WXSCBehaviourTaskRequest alloc]initTaskRequest:@"Task2"]];
[behaviour addActionToTask:@"Task2" action:[[WXSCBehaviourActionBasic alloc]initNullAction:@"Action2"]];
[[behaviour lastAction] setActionObject:[WXSCTestAnAction sharedInstance]];
[[behaviour lastAction] setActionSelelector:@selector(doClear)];
[[behaviour lastAction] setMaxCount:0];

[topLevelBehaviours addSubBehaviourAndRelease:behaviour];

[topLevelBehaviours printInfo];
}
// ******************************************************************************************


@end
