// ******************************************************************************************
//  WXSCMListeningChordProgListenCentre
//  Created by Paul Webb on Mon Jun 12 2006.
// ******************************************************************************************

#import "WXSCMListeningChordProgListenCentre.h"


@implementation WXSCMListeningChordProgListenCentre
// ******************************************************************************************

// ******************************************************************************************
-(id)		init
{
if(self=[super init])
	{
	chordClassifyOne=[[WXMidiListenerChordClassifierOne alloc]init];
	chordTonalClassify=[[WXMidiListenerChordTonalClassify alloc]init];
	chordConsonance=[[WXMidiListenerIntervalsConsonanceKompact alloc]init];
	chordConsonanceTwo=[[WXMidiListenerIntervalsConsonantClassify alloc]init];
	
	chordCadenceSpotter=[[WXMidiListenerTonalCadenceSpotter alloc]initWithChannel:0];
	chordBeforeStore=[[WXMidiListenerChordPlayedBeforeStore alloc]init];
	
	theTimeWindow=[[WXTimeWindowStore alloc]initWithTimeLength:10000];
	durationTimeWindow=[[WXTimeWindowStore alloc]initWithTimeLength:10000];
	allLoopTimer=[[WXPoller alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void)		dealloc
{
[chordClassifyOne release];
[chordTonalClassify release];
[chordConsonance release];
[chordConsonanceTwo release];
[chordCadenceSpotter release];
[chordBeforeStore release];

[theTimeWindow release];
[durationTimeWindow release];

[super dealloc];
}
// ******************************************************************************************
-(void)		doStart
{
[chordClassifyOne doStart];
[chordTonalClassify doStart];
[chordConsonance doStart];
[chordConsonanceTwo doStart];
[chordCadenceSpotter doStart]; 
[chordBeforeStore doStart];  

[theTimeWindow reset];
[durationTimeWindow reset];
[allLoopTimer  initialiseToNow];

numberSustained=0;
int t,c;

for(c=0;c<16;c++)
	for(t=0;t<128;t++)
		noteIsActive[c][t]=NO;
}
// ******************************************************************************************
-(void)		doStop
{
[chordClassifyOne doStop];
[chordTonalClassify doStop];
[chordConsonance doStop];
[chordConsonanceTwo doStop];
[chordCadenceSpotter doStop];
[chordBeforeStore doStop]; 
}
// ******************************************************************************************
-(void)		setCurrentKeyAndMode:(short)key mode:(short)mode
{
[chordCadenceSpotter setCurrentKeyAndMode:key mode:mode];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
if(![allLoopTimer checkUpdateWithIncrement:1.0])   return;

[theTimeWindow doUpdate];
if([theTimeWindow wasUpdated])
	{
	chordsPerSecond=[theTimeWindow getDensityPerSecond];
	chordDensity=[theTimeWindow getSum]/10.0;
	
	printf("chord WINDOW CPS=%f NPS=%f\n",chordsPerSecond,chordDensity);
	}
	
[durationTimeWindow doUpdate];
if([durationTimeWindow wasUpdated])	
	{
	totalDuration=[durationTimeWindow getSum];
	averageDuration=[durationTimeWindow getAverage];
	printf("chord DURATIONS SUM=%d AVE=%d\n",totalDuration,averageDuration);
	}
}
// ******************************************************************************************
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint
{
int duration;
if(type==typeKeyOff)
	{
	if(noteIsActive[data1][data2])
		{
		duration=timePoint-noteStartTime[data1][data2];
		[durationTimeWindow bang:timePoint value:duration];
		totalDuration=[durationTimeWindow getSum];
		averageDuration=[durationTimeWindow getAverage];
		numberSustained--;
		if(numberSustained<0) numberSustained=0;
		
		printf("HMI chord DURATIONS SUM=%d AVE=%d SUS=%d\n",totalDuration,averageDuration,numberSustained);
		noteIsActive[data1][data2]=NO;
		}
	}
}
// ******************************************************************************************
-(void)		handleChord:(WXMidiEventChord*)aChord channel:(int)channel time:(long)timePoint
{
//printf("CHORD %d %d\n",channel,timePoint);

[chordClassifyOne handleChord:aChord channel:channel time:timePoint];
[chordTonalClassify handleChord:aChord channel:channel time:timePoint];
[chordBeforeStore handleChord:aChord channel:channel time:timePoint]; 
[chordConsonance classifyChordIntervals:aChord];
[chordConsonanceTwo classifyChordIntervals:aChord]; 

chordSize=[aChord count];
chordRoot=[chordTonalClassify root]; 

[chordCadenceSpotter handleMidiInput:typeKeyOn data1:0 data2:chordRoot data3:100 time:timePoint];

[theTimeWindow bang:timePoint value:chordSize];

int t,size=[aChord count],p,c;
for(t=0;t<size;t++)
	{
	p=[aChord getPitchAtIndex:t];
	c=[aChord getChannelAtIndex:t];
	if(!noteIsActive[c][p])
		{
		numberSustained++;
		noteIsActive[c][p]=YES;
		noteStartTime[c][p]=timePoint;
		}
	}
}
// ******************************************************************************************

@end
