// ******************************************************************************************
//  WXSCMidiGenMusicGenerateReactive
//  Created by Paul Webb on Mon Jun 19 2006.
// ******************************************************************************************

#import "WXSCMidiGenMusicGenerateReactive.h"


@implementation WXSCMidiGenMusicGenerateReactive

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	theMidiPlayer=[WXCoreMidiPlayer	sharedInstance];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[super dealloc];
}
// ******************************************************************************************
-(void)		doStart
{
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
}
// ******************************************************************************************
-(void)		handleBeatTrackSignal:(long)timepoint rate:(int)rate
{
//[theMidiPlayer midiNote:1 pitch:kC3 volume:127 duration:rate];


//printf("LOCK %d %d\n",timepoint,rate);
}
// ******************************************************************************************
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint
{


}
// ******************************************************************************************
-(void)		handleCCInput:(short)channel type:(short)type value:(short)value time:(long)timePoint
{

}
// ******************************************************************************************


@end
