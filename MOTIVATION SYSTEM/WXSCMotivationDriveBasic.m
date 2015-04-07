// ******************************************************************************************
//  WXSCMotivationDriveBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCMotivationDriveBasic.h"


@implementation WXSCMotivationDriveBasic
// ******************************************************************************************
-(id)		initDrive:(NSString*)name rate:(float)rate index:(int)index max:(float)max
{
if(self=[super init])
	{
	driveIndex=index;
	driveName=[[NSMutableString alloc]init];
	[driveName setString:name];
	
	driveMin=-1.0;
	driveMax=max;
	driveLevel=0.0;
	driveRate=rate;
	
	theDataGraph=[[NSMutableArray alloc]init];
	
	[[WXNSArrayDataPlotter sharedInstance]addArrayToPlot:
		theDataGraph
		ydisp:[[WXNSArrayDataPlotter sharedInstance] numberPlots]*20
		yscale:9.0
		name:driveName];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[driveName release];
[super dealloc];
}
// ******************************************************************************************
-(void)		doStart
{
rateOfChange=0;
lastDriveLevel=0;
driveLevel=0;
[theDataGraph removeAllObjects];
}
// ******************************************************************************************
-(BOOL)			compareAsState:(id)state
{
return [state compareToFloat:driveLevel];
}
// ******************************************************************************************
// A drive will tend to increase in intensity unless it is satiated
// ******************************************************************************************
-(void)		processDrive
{
driveLevel=driveLevel+driveRate;
if(driveLevel>driveMax)  driveLevel=driveMax;

[theDataGraph addObject:[NSNumber numberWithFloat:driveLevel]];

//printf("drive %s=%f\n",[driveName cString],driveLevel);

[self driveToEmotionSignals];
[self postDriveState];
rateOfChange=driveLevel-lastDriveLevel;
lastDriveLevel=driveLevel;
}
// ******************************************************************************************
-(void)		stimulateDrive:(float)gain
{
driveLevel=driveLevel+gain;
if(driveLevel<-1.0) driveLevel=-1.0;

//printf("STIMULATE DRIVE %s = %f now=%f\n",[driveName cString],gain,driveLevel);
}
// ******************************************************************************************
-(void)		postDriveState
{
return;
NSMutableDictionary *signal=[[NSMutableDictionary alloc]init];

[signal setObject:[NSNumber numberWithFloat:driveLevel] forKey:@"level"];
[signal setObject:driveName forKey:@"driveName"];

[[NSNotificationCenter defaultCenter]   postNotificationName:@"driveSignal" object:signal];	

[signal release];
}
// ******************************************************************************************
-(void)		driveToEmotionSignals
{
}
// ******************************************************************************************
-(void)			setName:(NSString*)name		{   [driveName setString:name];		}
-(float)		driveLevel					{   return driveLevel;				}
-(float)		driveRateOfChange			{   return rateOfChange;			}
-(NSString*)	driveName					{   return driveName;				}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString  textAt:pos.x y:pos.y text:driveName color:[NSColor greenColor]];
[displayString floatNumberAt:pos.x+100 y:pos.y value:driveLevel color:[NSColor greenColor]];
}
// ******************************************************************************************

@end
