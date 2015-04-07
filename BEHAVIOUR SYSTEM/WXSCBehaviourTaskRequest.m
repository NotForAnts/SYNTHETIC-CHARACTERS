// ******************************************************************************************
//  WXSCBehaviourTaskRequest
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCBehaviourTaskRequest.h"


@implementation WXSCBehaviourTaskRequest

// ******************************************************************************************
-(id)		initTaskRequest:(NSString*)name
{
if(self=[super init])
	{
	taskName=name;
	[taskName retain];
	
	taskConditions=[[NSMutableArray alloc]init];
	sucessConditions=[[NSMutableArray alloc]init];
	
	successEmotionGain=[[NSMutableArray alloc]init];
	successEmotion=[[NSMutableArray alloc]init];
	
	failureEmotionGain=[[NSMutableArray alloc]init];
	failureEmotion=[[NSMutableArray alloc]init];
	
	
	theTimer=[[WXPoller alloc]init];
	theAction=nil;
	timeActive=0;
	actionConditionsMet=NO;
	isActive=NO;
	isSuccess=NO;
	wasSuccess=NO;
	taskFrustration=0;
	taskFrustrationIncrement=0.02;
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[successEmotion release];
[successEmotionGain release];
[taskConditions release];
[sucessConditions release];
[taskName release];
[super dealloc];
}
// ******************************************************************************************
-(void)		setTaskFrustrationIncrement:(float)f
{
taskFrustrationIncrement=f;
}
// ******************************************************************************************
-(void)		addSucessCondition:(id)object
{
[sucessConditions addObject:object];
[object setDriveCentre:theDriveCentre];
[object setEmotionCentre:theEmotionCentre];
}
// ******************************************************************************************
-(void)		addSucessConditionAndRelease:(id)object
{
[sucessConditions addObject:object];
[object setDriveCentre:theDriveCentre];
[object setEmotionCentre:theEmotionCentre];
[object release];
}
// ******************************************************************************************
-(void)		addCondition:(id)object
{
[taskConditions addObject:object];
[object setDriveCentre:theDriveCentre];
[object setEmotionCentre:theEmotionCentre];
}
// ******************************************************************************************
-(void)		addConditionAndRelease:(id)object
{
[taskConditions addObject:object];
[object setDriveCentre:theDriveCentre];
[object setEmotionCentre:theEmotionCentre];
[object release];
}
// ******************************************************************************************
-(void)		setAction:(id)object
{
theAction=object;
[theAction setActive:actionConditionsMet];
}
// ******************************************************************************************
-(void)		setActionManager:(id)am		{	theActionManager=am;										}
-(void)		setEmotionCentre:(id)ec		{  theEmotionCentre=ec;											}
-(NSString*) taskName					{   return taskName;											}
-(void)		makeActive					{   isActive=YES;												}
-(BOOL)		isSuccess					{   return isSuccess;											}
-(BOOL)		wasSucess					{   return wasSuccess;											}
-(void)		resetWasSucess				{   wasSuccess=NO;												}
-(int)		numberConditions			{   return [taskConditions count]+[sucessConditions count];		}
// ******************************************************************************************
-(float)	taskFrustration				
{  
if(!isActive && taskFrustration>0) taskFrustration*=0.995;
return taskFrustration;										
}
// ******************************************************************************************
-(void)		addSuccessEmotionGain:(NSString*)name gain:(float)gain
{
[successEmotion addObject:name];
[successEmotionGain addObject:[NSNumber numberWithFloat:gain]];
}
// ******************************************************************************************
-(void)		addFailureEmotionGain:(NSString*)name gain:(float)gain
{
[failureEmotion addObject:name];
[failureEmotionGain addObject:[NSNumber numberWithFloat:gain]];
}
// ******************************************************************************************
-(void)		makeInActive				
{   
isSuccess=NO;
isActive=NO;	
actionConditionsMet=NO;	
[taskConditions makeObjectsPerformSelector:@selector(doReset)];
[sucessConditions makeObjectsPerformSelector:@selector(doReset)];
if(theAction!=nil) [theActionManager removeAction:theAction];	
}
// ******************************************************************************************
-(void)		doReset
{
[theTimer initialiseToNow];
timeActive=0;
taskFrustration=0;
actionConditionsMet=NO;
isSuccess=NO;
isActive=NO;
[taskConditions makeObjectsPerformSelector:@selector(doReset)];
[sucessConditions makeObjectsPerformSelector:@selector(doReset)];

if(theAction!=nil) 
	[theActionManager removeAction:theAction];
}

// ******************************************************************************************
-(void)		doTaskCheckSucessConditionMet
{
// dont check if sucessfull until actions going
// but say things happen to change anyhow and things by chance happen to met sucess
if(!actionConditionsMet)	return; 

int t,size=[sucessConditions count];

if(size<1)  
	{
	//printf("task %s has no success conditions\n",[taskName cString]);
	return;
	}

//printf("check if task-(done)success conditions are met \n");
for(t=0;t<size;t++)
	if(![[sucessConditions objectAtIndex:t]conditionMet])  
		{
		// maybe not needed
		//[self doFailureEmotionSends];
		return;
		}
	
isSuccess=YES;	
wasSuccess=YES;
//printf("TASK %s WAS SUCCESFULL\n",[taskName cString]);

[self doSuccessEmotionSends];
		
}
// ******************************************************************************************
-(void)		doSuccessEmotionSends
{
int t;
for(t=0;t<[successEmotion count];t++)
	{
	[theEmotionCentre addStimulateToEmotion:
				[successEmotion objectAtIndex:t]
				gain:[[successEmotionGain objectAtIndex:t]floatValue]];
	
	}
}
// *****************************************************************************************
// this may not be needed as it stimulates the emotion when checking task frustration
// ******************************************************************************************
-(void)		doFailureEmotionSends
{
int t;
for(t=0;t<[failureEmotion count];t++)
	{
	[theEmotionCentre addStimulateToEmotion:
				[failureEmotion objectAtIndex:t]
				gain:[[failureEmotionGain objectAtIndex:t]floatValue]];
	
	}
}
// ******************************************************************************************
-(void)		doTaskIfConditionsMet
{
int t;
if(actionConditionsMet) return;
//printf("check conditions\n");

for(t=0;t<[taskConditions count];t++)
	if(![[taskConditions objectAtIndex:t]conditionMet])  return;

actionConditionsMet=YES;
if(theAction!=nil)  
	{
	[theActionManager addAction:theAction];
	}

//printf("DO ACTION CONDITION MET\n");


}
// ******************************************************************************************
-(void)		doTaskFrustration
{
if([sucessConditions count]<1)  
	{
	taskFrustration+=taskFrustrationIncrement;
	// but there always should be sucess conditions for task!!!
	// actually - maybe not - as in 30Birds not having success for flying
	
	//printf("frustraion %f\n",taskFrustration);
	
	[theEmotionCentre addStimulateToEmotion:@"Frustration" gain:taskFrustration/20.0];
	return;
	}
	
if(!actionConditionsMet)	return;
taskFrustration+=taskFrustrationIncrement;

[theEmotionCentre addStimulateToEmotion:@"Frustration" gain:taskFrustration/20.0];
}
// ******************************************************************************************
-(void)		updateTaskRequest
{
timeActive=[theTimer timeSincePassedSinceInitialised];
[self doTaskIfConditionsMet];
[self doTaskCheckSucessConditionMet];
[self doTaskFrustration];
}
// ******************************************************************************************
-(void)		printInfo
{
int t;

printf("TASK NAME =%s\n",[taskName cString]);

if([taskConditions count]==0) printf("no conditions\n");
if([sucessConditions count]==0) printf("no success conditions\n");

if(theAction!=nil)  [theAction printInfo]; else printf("No Action\n");

printf("------\n");
}


// ******************************************************************************************
-(void)		showAllInfo:(NSPoint)pos
{
int t;
float   ypos;
NSColor *color;
if(isActive) color=[NSColor blueColor]; else color=[NSColor grayColor];
if(actionConditionsMet)  color=[NSColor greenColor];
if(isSuccess)  color=[NSColor greenColor];
if(wasSuccess)  color=[NSColor purpleColor];

if(wasSuccess) [displayString textAt:pos.x-10 y:pos.y text:@"*" color:color];
[displayString textAt:pos.x y:pos.y text:taskName color:color];

[displayString timeDisplayAt:pos.x+140 y:pos.y value:timeActive*1000 color:color];
[displayString floatNumberAt:pos.x+100 y:pos.y value:taskFrustration color:color];


if(theAction!=nil)  
	[theAction showInfo:NSMakePoint(pos.x+180,pos.y)];

/*
ypos=pos.y+10;

for(t=0;t<[taskConditions count];t++)
	{
	[[taskConditions objectAtIndex:t] showAllInfo:NSMakePoint(pos.x+30,ypos)];	
	ypos+=10;
	}

for(t=0;t<[sucessConditions count];t++)
	{
	[[sucessConditions objectAtIndex:t] showAllInfo:NSMakePoint(pos.x+30,ypos)];	
	ypos+=10;
	}
	*/
}

// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
int t;
NSColor *color;
if(isActive) color=[NSColor blueColor]; else color=[NSColor grayColor];
if(actionConditionsMet)  color=[NSColor redColor];
if(isSuccess)  color=[NSColor greenColor];
if(wasSuccess)  color=[NSColor purpleColor];

if(wasSuccess) [displayString textAt:pos.x-10 y:pos.y text:@"*" color:color];
[displayString textAt:pos.x y:pos.y text:taskName color:color];

[displayString timeDisplayAt:pos.x+160 y:pos.y value:timeActive*1000 color:color];
[displayString floatNumberAt:pos.x+120 y:pos.y value:taskFrustration color:color];

if(theAction!=nil)  
	[theAction showInfo:NSMakePoint(pos.x+160,pos.y)];

for(t=0;t<[taskConditions count];t++)
	[[taskConditions objectAtIndex:t] showInfo:NSMakePoint(pos.x+220+t*50,pos.y)];
	
for(t=0;t<[sucessConditions count];t++)
	[[sucessConditions objectAtIndex:t] showInfo:NSMakePoint(pos.x+270+t*50,pos.y)];	
}
// ******************************************************************************************

@end
