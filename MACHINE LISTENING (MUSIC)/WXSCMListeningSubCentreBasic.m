// ******************************************************************************************
//  WXSCMListeningSubCentreBasic
//  Created by Paul Webb on Mon Jun 26 2006.
// ******************************************************************************************

#import "WXSCMListeningSubCentreBasic.h"


@implementation WXSCMListeningSubCentreBasic
// ******************************************************************************************


// ******************************************************************************************
-(id)		init
{
if(self=[super init])
	{
	midiListenObjects=[[NSMutableArray alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void)		dealloc
{
[midiListenObjects release];
[super dealloc];
}
// ******************************************************************************************
-(void)		setListenDictionary:(id)ld
{
listenProperties=ld;
[midiListenObjects makeObjectsPerformSelector:@selector(setListenDictionary:) withObject:ld];
}
// ******************************************************************************************
-(void)		setListenNotificationCentre:(id)lnc
{
listenNotifications=lnc;
[midiListenObjects makeObjectsPerformSelector:@selector(setListenNotificationCentre:) withObject:lnc];
}
// ******************************************************************************************
-(void)		doStart
{
}
// ******************************************************************************************
-(void)		doStop
{
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
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
-(void)		handleCCEvent:(WXCCEvent*)anEvent channel:(int)channel time:(long)timePoint
{
}
// ******************************************************************************************
-(void)		handleChord:(WXMidiEventChord*)aChord channel:(int)channel time:(long)timePoint
{
}
// ******************************************************************************************
-(void)		handleEventList:(WXMidiEventNoteList*)eventList channel:(int)channel time:(long)timePoint
{
}
// ******************************************************************************************

@end
