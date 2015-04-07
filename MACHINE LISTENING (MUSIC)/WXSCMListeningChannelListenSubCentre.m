// ******************************************************************************************
//  WXSCMListeningChannelListenSubCentre
//  Created by Paul Webb on Tue Jun 27 2006.
// ******************************************************************************************
//
//  see WXSCMListeningChannelListener ( which does stuff for each channel)
//
// this class is a container
//
// ******************************************************************************************

#import "WXSCMListeningChannelListenSubCentre.h"


@implementation WXSCMListeningChannelListenSubCentre

// ******************************************************************************************

// ******************************************************************************************
-(id)		init
{
if(self=[super init])
	{
	[self initStuff];
	}
return self;
}
// ******************************************************************************************
-(void)		dealloc
{
[super dealloc];
}
// ******************************************************************************************
-(void)		initStuff
{
int t;
for(t=0;t<16;t++)
	{
	channelActive[t]=NO;
	theListeners[t]=[[WXSCMListeningChannelListener alloc]init];
	
	[midiListenObjects addObject:theListeners[t]];
	}
	
channelActive[0]=YES;	
}
// ******************************************************************************************
-(void)		setChannelsActive:(NSString*)active
{
int t;
char c;
for(t=0;t<[active length] && t<16;t++)
	{
	channelActive[t]=NO;
	c=[active characterAtIndex:t];
	if(c=='x') channelActive[t]=YES;
	}
}
// ******************************************************************************************
-(void)		doStart
{
int t;
for(t=0;t<16;t++)
	[theListeners[t] doStart];
}
// ******************************************************************************************
-(void)		doStop
{
int t;
for(t=0;t<16;t++)
	[theListeners[t] doStop];
}
// ******************************************************************************************
-(void)		setCurrentKeyAndMode:(short)key mode:(short)mode
{
int t;
for(t=0;t<16;t++)
	[theListeners[t] setCurrentKeyAndMode:key mode:mode];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
int t;
for(t=0;t<16;t++)
	if(channelActive[t])
		[theListeners[t] doAllLoopUpdate:time];
}
// ******************************************************************************************
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint
{
if(!channelActive[data1])   return;
[theListeners[data1] handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint]; 
}
// ******************************************************************************************
-(void)		handleChord:(WXMidiEventChord*)aChord channel:(int)channel time:(long)timePoint
{
if(!channelActive[channel])   return;
[theListeners[channel] handleChord:aChord channel:channel time:timePoint];
}
// ******************************************************************************************
-(void)		handleEventList:(WXMidiEventNoteList*)eventList channel:(int)channel time:(long)timePoint
{
if(!channelActive[channel])   return;
[theListeners[channel] handleEventList:eventList channel:channel time:timePoint];
}
// ******************************************************************************************




// ******************************************************************************************

@end
