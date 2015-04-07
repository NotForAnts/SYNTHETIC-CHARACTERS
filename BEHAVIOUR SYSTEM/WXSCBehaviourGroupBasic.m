// ******************************************************************************************
//  WXSCBehaviourGroupBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCBehaviourGroupBasic.h"


@implementation WXSCBehaviourGroupBasic
// ******************************************************************************************
-(id)		initBehaviour:(NSString*)name
{
if(self=[super init])
	{
	behaveName=name;
	[behaveName retain];
	
	theMotivationCentre=nil;
	theEmotionCentre=nil;
	theDriveCentre=nil;
	
	activationLevel=0;
	isActive=NO;
	isAnAlarmGroup=NO;
	doneGraphAdd=NO;
	frustrationGain=0;
	frustrationLevel=1.0;
	giveUpFrustrationLevel=frustrationLevel*6.0;
	
	defaultPersistance=1.0;
	currentPersistance=0;
	persistMultiple=0.92;
	alarmLevelGain=0;
	
	emotionContributions=[[NSMutableArray alloc]init];
	driveContributions=[[NSMutableArray alloc]init];
	perceptContributions=[[NSMutableArray alloc]init];
	releaserContributions=[[NSMutableArray alloc]init];
	goalReachedContributions=[[NSMutableArray alloc]init];
	
	behaviourGroup=[[NSMutableArray alloc]init];
	behaviourTasks=[[NSMutableArray alloc]init];
	
	
	theDataGraph=[[NSMutableArray alloc]init];
	[[WXNSArrayDataPlotter sharedInstance]addArrayToPlot:
		theDataGraph
		ydisp:[[WXNSArrayDataPlotter sharedInstance] numberPlots]*20
		yscale:3.0
		name:behaveName];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[super dealloc];
}
// ******************************************************************************************
-(void) doUpdate
{
}
// ******************************************************************************************
-(void)			addEndGoalContributionAndRelease:(id)object
{
[goalReachedContributions addObject:object];
[object release];
}
// ******************************************************************************************
-(void)			addBehaviourTask:(id)object
{
[behaviourTasks addObject:object];
[object setEmotionCentre:theEmotionCentre];
numberTaskRequests=[behaviourTasks count];
}
// ******************************************************************************************
-(void)			addBehaviourTaskAndRelease:(id)object
{
lastTask=object;
[behaviourTasks addObject:object];
[object setEmotionCentre:theEmotionCentre];
[object release];
numberTaskRequests=[behaviourTasks count];
}
// ******************************************************************************************
-(void)			addActionToTask:(NSString*)name action:(id)action
{
id  task=[self getTaskWithName:name];
if(task!=nil)   [task setAction:action];
lastAction=action;

[action retain];
}
// ******************************************************************************************
-(void)			addConditionToTask:(NSString*)name condition:(id)condition
{
id  task=[self getTaskWithName:name];
if(task!=nil)   [task addCondition:condition];
}
// ******************************************************************************************
-(void)			addSucessConditionToTask:(NSString*)name condition:(id)condition
{
id  task=[self getTaskWithName:name];
if(task!=nil)   [task addSucessCondition:condition];
}
// ******************************************************************************************
-(void)			setIsAnAlarm:(BOOL)state
{
isAnAlarmGroup=state;
}
// ******************************************************************************************
-(id)			task:(NSString*)name
{
return [self getTaskWithName:name];
}
// ******************************************************************************************
-(id)			getTaskWithName:(NSString*)name
{
int t;
for(t=0;t<[behaviourTasks count];t++)
	if([[[behaviourTasks objectAtIndex:t]taskName]isEqualToString:name])
		return [behaviourTasks objectAtIndex:t];
		
return nil;		
}
// ******************************************************************************************
-(id)			lastAction  {   return lastAction;  }
-(id)			lastTask	{   return lastTask;	}
// ******************************************************************************************
-(void)			addSubBehaviourAndRelease:(id)object
{
[behaviourGroup addObject:object];
[object release];
}
// ******************************************************************************************
-(void)			addPerceptContribution:(NSString*)refName map:(NSString*)map
{
WXSCBehaviourPerceptContribution  *contribution;

contribution=[[WXSCBehaviourPerceptContribution alloc]init];

[contribution setPerceptSystem:perceptCentre];
[contribution setContributionName:refName];
[contribution setMapper:map];

[perceptContributions addObject:contribution];
[contribution release];
}
// ******************************************************************************************
-(void)			 addPerceptContributionEqual:(NSString*)refName value:(float)value contribution:(float)weight error:(float)error
{
WXSCBehaviourPerceptContribution  *contribution;

contribution=[[WXSCBehaviourPerceptContribution alloc]init];

[contribution setPerceptSystem:perceptCentre];
[contribution setContributionName:refName];
[contribution setAsEqual:value contribution:weight error:error];

[perceptContributions addObject:contribution];
[contribution release];
}
// ******************************************************************************************
-(void)			addDriveContribution:(NSString*)refName map:(NSString*)map
{
WXSCBehaviourDriveContribution  *contribution;
id driveObject=[theDriveCentre getDriveObjectNamed:refName];

if(driveObject==nil)
	{
	printf("DriveContribution not added - Not Found %s\n\n",[refName cString]);
	return;
	}

contribution=[[WXSCBehaviourDriveContribution alloc]init];
[contribution setContributionObject:driveObject];
[contribution setMapper:map];

[driveContributions addObject:contribution];
[contribution release];
}
// ******************************************************************************************
-(void)			addEmotionContribution:(NSString*)refName map:(NSString*)map
{
WXSCBehaviourEmotionContribution   *contribution;
id emotionObject=[theEmotionCentre getEmotionObjectNamed:refName];

if(emotionObject==nil)
	{
	printf("EmotionContribution not added - Not Found %s\n\n",[refName cString]);
	return;
	}

contribution=[[WXSCBehaviourEmotionContribution alloc]init];
[contribution setContributionObject:emotionObject];
[contribution setMapper:map];

[emotionContributions addObject:contribution];
[contribution release];
}
// ******************************************************************************************
-(void)		chooseSubBehaviour
{
if(!isActive)   return;

//printf("CHOOSE SUB BEHAVIOUR\n");

if([behaviourGroup count]==0)   return;

[behaviourGroup makeObjectsPerformSelector:@selector(doProcess)];

// find new max behaviour
float   level,maxlevel=0;
int t,maxIndex=-1;
for(t=0;t<[behaviourGroup count];t++)
	{
	level=[[behaviourGroup objectAtIndex:t]activationLevel];
	if(level>maxlevel)
		{
		maxlevel=level;
		maxIndex=t;
		}
	}

// switch off current is not max index (this can be if maxIndex is nothing -1 too)
if(currentBehaviourGroupIndex>=0 && maxIndex!=currentBehaviourGroupIndex) 
	[[behaviourGroup objectAtIndex:currentBehaviourGroupIndex] setIsActive:NO];
currentBehaviourGroupIndex=maxIndex;

// and make top and start it up
if(maxIndex>=0 && maxlevel>0.7)
	{
	[[behaviourGroup objectAtIndex:maxIndex] setIsActive:YES];
	}
}

// ******************************************************************************************



// ******************************************************************************************
-(void)		backGroundThread
{
NSAutoreleasePool *pool2;
pool2 = [[NSAutoreleasePool alloc] init];


do{

	//printf("thread for BG %s\n",[behaveName cString]);
	
	[self chooseSubBehaviour];
	
	[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
	}while(isActive);


[pool2 release];	
}
// ******************************************************************************************
-(BOOL)			allTasksRequestsSuccess
{
int t;
for(t=0;t<[behaviourTasks count];t++)
	if(![[behaviourTasks objectAtIndex:t]wasSucess])  return NO;
	
return YES;
}

// ******************************************************************************************
-(BOOL)			allGoalsReached
{
int t;
if(![self allTasksRequestsSuccess]) return NO;
for(t=0;t<[behaviourGroup count];t++)
	if(![[behaviourGroup objectAtIndex:t]allTasksRequestsSuccess])  return NO;
	
return YES;	
}
// ******************************************************************************************
-(void)			doProcess
{
float   level=0,frustDec,taskFrustration;
int t;

level=currentPersistance;
currentPersistance=currentPersistance*persistMultiple;
if(currentPersistance<0) currentPersistance=0;

level=level+alarmLevelGain;
alarmLevelGain=alarmLevelGain*0.8;

if([self allTasksRequestsSuccess]) currentPersistance=0;

// plus persistance of sub groups
for(t=0;t<[behaviourGroup count];t++)
	level=level+[[behaviourGroup objectAtIndex:t]currentPersistance];
	
// plus activation of sub groups
//for(t=0;t<[behaviourGroup count];t++)
//	level=level+[[behaviourGroup objectAtIndex:t]currentPersistance];	

// plus contributions
for(t=0;t<[emotionContributions count];t++)
	level=level+[[emotionContributions objectAtIndex:t]processContribution];

for(t=0;t<[driveContributions count];t++)
	level=level+[[driveContributions objectAtIndex:t]processContribution];

for(t=0;t<[perceptContributions count];t++)
	level=level+[[perceptContributions objectAtIndex:t]processContribution];
	
// calculate frustration
// own task frustrations	
// check frustrations if active
if(isActive)
	{
	taskFrustration=0;
	for(t=0;t<[behaviourTasks count];t++)
		taskFrustration=taskFrustration+[[behaviourTasks objectAtIndex:t]taskFrustration];

	// plus frustrations of SG 	
	for(t=0;t<[behaviourGroup count];t++)
		taskFrustration=taskFrustration+[[behaviourGroup objectAtIndex:t]frustration];	

	// and minus the frustration
	frustration=taskFrustration;
	}
if(numberTaskRequests>1) frustration=frustration/numberTaskRequests;

if(frustration>giveUpFrustrationLevel) 
	{
	frustDec=(frustration-giveUpFrustrationLevel);
	level=level-frustDec;
	}
	
//printf("BG frustration %s=%f giveUp=%f activation=%f persist=%f \n",[behaveName cString],frustration,giveUpFrustrationLevel,activationLevel,currentPersistance);	

if(!isActive && frustration>0.0) 
	{
	frustration=frustration-0.25;
	if(frustration<0) frustration=0;
	}
	
//if(isActive) if([self allGoalsReached]) level=0;
	
activationLevel=level;
[theDataGraph addObject:[NSNumber numberWithFloat:activationLevel]];
}
// ******************************************************************************************
-(void)			doStart
{
[theDataGraph removeAllObjects];
currentBehaviourGroupIndex=-1;
isActive=NO;
activationLevel=0;
frustration=0;
}

// ******************************************************************************************
-(void)			setSubAlarms:(float)level
{
int t;

alarmLevelGain=level;
for(t=0;t<[behaviourGroup count];t++)
	{
	[[behaviourGroup objectAtIndex:t] setSubAlarms:alarmLevelGain];
	}
	
//printf("set subalarms %f\n",level);	
}
// ******************************************************************************************
-(void)			setTaskManager:(id)tm			{   taskManager=tm;															}
-(NSString*)	behaveName						{   return behaveName;														}
-(float)		activationLevel					{   return activationLevel;													}
-(void)			setFrustrationGain:(float)g		{   frustrationGain=g;														}
-(void)			setFrustrationLevel:(float)l	{   frustrationLevel=l;	giveUpFrustrationLevel=frustrationLevel*6.0;		}
-(void)			setPersistMultiple:(float)v		{   persistMultiple=v;														}
-(void)			setPersistLevel:(float)v		{   defaultPersistance=v;													}
-(int)			numberSubBehaviours				{   return [behaviourGroup count];											}
-(int)			numberTasks						{   return [behaviourTasks count];											}
-(float)		currentPersistance				{   return currentPersistance;												}
-(float)		frustration						{	return frustration;														}
-(int)			numberDriveContributions		{   return [driveContributions count];										}
-(int)			numberEmotionContributions		{   return [emotionContributions count];									}
-(int)			numberPerceptContributions		{   return [perceptContributions count];									}
-(int)			numberReleaserContributions		{   return [releaserContributions count];									}
-(int)			numberReachGoalContributions	{   return [goalReachedContributions count];								}
-(BOOL)			isActive						{	return isActive;														}
-(void)			setAlarmLevel:(float)level		{	alarmLevelGain=level;													}
// ******************************************************************************************
-(void)			setIsActive:(BOOL)state			
{
int t;
if(!isActive && state==YES)
	{
	//printf("STARTED BEHAVIOUR (THREAD) FOR %s\n",[behaveName cString]);
	currentBehaviourGroupIndex=-1;
	[self resetBehaveGroup];
	currentPersistance=defaultPersistance;
	frustration=0;
	isActive=YES;		
	[taskManager addsTaskFromArray:behaviourTasks sender:self];
	
	
	
	// put this thread back - THIS ADD THREAD SHOULD BE HERE IF GONE
	[NSThread detachNewThreadSelector:@selector(backGroundThread) toTarget:self withObject:self];
	//NSBeep();
	}
	
isActive=state;
if(state==NO) 
	{
	currentPersistance=0;
	for(t=0;t<[behaviourGroup count];t++)
		[[behaviourGroup objectAtIndex:t] setIsActive:NO];
		
	if(frustration>0)
		{
		if(theEmotionCentre!=nil)
			[theEmotionCentre addStimulateToEmotion:@"Frustration" gain:frustration];
		else
			printf("WHERES THE EMOTION CENTRE pointer IN BEHAVE GROUP\n");
		}
		
	[taskManager removeTaskFromArray:behaviourTasks sender:self];
	//printf("STOPPED BEHAVIOUR %s frust=%f\n",[behaveName cString],frustration);
	//NSBeep();
	}
}

// ******************************************************************************************
-(void)			resetBehaveGroup
{
int t;

//printf("RESET BEHAVIOUR %s\n",[behaveName cString]);
frustration=0;
currentPersistance=0;
alarmLevelGain=0;

[behaviourTasks makeObjectsPerformSelector:@selector(resetWasSucess)];
[behaviourTasks makeObjectsPerformSelector:@selector(doReset)];	

[behaviourGroup makeObjectsPerformSelector:@selector(resetBehaveGroup)];
}
// ******************************************************************************************
-(void)			setMotivationCentre:(id)mc		
{   
theMotivationCentre=mc;		
theEmotionCentre=[theMotivationCentre emotionCentre];
theDriveCentre=[theMotivationCentre driveCentre];


printf("done set centres for behaviour group %s\n",[behaveName cString]);
}
// ******************************************************************************************
-(void)			setPerceptSystem:(id)pc
{
perceptCentre=pc;
perceptBlackboard=[perceptCentre perceptBlackboard];

printf("done set setPerceptSystem for behaviour group %s\n",[behaveName cString]);
}
// ******************************************************************************************
-(void)		addToGraph
{
/*
if(doneGraphAdd)	return;
int t;

for(t=0;t<[behaviourGroup count];t++)
	[[WXNSArrayDataPlotter sharedInstance]addArrayToPlot:
		[[behaviourGroup objectAtIndex:t]dataGraph]
		ydisp:370+20*(t+1) 
		yscale:17.0
		name:[[behaviourGroup objectAtIndex:t]behaveName]
		];
		
doneGraphAdd=YES;
*/
}
// ******************************************************************************************
-(void)				printInfo
{
int t;

printf("-----------------------------------\n");
printf("BEHAVIOUR GROUP %s\n",[behaveName cString]);
if([behaviourTasks count]>0)
	{
	printf("TASKS....\n");
	[behaviourTasks makeObjectsPerformSelector:@selector(printInfo)];
	}
if([behaviourGroup count]>0)
	{	
	printf("SUB BEHAVIOURS\n");
	[behaviourGroup  makeObjectsPerformSelector:@selector(printInfo)];
	}
	
printf("---------END OF GROUP-------\n");	
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
NSPoint point1,point2;
int t,ypos;
[displayString  textAt:pos.x y:pos.y text:behaveName color:[NSColor greenColor]];
if(isActive)	[displayString  textAt:pos.x+100 y:pos.y text:@"ACTIVE" color:[NSColor greenColor]];
else			[displayString  textAt:pos.x+100 y:pos.y text:@"unactive" color:[NSColor greenColor]];

[displayString  floatNumberAt:pos.x+150 y:pos.y value:activationLevel color:[NSColor greenColor]];

if(frustration>giveUpFrustrationLevel) [displayString  floatNumberAt:pos.x+200 y:pos.y value:frustration color:[NSColor redColor]];
else [displayString  floatNumberAt:pos.x+200 y:pos.y value:frustration color:[NSColor greenColor]];

[displayString  floatNumberAt:pos.x+240 y:pos.y value:currentPersistance color:[NSColor greenColor]];


ypos=pos.y+10;

/*
[displayString  textAt:pos.x+10 y:ypos text:@"CONTRIBUTIONS: (name, value, contribution)" color:[NSColor greenColor]];	ypos+=10;
if([self numberDriveContributions]>0)
	{
	for(t=0;t<[driveContributions count];t++)
		{
		[displayString  textAt:pos.x+20 y:ypos text:@"DC=" color:[NSColor greenColor]];
		[[driveContributions  objectAtIndex:t] showInfo:NSMakePoint(pos.x+40,ypos)];
		ypos=ypos+10;
		}
	}

if([self numberEmotionContributions]>0)
	{
	for(t=0;t<[emotionContributions count];t++)
		{
		[displayString  textAt:pos.x+20 y:ypos text:@"EC=" color:[NSColor greenColor]];
		[[emotionContributions  objectAtIndex:t] showInfo:NSMakePoint(pos.x+40,ypos)];
		ypos=ypos+10;
		}
	}
	
if([self numberPerceptContributions]>0)
	{
	for(t=0;t<[perceptContributions count];t++)
		{
		[displayString  textAt:pos.x+20 y:ypos text:@"PC=" color:[NSColor greenColor]];
		[[perceptContributions  objectAtIndex:t] showInfo:NSMakePoint(pos.x+40,ypos)];
		ypos=ypos+10;
		}
	}	
	

if([self numberTasks]>0)
	{
	[displayString  textAt:pos.x+10 y:ypos text:@"TASKS:" color:[NSColor greenColor]];	ypos+=10;
	for(t=0;t<[behaviourTasks count];t++)
		{
		[[behaviourTasks  objectAtIndex:t] showInfo:NSMakePoint(pos.x+20,ypos)];
		ypos=ypos+10;
		}
	}

*/
if([self numberSubBehaviours]>0)
	{
	point1=NSMakePoint(pos.x+6,ypos+6);
	NSRectFill(NSMakeRect(pos.x+4,ypos+3,4,4));
	[displayString  textAt:pos.x+10 y:ypos text:@"SUBGROUPS:" color:[NSColor greenColor]];	
	[displayString  textAt:pos.x+150+30 y:ypos text:@"level" color:[NSColor greenColor]];	
	[displayString  textAt:pos.x+200+30 y:ypos text:@"frust" color:[NSColor greenColor]];	
	[displayString  textAt:pos.x+240+30 y:ypos text:@"persist" color:[NSColor greenColor]];	
	
	ypos+=10;
	for(t=0;t<[behaviourGroup count];t++)
		{
		[[NSColor greenColor]set];
		point2=NSMakePoint(pos.x+6,ypos+6);
		
		[NSBezierPath strokeLineFromPoint:point1 toPoint:point2];
		[NSBezierPath strokeLineFromPoint:point2 toPoint:NSMakePoint(pos.x+26,ypos+6)];
		
		[[behaviourGroup  objectAtIndex:t] showInfo:NSMakePoint(pos.x+30,ypos)];
		ypos=ypos+10;
		ypos=ypos+([[behaviourGroup  objectAtIndex:t] numberSubBehaviours]*30);
		//ypos=ypos+([[behaviourGroup  objectAtIndex:t] numberTasks]*10)+10;
		//ypos=ypos+20;
		//ypos=ypos+([[behaviourGroup  objectAtIndex:t] numberDriveContributions]*10);
		//ypos=ypos+([[behaviourGroup  objectAtIndex:t] numberEmotionContributions]*10);
		//ypos=ypos+([[behaviourGroup  objectAtIndex:t] numberPerceptContributions]*10);
		//ypos=ypos+([[behaviourGroup  objectAtIndex:t] numberReleaserContributions]*10);
		//ypos=ypos+([[behaviourGroup  objectAtIndex:t] numberReachGoalContributions]*10);
		//ypos=ypos+30;
		}
	}

}
// ******************************************************************************************

@end
