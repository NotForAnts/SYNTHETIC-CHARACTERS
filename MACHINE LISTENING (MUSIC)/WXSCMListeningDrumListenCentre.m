// ******************************************************************************************
//  WXSCMListeningDrumListenCentre
//  Created by Paul Webb on Mon Jun 12 2006.
// ******************************************************************************************

#import "WXSCMListeningDrumListenCentre.h"


@implementation WXSCMListeningDrumListenCentre
// ******************************************************************************************

// ******************************************************************************************
-(id)		init
{
if(self=[super init])
	{
	theDrumMidiChannel=9;
	
	bassActive=[[WXMidiListenerChannelActiveStats alloc]init];		[bassActive setOnOff:@"BassOn" off:@"BassOff"];
	snareActive=[[WXMidiListenerChannelActiveStats alloc]init];		[snareActive setOnOff:@"SnareOn" off:@"SnareOff"];
	hiHatsActive=[[WXMidiListenerChannelActiveStats alloc]init];	[hiHatsActive setOnOff:@"HatsOn" off:@"HatsOff"];
	tomsActive=[[WXMidiListenerChannelActiveStats alloc]init];		[tomsActive setOnOff:@"TomsOn" off:@"TomsOff"];
	drumsActive=[[WXMidiListenerChannelActiveStats alloc]init];		[drumsActive setOnOff:@"DrumsOn" off:@"DrumsOff"];
	
	bassRegular=[[WXMidiListenerDrumRegularity alloc]init];
	snareRegular=[[WXMidiListenerDrumRegularity alloc]init];
	hiHatsRegular=[[WXMidiListenerDrumRegularity alloc]init];
	
	
	bassStats=[[WXMidiListenerDrumStatistics alloc]init];
	snareStats=[[WXMidiListenerDrumStatistics alloc]init];
	hiHatsStats=[[WXMidiListenerDrumStatistics alloc]init];
	
	[self initDrumTypes];
	
	[midiListenObjects addObject:bassActive];
	[midiListenObjects addObject:snareActive];
	[midiListenObjects addObject:hiHatsActive];
	[midiListenObjects addObject:tomsActive];
	[midiListenObjects addObject:drumsActive];
	}
return self;
}
// ******************************************************************************************
-(void)		dealloc
{
[bassActive release];
[snareActive release];
[hiHatsActive release];
[tomsActive release];
[drumsActive release];

[bassRegular release];
[snareRegular release];
[hiHatsRegular release];

[bassStats release];
[snareStats release];
[hiHatsStats release];

[super dealloc];
}
// ******************************************************************************************
-(void)		doStart
{
[bassActive doStart];
[snareActive doStart];
[hiHatsActive doStart];
[tomsActive doStart];
[drumsActive doStart];

[bassRegular doStart];
[snareRegular doStart];
[hiHatsRegular doStart];

[bassStats doStart];
[snareStats doStart];
[hiHatsStats doStart];
}
// ******************************************************************************************
-(void)		doStop
{
[bassActive doStop];
[snareActive doStop];
[hiHatsActive doStop];
[tomsActive doStop];
[drumsActive doStop];

[bassRegular doStop];
[snareRegular doStop];
[hiHatsRegular doStop];

[bassStats doStop];
[snareStats doStop];
[hiHatsStats doStop];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
[bassActive doAllLoopUpdate:time];
[snareActive doAllLoopUpdate:time];
[hiHatsActive doAllLoopUpdate:time];
[tomsActive doAllLoopUpdate:time];
[drumsActive doAllLoopUpdate:time];

[bassRegular doAllLoopUpdate:time];
[snareRegular doAllLoopUpdate:time];
[hiHatsRegular doAllLoopUpdate:time];

[bassStats doAllLoopUpdate:time];
[snareStats doAllLoopUpdate:time];
[hiHatsStats doAllLoopUpdate:time];
}
// ******************************************************************************************
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint
{
if(data1!=theDrumMidiChannel)	return;

drumType=drumTypeStore[data2];

[drumsActive handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];

switch(drumType)
	{
	case 1:		[snareActive handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];	
				[snareRegular handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];	
				[snareStats handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];	
				break;
				
	case 2:		[bassActive handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
				[bassRegular handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];	
				[bassStats handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];	
				break;
				
	case 3:		[hiHatsActive handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];		
				[hiHatsRegular handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
				[hiHatsStats handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];		
				break;
				
	case 4:		[tomsActive handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];		
				break;	
	}

}

// ******************************************************************************************
// types
//  1. snares
//  2. bass
//  3. hithats
//  4. toms
//  5. cymbols (splash types)
//  6. percussive others
// ******************************************************************************************
-(void)		initDrumTypes
{
drumTypeStore[kBrushTap]=1;
drumTypeStore[kBrushSwirl]=1;
drumTypeStore[kBrushSlap]=1;
drumTypeStore[kBrushTapSwirl]=1;
drumTypeStore[kSnareRoll]=1;
drumTypeStore[kCastanet]=6;
drumTypeStore[kSnareSoft]=1;
drumTypeStore[kSticks]=1;
drumTypeStore[kSoftKick]=1;
drumTypeStore[kOpenRimShot]=1;
drumTypeStore[kTightKick]=2;
drumTypeStore[kKick]=2;
drumTypeStore[kSideStick]=2;
drumTypeStore[kSnare]=1;
drumTypeStore[kHandClap]=1;
drumTypeStore[kTightSnare]=1;
drumTypeStore[kFloorTomLow]=4;
drumTypeStore[kHiHatClosed]=3;
drumTypeStore[kFloorTomHigh]=4;
drumTypeStore[kHiHatPedal]=3;
drumTypeStore[kLowTom]=4;
drumTypeStore[kHiHatOpen]=3;
drumTypeStore[kMidTomLow]=4;
drumTypeStore[kMidTomHigh]=4;
drumTypeStore[kCrashCymbol1]=5;
drumTypeStore[kHighTom]=4;
drumTypeStore[kRideCymbol1]=3;
drumTypeStore[kChineseCymbol]=3;
drumTypeStore[kRideCymbolCup]=3;
drumTypeStore[kTambourine]=3;
drumTypeStore[kSplashCymbol]=5;
drumTypeStore[kCowbell]=6;
drumTypeStore[kCrashCymbol2]=5;
drumTypeStore[kVibraslap]=5;
drumTypeStore[kRideCymbol2]=3;
drumTypeStore[kBongoHigh]=6;
drumTypeStore[kBongoLow]=6;
drumTypeStore[kCongoHighMute]=6;
drumTypeStore[kCongoHighOpen]=6;
drumTypeStore[kCongoLow]=6;
drumTypeStore[kTimbaleHigh]=6;
drumTypeStore[kTimbaleLow]=6;
drumTypeStore[kAgogoHigh]=6;
drumTypeStore[kAgogoLow]=6;
drumTypeStore[kCabass]=6;
drumTypeStore[kMaracas]=6;
drumTypeStore[kSambaWhistleH]=6;
drumTypeStore[kSmabaWhistleL]=6;
drumTypeStore[kGuiroShort]=6;
drumTypeStore[kGuiroLong]=6;
drumTypeStore[kClave]=6;
drumTypeStore[kWoodBlockH]=6;
drumTypeStore[kWoodBlockL]=6;
drumTypeStore[kCuicaMute]=6;
drumTypeStore[kCuicaOpen]=6;
drumTypeStore[kTriangleMute]=6;
drumTypeStore[kTrinagleOpen]=6;
drumTypeStore[kShaker]=6;
drumTypeStore[kJingleBells]=6;
drumTypeStore[kBellTree]=6;
}
// ******************************************************************************************

@end
