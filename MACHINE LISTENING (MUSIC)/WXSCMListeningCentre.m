// ******************************************************************************************
//  WXSCMListeningCentre
//  Created by Paul Webb on Mon Jun 12 2006.
// ******************************************************************************************

#import "WXSCMListeningCentre.h"


@implementation WXSCMListeningCentre


// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	theMidiPlayer=[WXCoreMidiPlayer	sharedInstance];
	theMidiRouter=[[WXSCMListeningMidiRouter alloc]init];
	[theMidiRouter setMidiPlayer:theMidiPlayer];
	
	[theMidiRouter addDestination:self];

	generateTestMidi=[[WXSCMListeningGenerateTestMidi alloc]init];
	[generateTestMidi setMidiRouter:theMidiRouter];

	listenProperties=[[WXMidiListenerResultStore alloc]init];
	listenNotifications=[[WXMidiListenerNotificationCentre alloc]init];
	
	// parsers
	chordSpotter=[[WXMidiListenerChordSpotter alloc]init];
	[chordSpotter setSignalDestination:self];
	
	segmentGrabber=[[WXMidiListenerMultiChannelSegmentGrabber alloc]init];
	[segmentGrabber setSignalDestination:self];
	
	
	storageCentre=[[WXMidiListenerMusicStorage alloc]init];

	// the sub listener componants
	beatTracker=[[WXSCMListeningBeatTrackCentre alloc]init];
	scaleKeyFinder=[[WXSCMListeningScaleKeyCentre alloc]init];
	textureClassifications=[[WXSCMListeningTextureClassifications alloc]init];
	chordListenCentre=[[WXSCMListeningChordProgListenCentre alloc]init];
	
	channelListenSubCentre=[[WXSCMListeningChannelListenSubCentre alloc]init];
	[channelListenSubCentre setChannelsActive:@"--x"];
	
	drumListenCentre=[[WXSCMListeningDrumListenCentre alloc]init];
	sysExListenCentre=[[WXSCMListeningSysExListener alloc]init];
	
	// pass the centres
	[beatTracker setListenDictionary:listenProperties];
	[beatTracker setListenNotificationCentre:listenNotifications];
	
	[scaleKeyFinder setListenDictionary:listenProperties];
	[scaleKeyFinder setListenNotificationCentre:listenNotifications];	
	
	[textureClassifications setListenDictionary:listenProperties];
	[textureClassifications setListenNotificationCentre:listenNotifications];	

	[chordListenCentre setListenDictionary:listenProperties];
	[chordListenCentre setListenNotificationCentre:listenNotifications];	

	[channelListenSubCentre setListenDictionary:listenProperties];
	[channelListenSubCentre setListenNotificationCentre:listenNotifications];	

	[drumListenCentre setListenDictionary:listenProperties];
	[drumListenCentre setListenNotificationCentre:listenNotifications];	
		
	[sysExListenCentre setListenDictionary:listenProperties];
	[sysExListenCentre setListenNotificationCentre:listenNotifications];		
	
	[storageCentre setListenDictionary:listenProperties];
	[storageCentre setListenNotificationCentre:listenNotifications];	
											
	
	// which ones to use
	useChordCentre=NO;
	useChannelCentre=NO;
	useDrumCentre=NO;
	useTextureCentre=NO;
	useBeatTrackCentre=NO;
	useScaleKeyCentre=YES;
	useSysExCentre=YES;
	}

return self;
}
// ******************************************************************************************
-(void) dealloc
{
[beatTracker release];
[scaleKeyFinder release];
[textureClassifications release];
[chordListenCentre release];
[channelListenSubCentre release];
[drumListenCentre release];
[sysExListenCentre release];

[chordSpotter release];
[segmentGrabber release];

[theMidiRouter release];
[generateTestMidi release];

[super dealloc];
}
// ******************************************************************************************
-(void)		addDestinationToRouter:(id)anObject
{
[theMidiRouter addDestination:anObject];
}
// ******************************************************************************************
-(void)		addToBeatTrack:(id)anObject
{
[beatTracker addToBeatTrack:anObject];
}
// ******************************************************************************************
-(void)		setMachineListenView:(id)view		
{		
listeningView=view;			

if(useBeatTrackCentre)  [listeningView addListenThing:beatTracker];
if(useScaleKeyCentre)   [listeningView addListenThing:scaleKeyFinder];
if(useTextureCentre)	[listeningView addListenThing:textureClassifications];
}
// ******************************************************************************************
-(void)		doStart
{
updateInfoCounter=0;

[NSThread detachNewThreadSelector:@selector(generateTestMidiThread) toTarget:self withObject:self];

if(useBeatTrackCentre)		[beatTracker doStart];
if(useScaleKeyCentre)		[scaleKeyFinder doStart];
[textureClassifications doStart];
[chordListenCentre  doStart];
[channelListenSubCentre doStart];
[drumListenCentre doStart];
[sysExListenCentre doStart];

[chordSpotter doStart];
[segmentGrabber doStart];
}

// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
[chordSpotter doAllLoopUpdate:time];

if(useTextureCentre)	[textureClassifications doAllLoopUpdate:time];
if(useChordCentre)		[chordListenCentre doAllLoopUpdate:time];
if(useChannelCentre)	[channelListenSubCentre doAllLoopUpdate:time];
if(useDrumCentre)		[drumListenCentre doAllLoopUpdate:time]; 
if(useSysExCentre)		[sysExListenCentre doAllLoopUpdate:time];  

[self doUpdateInformationView];
}
// ******************************************************************************************
-(void)		doUpdateInformationView
{
updateInfoCounter++;
if(updateInfoCounter % 50!=0)   return;

[listeningView 	setListenDictionary:listenProperties];
[listeningView setNeedsDisplay:YES];
}
// ******************************************************************************************
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint
{
[chordSpotter handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
[segmentGrabber handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];

if(useBeatTrackCentre)  [beatTracker handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
if(useScaleKeyCentre)   [scaleKeyFinder handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
if(useTextureCentre)	[textureClassifications handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
if(useChannelCentre)	[channelListenSubCentre handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
if(useChordCentre)		[chordListenCentre handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
if(useDrumCentre)		[drumListenCentre handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint]; 

//.....................
// some agent sharing of theories
currentKey=[scaleKeyFinder currentKey];
currentMode=[scaleKeyFinder currentMode];
if(useChordCentre)		[chordListenCentre setCurrentKeyAndMode:currentKey mode:currentMode];
if(useChannelCentre)	[channelListenSubCentre setCurrentKeyAndMode:currentKey mode:currentMode];
}
// ******************************************************************************************
-(void)		handleCCEvent:(WXCCEvent*)anEvent channel:(int)channel time:(long)timePoint
{
if(useSysExCentre)		[sysExListenCentre handleCCEvent:anEvent channel:channel time:timePoint];  
}
// ******************************************************************************************
-(void)		handleCCInput:(short)channel type:(short)type value:(short)value time:(long)timePoint
{
if(useSysExCentre)		[sysExListenCentre handleCCInput:channel type:type value:value time:timePoint];  
}
// ******************************************************************************************
-(void)		handleChord:(WXMidiEventChord*)aChord channel:(int)channel time:(long)timePoint
{
if(useChordCentre)		[chordListenCentre handleChord:aChord channel:channel time:timePoint];
if(useChannelCentre)	[channelListenSubCentre handleChord:aChord channel:channel time:timePoint];
}
// ******************************************************************************************
-(void)		handleEventList:(WXMidiEventNoteList*)eventList channel:(int)channel time:(long)timePoint
{
if(useChannelCentre)	[channelListenSubCentre handleEventList:eventList channel:channel time:timePoint];
}
// ******************************************************************************************


// ******************************************************************************************
// GENERATE SOME TEST MIDI DATA
// ******************************************************************************************
-(void)		generateTestMidiThread
{
NSAutoreleasePool *pool2;
pool2 = [[NSAutoreleasePool alloc] init];
[NSThread setThreadPriority:0.6];

BOOL	isMotifPlayActive=YES;

[generateTestMidi doReset];

do{

	[generateTestMidi doGenerate];
	
	[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.002]];
	}while(isMotifPlayActive);


[theMidiPlayer shutUp];
[pool2 release];	
}
// ******************************************************************************************

@end
