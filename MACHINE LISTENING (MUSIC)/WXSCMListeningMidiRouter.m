// ******************************************************************************************
//  WXSCMListeningMidiRouter
//  Created by Paul Webb on Tue Jun 13 2006.
// ******************************************************************************************

#import "WXSCMListeningMidiRouter.h"


@implementation WXSCMListeningMidiRouter
// ******************************************************************************************

-(id)		init
{
if(self=[super init])
	{
	theDestinations=[[NSMutableArray alloc]init];
	noteOffQueue=[[NSMutableArray alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void)		dealloc
{
[theDestinations release];

[super dealloc];
}
// ******************************************************************************************
-(void)		setMidiPlayer:(id)player
{
midiPlayer=player;
}
// ******************************************************************************************
-(void)		doNoteOffQueue
{
int		t,pos=0,pitch,volume,channel;
long	timePoint=[midiPlayer MidiGetTime];
WXMidiEventKeyOff		*testNote;

while(pos<[noteOffQueue count])
	{
	testNote=[noteOffQueue objectAtIndex:pos];
	if(timePoint>=[testNote getTimePoint])
		{
		channel=[testNote channel];
		pitch=[testNote pitch];
		volume=[testNote volume];
		[midiPlayer midiNoteOFF:channel pitch:pitch volume:volume];
		[noteOffQueue removeObjectAtIndex:pos];
		for(t=0;t<[theDestinations count];t++)
			[[theDestinations objectAtIndex:t] handleMidiInput:typeKeyOff data1:channel data2:pitch data3:volume time:timePoint];
		}
	else
		pos++;
	}
}
// ******************************************************************************************
-(void)		midiCC:(short)channel type:(short)type value:(short)value
{
long timePoint=[midiPlayer MidiGetTime];

[midiPlayer midiCC:channel type:type value:value];

int  t,size=[theDestinations count];
for(t=0;t<size;t++)
	[[theDestinations objectAtIndex:t] handleCCInput:channel type:type value:value time:timePoint];
}
// ******************************************************************************************
-(void)		midiNote:(short)_channel pitch:(short)pitch volume:(short)volume duration:(int)duration
{
long timePoint=[midiPlayer MidiGetTime];
[midiPlayer midiNoteON:_channel pitch:pitch volume:volume];

int  t,size=[theDestinations count];
for(t=0;t<size;t++)
	[[theDestinations objectAtIndex:t] handleMidiInput:typeKeyOn data1:_channel data2:pitch data3:volume time:timePoint];
	
	
noteOff=[[WXMidiEventKeyOff alloc]initKeyOffWithTime:_channel pitch:pitch volume:volume time:timePoint+duration];
[noteOffQueue addObject:noteOff];
[noteOff release];	
}
// ******************************************************************************************
-(void)		addDestination:(id)dest
{
[theDestinations addObject:dest];
}
// ******************************************************************************************

@end
