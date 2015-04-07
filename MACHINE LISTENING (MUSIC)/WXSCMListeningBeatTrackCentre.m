// ******************************************************************************************
//  WXSCMListeningBeatTrackCentre
//  Created by Paul Webb on Mon Jun 12 2006.
// ******************************************************************************************

#import "WXSCMListeningBeatTrackCentre.h"


@implementation WXSCMListeningBeatTrackCentre

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	displayString=[[WXDisplayStrings alloc]init];
	singleDestinations=[[NSMutableArray alloc]init];
	
	isActive=NO;
	beatTrack1=[[WXMidiListenerDrumBeatTracker alloc]init];
	beatTrack2=[[WXMidiListenerBeatTracker alloc]init];
	
	[beatTrack1 setQuantise:1];
	[beatTrack1 setChannelWatch:kVoice10];
	
	[beatTrack2 setQuantise:10];
	
	theoryChangeWindow1=[[WXTimeWindowStore alloc]initWithTimeLengthAndName:10000 name:@"beat1"];
	theoryChangeWindow2=[[WXTimeWindowStore alloc]initWithTimeLengthAndName:10000 name:@"beat2"];
	
	lastBeatTheory1=currentBeatTheory1=0;
	lastBeatTheory2=currentBeatTheory2=0;
	
	minScoreForDrumNeeded=3;
	
	[self setDrumTrackerPitchWeight];
	
	// states
	//numberTheoryChangesState1=[[WXSCSystemState alloc]initState:@"DrumTheoryChanges1"];
	//numberTheoryChangesState2=[[WXSCSystemState alloc]initState:@"DrumTheoryChanges2"];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[beatTrack1 release];
[beatTrack2 release];
[theoryChangeWindow1 release];
[theoryChangeWindow2 release];
[singleDestinations release];
[displayString release];

[super dealloc];
}
// ******************************************************************************************
-(void)		setDrumTrackerPitchWeight
{
// emphasis tracking hats and rides
// as this tend to be more steady ...these were 1.2 but isa does alot of fancy hi hat stuff
[beatTrack1 setPitchWeight:kHiHatClosed weight:0.7];
[beatTrack1 setPitchWeight:kHiHatPedal weight:0.7];
[beatTrack1 setPitchWeight:kHiHatOpen weight:0.7];
[beatTrack1 setPitchWeight:kRideCymbol1 weight:0.7];
[beatTrack1 setPitchWeight:kRideCymbolCup weight:0.7];
[beatTrack1 setPitchWeight:kTambourine weight:0.7];
[beatTrack1 setPitchWeight:kRideCymbol2 weight:0.7];

// de-emphasis tracking bass drums
// as this tend to be more less steady and patterned
[beatTrack1 setPitchWeight:kSoftKick weight:0.6];
[beatTrack1 setPitchWeight:kTightKick weight:0.6];
[beatTrack1 setPitchWeight:kKick weight:0.6];
[beatTrack1 setPitchWeight:kSnare weight:0.6];
[beatTrack1 setPitchWeight:kSnareSoft weight:0.6];

// does ISA use alot of steady snare
[beatTrack1 setPitchWeight:kSnareSoft weight:1.7];
[beatTrack1 setPitchWeight:kSticks weight:1.7];
[beatTrack1 setPitchWeight:kSideStick weight:1.7];
[beatTrack1 setPitchWeight:kSnare weight:1.7];
[beatTrack1 setPitchWeight:kSnareSoft weight:1.7];
return;
// de-emphasis tracking snares
// as this tend to be more less steady and used with rolls and fills
[beatTrack1 setPitchWeight:kSnareSoft weight:0.5];
[beatTrack1 setPitchWeight:kSticks weight:0.5];
[beatTrack1 setPitchWeight:kSideStick weight:0.5];
[beatTrack1 setPitchWeight:kSnare weight:0.5];
[beatTrack1 setPitchWeight:kSnareSoft weight:0.5];

// NO tracking toms
[beatTrack1 setPitchWeight:kFloorTomLow weight:0.0];
[beatTrack1 setPitchWeight:kFloorTomHigh weight:0.0];
[beatTrack1 setPitchWeight:kLowTom weight:0.0];
[beatTrack1 setPitchWeight:kMidTomLow weight:0.0];
[beatTrack1 setPitchWeight:kMidTomHigh weight:0.0];
[beatTrack1 setPitchWeight:kHighTom weight:0.0];
}
// ******************************************************************************************
-(void)		showInformation
{
[displayString textAt:10 y:20 text:[NSString stringWithFormat:@"Beat Time Drum:%d",currentBeatTheory1] color:[NSColor blackColor]];
[displayString textAt:10 y:30 text:[NSString stringWithFormat:@"Beat Time Note:%d",currentBeatTheory2] color:[NSColor blackColor]];
[displayString numberAt:120 y:20 value:score1 color:[NSColor blackColor]];
[displayString numberAt:120 y:30 value:score2 color:[NSColor blackColor]];
[displayString numberAt:160 y:20 value:lastConfirm1 color:[NSColor blackColor]];
[displayString numberAt:160 y:30 value:lastConfirm2 color:[NSColor blackColor]];
[displayString numberAt:200 y:20 value:theory1Time color:[NSColor blueColor]];
[displayString numberAt:200 y:30 value:theory2Time color:[NSColor blueColor]];
[displayString numberAt:250 y:20 value:numberChangedTheories1 color:[NSColor blackColor]];
[displayString numberAt:250 y:30 value:numberChangedTheories2 color:[NSColor blackColor]];

if(doing2BeatCheck1) [displayString textAt:2 y:20 text:@"?" color:[NSColor blackColor]];
if(doing2BeatCheck2) [displayString textAt:2 y:20 text:@"?" color:[NSColor blackColor]];

if(useTheoryType==1) [displayString textAt:235 y:20 text:@"<--" color:[NSColor blackColor]];
if(useTheoryType==2) [displayString textAt:235 y:30 text:@"<--" color:[NSColor blackColor]];
}
// ******************************************************************************************
-(void)		doStart
{
if(isActive)	return;
isActive=YES;
wasUpdate=NO;
useTheoryType=1;
[beatTrack1 doStart];
[beatTrack2 doStart];
[theoryChangeWindow1 reset];
[theoryChangeWindow2 reset];
[theoryChangeWindow1 start:1.0];
[theoryChangeWindow2 start:1.0];

[NSThread detachNewThreadSelector:@selector(theBeatTrackLockThread) toTarget:self withObject:self];

theory2Time=theory1Time=0;
lastBeatTheory1=currentBeatTheory1=0;
lastBeatTheory2=currentBeatTheory2=0;
score1=score2=lastConfirm1=lastConfirm2=0;
numberChangedTheories1=numberChangedTheories2=0;

doing2BeatCheck1=doing2BeatCheck2=NO;
checkWhichTheoryCounter=0;
useTheoryType=1;
updateInfoCounter=-1;

// reset states
//[numberTheoryChangesState1 resetTo:0];
//[numberTheoryChangesState2 resetTo:0];

[self showInformation];

testPitch=36;
}
// ******************************************************************************************
-(void)		doStop
{
isActive=NO;
[theoryChangeWindow1 stop];
[theoryChangeWindow2 stop];
}
// ******************************************************************************************
-(void)		theBeatTrackLockThread
{
NSAutoreleasePool *pool2;
pool2 = [[NSAutoreleasePool alloc] init];
[NSThread setThreadPriority:0.4];


do{

	[self doBeatTrackingUpdates:MidiGetClockTime()];
	
	[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.002]];
	}while(isActive);


[pool2 release];	
}
// ******************************************************************************************
-(void)		doBeatTrackingUpdates:(long)timePoint
{
BOOL	lock1=NO,lock2=NO;

// get any locking events occurred 
lock1=[beatTrack1 checkUpdateForLocking:timePoint];
lock2=[beatTrack2 checkUpdateForLocking:timePoint];

// send first, check which one to use after
if(lock1 && useTheoryType==1) [self doSendBeatLock:timePoint rate:currentBeatTheory1];
if(lock2 && useTheoryType==2) [self doSendBeatLock:timePoint rate:currentBeatTheory2];

checkWhichTheoryCounter++;
if((checkWhichTheoryCounter%200)!=0)	return;

// do some comparisons to see which thing to track
score1=[beatTrack1 getCurrentTheoryScore];
lastConfirm1=[beatTrack1 getCurrentTheoryLastNoteConfirmTime];
doing2BeatCheck1=[beatTrack1 isDoing2BeatCheck];
theory1Time=[beatTrack1 getCurrentTheoryHowLongBeenTheory];

score2=[beatTrack2 getCurrentTheoryScore];
lastConfirm2=[beatTrack2 getCurrentTheoryLastNoteConfirmTime];
doing2BeatCheck2=[beatTrack2 isDoing2BeatCheck];
theory2Time=[beatTrack2 getCurrentTheoryHowLongBeenTheory];

if([beatTrack1 theoryJustChanged]) [theoryChangeWindow1 bang:timePoint value:1];
if([beatTrack2 theoryJustChanged]) [theoryChangeWindow2 bang:timePoint value:1];

numberChangedTheories1=[theoryChangeWindow1 getSize];
numberChangedTheories2=[theoryChangeWindow2 getSize];

if(numberChangedTheories1>25) 
	{
	[theoryChangeWindow1 reset];
	[beatTrack1 doStart];
	}

//make as default then see if should track2
useTheoryType=1;	
if(score1==0 && score2!=0) useTheoryType=2;
if(score2>score1*2) useTheoryType=2;
if(lastConfirm1>lastConfirm2+5000 && score1<minScoreForDrumNeeded)  useTheoryType=2; 
if(theory1Time<2000 && theory2Time>10000 && score1<minScoreForDrumNeeded)   useTheoryType=2; 
if(theory1Time<10000 && theory2Time>30000 && score1<minScoreForDrumNeeded)   useTheoryType=2; 
if(score2>10 && theory2Time>10000 && (numberChangedTheories2==0 && numberChangedTheories1>=2) && score1<minScoreForDrumNeeded) useTheoryType=2; 

currentTheoryType=useTheoryType;
		
// get current theory times

currentBeatTheory1=[beatTrack1 getBeatTime];
currentBeatTheory2=[beatTrack2 getBeatTime];


// update states
//[perceptMonitor postStatePerceptIfChange:@"BeatTrackNumberTheory1" state:numberTheoryChangesState1 value:numberChangedTheories1 time:timePoint type:messageName];
//[perceptMonitor postStatePerceptIfChange:@"BeatTrackNumberTheory2" state:numberTheoryChangesState2 value:numberChangedTheories1 time:timePoint type:messageName];


[self showInformation];

}
// ******************************************************************************************
// this will sending to each generator that beat tracks (passed to this class into a NSArray)
// a signal to generator...
// 
// ******************************************************************************************
-(void)		doSendBeatLock:(long)timePoint rate:(int)rate
{
if(useTheoryType==1) if(score1<minScoreForDrumNeeded || lastConfirm1>5000)  return;
if(useTheoryType==2) if(score2<10  || theory2Time<1000 || lastConfirm2>5000)  return;

updateTime=timePoint;
wasUpdate=YES;
int t,size=[singleDestinations count];

for(t=0;t<size;t++)
	[[singleDestinations objectAtIndex:t]handleBeatTrackSignal:timePoint rate:rate];
}
// ******************************************************************************************
-(void) addToBeatTrack:(id)anObject
{
[singleDestinations addObject:anObject];
}
// ******************************************************************************************
-(long)		wasUpdated
{
if(!wasUpdate)  return -1;
wasUpdate=NO;
return updateTime;
}

// ******************************************************************************************
-(BOOL)		hasATheory
{
if(currentTheoryType==1 && score1>=minScoreForDrumNeeded)		return YES;
if(currentTheoryType==2 && score2>=10)		return YES;
return NO;
}
// ******************************************************************************************
-(int)		getBeatPulseTime
{
if(useTheoryType==1)	return currentBeatTheory1;
return currentBeatTheory2;
}
// ******************************************************************************************
-(void)		beatTrack:(NSNotification*)notification
{

}
// ******************************************************************************************
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint
{
if(type!=typeKeyOn) return;

if(data1==kVoice10) [beatTrack1 doBangToMidiIn:type channel:data1 pitch:data2 volume:data3 time:timePoint];
if(data1!=kVoice10) [beatTrack2 doBangToMidiIn:type channel:data1 pitch:data2 volume:data3 time:timePoint];
}
// ******************************************************************************************

@end
