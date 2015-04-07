// ******************************************************************************************
//  WXSCMidiGenMusicGenerateCentre
//  Created by Paul Webb on Mon Jun 19 2006.
// ******************************************************************************************

#import "WXSCMidiGenMusicGenerateCentre.h"


@implementation WXSCMidiGenMusicGenerateCentre
// ******************************************************************************************


// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	theMidiPlayer=[WXCoreMidiPlayer	sharedInstance];
	
	
	reactiveSubCentre=[[WXSCMidiGenMusicGenerateReactive alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[reactiveSubCentre release];

[super dealloc];
}
// ******************************************************************************************
-(void)		doStart
{
[reactiveSubCentre doStart];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
[reactiveSubCentre doAllLoopUpdate:time];
}
// ******************************************************************************************
-(void)		handleBeatTrackSignal:(long)timepoint rate:(int)rate
{
[reactiveSubCentre handleBeatTrackSignal:timepoint rate:rate];
}
// ******************************************************************************************
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint
{
[reactiveSubCentre handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
}
// ******************************************************************************************
-(void)		handleCCInput:(short)channel type:(short)type value:(short)value time:(long)timePoint
{
[reactiveSubCentre handleCCInput:channel type:type value:value time:timePoint];
}
// ******************************************************************************************

@end
