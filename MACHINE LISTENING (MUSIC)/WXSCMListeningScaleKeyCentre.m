// ******************************************************************************************
//  WXSCMListeningScaleKeyCentre
//  Created by Paul Webb on Wed Jun 14 2006.
// ******************************************************************************************
#import "WXSCMListeningScaleKeyCentre.h"


@implementation WXSCMListeningScaleKeyCentre
// ******************************************************************************************

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	displayString=[[WXDisplayStrings alloc]init];
	scaleKeyPerceptor=[[WXMidiListenerKeyScaleClassify alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void)		dealloc
{
[scaleKeyPerceptor release];
[super dealloc];
}
// ******************************************************************************************
-(short)	currentKey		{   return currentKey;		}
-(short)	currentMode		{   return currentMode;		}
// ******************************************************************************************
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint
{
if(type!=typeKeyOn) return;
if(data1==drumChannel)		return;
[scaleKeyPerceptor bangPitch:data2 time:timePoint];
[scaleKeyPerceptor getStats:&currentKey mode:&currentMode conf:&currentConfidence];

}
// ******************************************************************************************
-(void)		doStart
{
[scaleKeyPerceptor doStart];
}
// ******************************************************************************************
-(void)		doStop
{

}
// ******************************************************************************************
-(void)		showInformation
{
float   ypos=100;

[displayString textAt:10 y:ypos text:@"SCALE / MODE   (conf)" color:[NSColor blackColor]];

[displayString numberAt:10 y:ypos-12 value:currentKey color:[NSColor blackColor]];
[displayString numberAt:50 y:ypos-12 value:currentMode color:[NSColor blackColor]];
[displayString numberAt:90 y:ypos-12 value:currentConfidence color:[NSColor blackColor]];
}
// ******************************************************************************************

@end
