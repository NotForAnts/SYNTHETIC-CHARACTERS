// ******************************************************************************************
//  WXSCMListeningTextureClassifications
//  Created by Paul Webb on Mon Jun 19 2006.
// ******************************************************************************************

#import "WXSCMListeningTextureClassifications.h"


@implementation WXSCMListeningTextureClassifications
// ******************************************************************************************


// ******************************************************************************************
-(id)		init
{
if(self=[super init])
	{
	displayString=[[WXDisplayStrings alloc]init];
	
	//	keep these
	durationTexture=[[WXMidiListenerMultiDuration alloc]init];
	textureChangeSpotter=[[WXMidiListenerSpotTexturalChange alloc]init];
	
	// keep these as these are newly made in June 2006
	pitchTextureClassify=[[WXMidiListenerTextureClassify alloc]initTextureType:1];
	volumeTextureClassify=[[WXMidiListenerTextureClassify alloc]initTextureType:2];
	pitchTextureGestures=[[WXMidiListenerTextureGestures alloc]initTextureType:1];
	volumeTrendClassify=[[WXMidiListenerTextureTrendSpot alloc]initTextureType:2];
	
	[midiListenObjects addObject:durationTexture];
	[midiListenObjects addObject:textureChangeSpotter];
	[midiListenObjects addObject:pitchTextureClassify];
	[midiListenObjects addObject:volumeTextureClassify];
	[midiListenObjects addObject:pitchTextureGestures];
	[midiListenObjects addObject:volumeTrendClassify];
	}
	
return self;
}
// ******************************************************************************************
-(void)		dealloc
{
[displayString release];
[durationTexture release];
[textureChangeSpotter release];

[volumeTextureClassify release];
[pitchTextureClassify release];
[pitchTextureGestures release];
[volumeTrendClassify release];

[super dealloc];
}
// ******************************************************************************************
-(void)		doStart
{
[durationTexture doStart];
[textureChangeSpotter doStart];

[volumeTextureClassify doStart];
[pitchTextureClassify doStart];
[pitchTextureGestures doStart];
[volumeTrendClassify doStart];
}
// ******************************************************************************************
-(void)		doStop
{
[durationTexture doStop];
[textureChangeSpotter doStop];

[volumeTextureClassify doStop];
[pitchTextureClassify doStop];
[pitchTextureGestures doStop];

[volumeTrendClassify doStop];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
[durationTexture doAllLoopUpdate:time];
[textureChangeSpotter doAllLoopUpdate:time];

[volumeTextureClassify doAllLoopUpdate:time];
[pitchTextureClassify doAllLoopUpdate:time];
[pitchTextureGestures doAllLoopUpdate:time];

[volumeTrendClassify doAllLoopUpdate:time];
}
// ******************************************************************************************
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint
{
[textureChangeSpotter handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
[durationTexture handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
[volumeTextureClassify handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
[pitchTextureClassify handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
[pitchTextureGestures handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
[volumeTrendClassify  handleMidiInput:type data1:data1 data2:data2 data3:data3 time:timePoint];
}
// ******************************************************************************************
-(void)		showInformation
{
}
// ******************************************************************************************

@end
