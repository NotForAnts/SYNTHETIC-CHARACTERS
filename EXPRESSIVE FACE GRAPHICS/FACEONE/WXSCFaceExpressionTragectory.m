// ******************************************************************************************
//  WXSCFaceExpressionTragectory
//  Created by Paul Webb on Wed Aug 24 2005.
// ******************************************************************************************

#import "WXSCFaceExpressionTragectory.h"


@implementation WXSCFaceExpressionTragectory

// ******************************************************************************************
-(id)		init
{
if(self=[super init])
	{
	currentValue=0.0;
	value1=value2=0.0;
	currentStep=numberSteps=0;
	}
return self;
}

// ******************************************************************************************
-(id)		initWithValue:(float)v
{
if(self=[super init])
	{
	currentValue=v;
	value1=value2=v;
	currentStep=numberSteps=0;
	}
return self;
}
// ******************************************************************************************
-(void)		setMove:(float)v1 v2:(float)v2 steps:(int)steps
{
currentValue=v1;
value1=v1;
value2=v2;
numberSteps=currentStep=steps;
}

// ******************************************************************************************
-(void)		setAimPause:(float)v2 steps:(int)steps pause:(int)pause
{
if(WXUPercentChance(pause))
	[self setAimTo:currentValue steps:steps];
else
	[self setAimTo:v2 steps:steps];
}
// ******************************************************************************************
-(void)		setAimTo:(float)v2 steps:(int)steps
{
value1=currentValue;
value2=v2;
numberSteps=currentStep=steps;
}
// ******************************************************************************************
-(BOOL)		isDone		{   return currentStep==0;	}
// ******************************************************************************************
-(BOOL)	doUpdate:(float*)param
{
if(currentStep>0)
	{
	currentValue=WXUNormalise(currentStep,numberSteps,1,value1,value2);
	if(numberSteps==1) currentValue=value2;	
	currentStep--;
	*param=currentValue;
	}

if(currentStep==0)  return YES;
return NO;
}
// ******************************************************************************************

@end
