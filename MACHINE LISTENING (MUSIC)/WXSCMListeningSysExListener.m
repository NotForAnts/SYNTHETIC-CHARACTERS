// ******************************************************************************************
//  WXSCMListeningSysExListener
//  Created by Paul Webb on Mon Jul 24 2006.
// ******************************************************************************************

#import "WXSCMListeningSysExListener.h"


@implementation WXSCMListeningSysExListener
// ******************************************************************************************


// ******************************************************************************************
-(id)		init
{
if(self=[super init])
	{
	
	[self initStuff];
	
	[self addListenersForType:kControl_PAN name:@"CCPan"];
	[self addListenersForType:kControl_HARMONIC_CONTENT name:@"CCHarmonic"];
	}
return self;
}
// ******************************************************************************************
-(void)		dealloc
{
int t;
for(t=0;t<currentIndex;t++)
	{
	[ccTextureGestures[t] release];
	}

[super dealloc];
}
// ******************************************************************************************
-(void)		initStuff
{
int t;
currentIndex=0;
for(t=0;t<128;t++)
	typeToIndex[t]=-1;
}
// ******************************************************************************************
-(void)		addListenersForType:(int)type name:(NSString*)name
{
if(currentIndex>=10)
	{
	printf("**WARNING CANNOT ADD MORE TYPES IN WXSCMListeningSysExListener ****\n");
	}
	
ccTextureGestures[currentIndex]=[[WXMidiListenerCCTextureGestures alloc]init];
[ccTextureGestures[currentIndex] setListenID:name];
[midiListenObjects addObject:ccTextureGestures[currentIndex]];

theCCTypes[currentIndex]=type;

typeToIndex[type]=currentIndex;
currentIndex++;
}
// ******************************************************************************************
-(void)		doStart
{
int t;
for(t=0;t<currentIndex;t++)
	{
	[ccTextureGestures[t] doStart];
	}
}
// ******************************************************************************************
-(void)		doStop
{
int t;
for(t=0;t<currentIndex;t++)
	{
	[ccTextureGestures[t] doStop];
	}
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
int t;
for(t=0;t<currentIndex;t++)
	{
	[ccTextureGestures[t] doAllLoopUpdate:time];
	}
}
// ******************************************************************************************
-(void)		handleCCInput:(short)channel type:(short)type value:(short)value time:(long)timePoint
{
typeIndex=typeToIndex[type];

if(typeIndex>=0)
	{
	[ccTextureGestures[typeIndex] handleCCInput:channel type:type value:value time:timePoint];
	}
}
// ******************************************************************************************
-(void)		showInformation
{
}
// ******************************************************************************************

@end
