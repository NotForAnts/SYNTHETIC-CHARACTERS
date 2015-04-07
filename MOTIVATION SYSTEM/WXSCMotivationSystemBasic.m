// ******************************************************************************************
//  WXSCMotivationSystemBasic
//  Created by Paul Webb on Tue Jan 10 2006.
// ******************************************************************************************

#import "WXSCMotivationSystemBasic.h"

@implementation WXSCMotivationSystemBasic

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	//[self initEmotions];
	//[self initDrives];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[super dealloc];
}
// ******************************************************************************************
-(void)		initDriveManager
{
driveManager=[[WXSCMotivationDriveManager alloc]init];
}
// ******************************************************************************************
-(void)		initEmotionManager
{
printf("initEmotionManager\n");
emotionManager=[[WXSCMotivationEmotionCentre alloc]init];
}
// ******************************************************************************************
-(id)		emotionCentre		{   return  emotionManager;		}
-(id)		driveCentre			{   return  driveManager;		}
// ******************************************************************************************
-(void)		addReleaseDrive:(id)newDrive
{
[driveManager addDrive:newDrive];   
[newDrive release];
}
// ******************************************************************************************
-(void)		addReleaseEmotion:(id)newEmotion
{
[emotionManager addEmotion:newEmotion];   
[newEmotion release];
}
// ******************************************************************************************
-(void)		doStart
{
[emotionManager doStart];
[driveManager doStart];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
[emotionManager doAllLoopUpdate:time];
[driveManager doAllLoopUpdate:time];
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString  textAt:pos.x y:pos.y text:@"MOTIVATION SYSTEM" color:[NSColor greenColor]];
[driveManager showInfo:NSMakePoint(pos.x,pos.y+20)];

pos.y=pos.y+60+[driveManager numberDrives]*10;
[emotionManager showInfo:NSMakePoint(pos.x,pos.y)];
}
// ******************************************************************************************
// this is some test stuff from earlier on
// still not sure where to initialise drives and emotions
// ******************************************************************************************
-(void)		initEmotions
{
newEmotion=[[WXSCMotivationEmotionBasic alloc]initEmotion:@"Happy" index:0];
[emotionManager addEmotion:newEmotion];   [newEmotion release];

newEmotion=[[WXSCMotivationEmotionBasic alloc]initEmotion:@"Tired" index:1];
[newEmotion setEmotionProcessGain:0.052];
[emotionManager addEmotion:newEmotion];   [newEmotion release];

newEmotion=[[WXSCMotivationEmotionBasic alloc]initEmotion:@"Fear" index:2];
[emotionManager addEmotion:newEmotion];   [newEmotion release];

newEmotion=[[WXSCMotivationEmotionBasic alloc]initEmotion:@"Frustration" index:3];
[emotionManager addEmotion:newEmotion];   [newEmotion release];

newEmotion=[[WXSCMotivationEmotionBasic alloc]initEmotion:@"Boredom" index:4];
[emotionManager addEmotion:newEmotion];   [newEmotion release];

newEmotion=[[WXSCMotivationEmotionBasic alloc]initEmotion:@"Sorrow" index:5];
[emotionManager addEmotion:newEmotion];   [newEmotion release];

newEmotion=[[WXSCMotivationEmotionBasic alloc]initEmotion:@"Interest" index:6];
[emotionManager addEmotion:newEmotion];   [newEmotion release];
}
// ******************************************************************************************
-(void)		initDrives
{
newDrive=[[WXSCMotivationDriveBasic alloc]initDrive:@"StimulationDrive" rate:0.1 index:0 max:1.0];
[driveManager addDrive:newDrive];   [newDrive release];

newDrive=[[WXSCMotivationDriveBasic alloc]initDrive:@"FatigueDrive" rate:0.02 index:1 max:1.0];
[driveManager addDrive:newDrive];   [newDrive release];
}
// ******************************************************************************************

@end
