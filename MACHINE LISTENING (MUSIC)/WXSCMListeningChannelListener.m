// ******************************************************************************************
//  WXSCMListeningChannelListener
//  Created by Paul Webb on Tue Jun 27 2006.
// ******************************************************************************************

#import "WXSCMListeningChannelListener.h"


@implementation WXSCMListeningChannelListener

// ******************************************************************************************
// THIS IS FOR A SINGLE CHANNEL
// see WXSCMListeningChannelListenSubCentre
// which has 16 of these
//
// ******************************************************************************************
-(id)		init
{
if(self=[super init])
	{
	segmentConsonance=[[WXMidiListenerIntervalsConsonanceKompact alloc]init];
	segmentConsonanceTwo=[[WXMidiListenerIntervalsConsonantClassify alloc]init];	
	
	chordCadenceSpotter=[[WXMidiListenerTonalCadenceSpotter alloc]initWithChannel:0];
	stepSizeStats=[[WXMidiListenerMelodicStepSizeStats alloc]init];
	channelActive=[[WXMidiListenerChannelActiveStats alloc]init];
	
	[midiListenObjects addObject:segmentConsonance];
	[midiListenObjects addObject:segmentConsonanceTwo];
	[midiListenObjects addObject:chordCadenceSpotter];
	[midiListenObjects addObject:stepSizeStats];
	[midiListenObjects addObject:channelActive];
	}
return self;
}
// ******************************************************************************************
-(void)		dealloc
{
[segmentConsonance release];
[segmentConsonanceTwo release];
[chordCadenceSpotter release];
[stepSizeStats release];
[channelActive release];

[super dealloc];
}
// ******************************************************************************************
-(void)		doStart
{
[segmentConsonance doStart];
[segmentConsonanceTwo doStart];
[chordCadenceSpotter doStart];
[stepSizeStats doStart];
[channelActive doStart];
}
// ******************************************************************************************
-(void)		doStop
{
[segmentConsonance doStop];
[segmentConsonanceTwo doStop];
[chordCadenceSpotter doStop];
[stepSizeStats doStart];
[channelActive doStop];
}
// ******************************************************************************************
-(void)		setCurrentKeyAndMode:(short)key mode:(short)mode
{
[chordCadenceSpotter setCurrentKeyAndMode:key mode:mode];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
[stepSizeStats doAllLoopUpdate:time];
[channelActive doAllLoopUpdate:time]; 
}
// ******************************************************************************************
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint
{
if(type==typeKeyOn)
	{
	[chordCadenceSpotter handleMidiInput:typeKeyOn data1:0 data2:data2 data3:data3 time:timePoint];
	[stepSizeStats handleMidiInput:typeKeyOn data1:0 data2:data2 data3:data3 time:timePoint]; 
	}
	
[channelActive handleMidiInput:type data1:0 data2:data2 data3:data3 time:timePoint];	
}
// ******************************************************************************************
-(void)		handleChord:(WXMidiEventChord*)aChord channel:(int)channel time:(long)timePoint
{
}
// ******************************************************************************************
-(void)		handleEventList:(WXMidiEventNoteList*)eventList channel:(int)channel time:(long)timePoint
{
//printf("HERE NEW EVENT LIST %d chan=%d\n",[eventList getNumberEvents],channel);

[segmentConsonance classifyEventList:eventList];
[segmentConsonanceTwo classifyEventList:eventList]; 
}
// ******************************************************************************************


// ******************************************************************************************

@end
