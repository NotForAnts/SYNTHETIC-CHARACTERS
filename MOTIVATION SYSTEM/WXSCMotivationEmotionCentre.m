// ******************************************************************************************
//  WXSCMotivationEmotionCentre
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************
//
// this needs expanding so that it goes
//
// HighLevelPerception--->Affective Assessment--->Emotion Elicators--->Emotion Arbitration
//
//
//
//
//
// ******************************************************************************************

#import "WXSCMotivationEmotionCentre.h"


@implementation WXSCMotivationEmotionCentre
// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	theTimer=[[WXPoller alloc]init];
	emotionStates=[[NSMutableArray alloc]init];
	currentEmotionName=[[NSMutableString alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[emotionStates release];
[super dealloc];
}
// ******************************************************************************************
-(void)		addEmotion:(id)emotion		
{   
[emotionStates addObject:emotion];		
numberEmotions=[emotionStates count];
}
// ******************************************************************************************
-(id)		getEmotionObjectNamed:(NSString*)name
{
int t;
for(t=0;t<[emotionStates count];t++)
	if([[[emotionStates objectAtIndex:t]emotionName]isEqualToString:name])  
		return [emotionStates objectAtIndex:t];
return nil;
}
// ******************************************************************************************
-(void)		addStimulateToEmotion:(NSString*)name gain:(float)gain
{
id object=[self getEmotionObjectNamed:name];
if(object!=nil) 
	[object stimulateEmotion:gain];
else
	printf("***error - could not find emotion %s\n",[name cString]);
}
// ******************************************************************************************
-(void)		postGoalSucess:(float)reward
{
printf("postGoalSucess %f\n",reward);
//[joy doStimulate:reward];
//[frustration doStimulate:-reward];
//[anger doStimulate:-reward/1.5];
}
// ******************************************************************************************
-(void)		postGoalFailure:(float)penalty
{
printf("postGoalFailure %f\n",penalty);
//[frustration doStimulate:penalty];
//[anger doStimulate:penalty/1.5];
}
// ******************************************************************************************
-(void)		doStart
{
currentEmotionObject=nil;
[emotionStates makeObjectsPerformSelector:@selector(doStart)];
[theTimer  initialiseToNow];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
if(![theTimer checkUpdateWithIncrement:1.0])   return;

int t,index=-1;
float cv,high=0.0;
float   minLevel=0.1;		// 0.3
   
[emotionStates makeObjectsPerformSelector:@selector(processEmotion)];


currentEmotionObject=nil;
for(t=0;t<numberEmotions;t++)
	{
	cv=[[emotionStates objectAtIndex:t]emotionLevel];
	if(cv>=high && cv>=minLevel) 
		{   
		index=t; 
		high=cv;   
		currentEmotionObject=[emotionStates objectAtIndex:t];
		}
	}
	
if(index>=0)
	{
	[currentEmotionName setString:[currentEmotionObject emotionName]];
	}
	
	
if(lastEmotionIndex!=index) 
	[[NSNotificationCenter defaultCenter]   postNotificationName:@"EmotionState" object:currentEmotionObject];	
		
lastEmotionIndex=index;	
}
// ******************************************************************************************
-(id)		currentEmotionObject		{   return currentEmotionObject;	}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
int t;
[displayString  textAt:pos.x y:pos.y text:@"EMOTION SYSTEM" color:[NSColor greenColor]];
for(t=0;t<[emotionStates count];t++)
	[[emotionStates objectAtIndex:t] showInfo:NSMakePoint(pos.x,12+pos.y+t*10)];
}
// ******************************************************************************************

@end
