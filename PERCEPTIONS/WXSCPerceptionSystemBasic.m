// ******************************************************************************************
//  WXSCPerceptionSystemBasic
//  Created by Paul Webb on Wed Jan 11 2006.
// ******************************************************************************************

#import "WXSCPerceptionSystemBasic.h"


@implementation WXSCPerceptionSystemBasic

// ******************************************************************************************
-(id)		init
{
if(self=[super init])
	{
	perceptBlackboard=[[WXSCPerceptionBlackboard alloc]init];
	sensorArray=[[NSMutableArray alloc]init];
	
	//[self makeSensorArray];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[sensorArray release];
[perceptBlackboard release];
[super dealloc];
}
// ******************************************************************************************
-(id)		perceptBlackboard		{   return perceptBlackboard;   }
// ******************************************************************************************
-(void)		makeSensorArray
{
return;
WXSCPerceptionSensorBasic   *sensor;

sensor=[[WXSCPerceptionSensorBasic alloc]init];
[sensor setName:@"Sensor1"];
[sensor setSensorValue:[[WXSCPerceptFloat alloc]init]];
[sensor setSensorObject:[[WXSCTestSensorOne alloc]init]];
[sensor setSelector:@selector(getSensorValue)];

[sensorArray addObject:sensor];
[sensor release];

sensor=[[WXSCPerceptionSensorBasic alloc]init];
[sensor setName:@"Sensor2"];
[sensor setSensorValue:[[WXSCPerceptFloat alloc]init]];
[sensor setSensorObject:[[WXSCTestSensorOne alloc]init]];
[sensor setSelector:@selector(getSensorValue)];

[sensorArray addObject:sensor];
[sensor release];

}
// ******************************************************************************************
-(void)		addSensor:(id)aSensor
{
[aSensor setBlackboard:perceptBlackboard];
[sensorArray addObject:aSensor];
}
// ******************************************************************************************
-(void)		doStart
{
[sensorArray makeObjectsPerformSelector:@selector(doStart)];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
int t,size=[sensorArray count];
for(t=0;t<size;t++)
	[[sensorArray objectAtIndex:t]doAllLoopUpdate:time];

[perceptBlackboard doAllLoopUpdate:time];
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString  textAt:pos.x y:pos.y text:@"PERCEPTION SYSTEM" color:[NSColor yellowColor]];
[perceptBlackboard showInfo:NSMakePoint(pos.x,pos.y+12)];
}
// ******************************************************************************************
@end
