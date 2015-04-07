// ******************************************************************************************
//  WXSCPerceptionSensorBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCPerceptionSensorBasic.h"

// ******************************************************************************************

@implementation WXSCPerceptionSensorBasic
// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	perceptName=[[NSMutableString alloc]init];
	perceptBlackboard=nil;
	
	sensorObject=nil;
	perceptionObject=[[WXSCPerceptionObject alloc]init];
	theTimer=[[WXPoller alloc]init];
	rate=2.0;
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[super dealloc];
}
// ******************************************************************************************
-(void) setName:(NSString*)name		
{   
[perceptName setString:name];   
[perceptionObject setPerceptionName:name];
}
// ******************************************************************************************
-(void) setSensorObject:(id)so		{	sensorObject=so;				}
-(void) setSelector:(SEL)sel		{   selector=sel;					}
-(void) setSensorValue:(id)sv		{   sensorValue=sv;					}
-(void) setBlackboard:(id)bb		{   perceptBlackboard=bb;			}
// ******************************************************************************************
-(void)		doStart
{
[theTimer  initialiseToNow];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
if(![theTimer checkUpdateWithIncrement:rate])   return;


[sensorValue setValue:[sensorObject performSelector:selector]];

[perceptionObject setValueObject:sensorValue];
[perceptionObject setPerceptStrength:1.0];

[perceptBlackboard postPerception:perceptName value:perceptionObject];

//printf("********** ---> update sensor %s = %f\n",[perceptName cString],[sensorValue floatValue]);
}
// ******************************************************************************************

@end
