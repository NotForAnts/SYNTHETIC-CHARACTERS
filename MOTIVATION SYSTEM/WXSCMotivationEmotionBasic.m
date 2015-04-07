// ******************************************************************************************
//  WXSCMotivationEmotionBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCMotivationEmotionBasic.h"


@implementation WXSCMotivationEmotionBasic
// ******************************************************************************************
-(id)		initEmotion:(NSString*)name index:(int)index
{
if(self=[super init])
	{
	emotionIndex=index;
	emotionName=[[NSMutableString alloc]initWithString:name];	
	emotionLevel=0;
	maxEmotionLevel=1.0;
	emotionProcessGain=0;
	
	theDataGraph=[[NSMutableArray alloc]init];
	[[WXNSArrayDataPlotter sharedInstance]addArrayToPlot:
		theDataGraph
		ydisp:[[WXNSArrayDataPlotter sharedInstance] numberPlots]*20
		yscale:9.0
		name:emotionName];
	}
return self;
}
// ******************************************************************************************
-(void)		dealloc
{
[emotionName release];
[super dealloc];
}
// ******************************************************************************************
-(void)		doStart
{
[theDataGraph removeAllObjects];
emotionRateOfChange=0;
lastEmotionLevel=0;
emotionLevel=0;
}
// ******************************************************************************************
-(void)		stimulateEmotion:(float)ammount
{
emotionLevel=WXUMakeFloatBetween(0.0,maxEmotionLevel,emotionLevel+ammount);
emotionRateOfChange=emotionLevel-lastEmotionLevel;
lastEmotionLevel=emotionLevel;

//printf("STIMULATE EMOTION %s = %f now=%f\n",[emotionName cString],ammount,emotionLevel);
}
// ******************************************************************************************
-(void)		processEmotion
{
emotionLevel=WXUMakeFloatBetween(0.0,maxEmotionLevel,emotionLevel-0.05+emotionProcessGain);

emotionRateOfChange=emotionLevel-lastEmotionLevel;
lastEmotionLevel=emotionLevel;

[theDataGraph addObject:[NSNumber numberWithFloat:emotionLevel]];
}
// ******************************************************************************************
-(NSString*)	emotionName							{   return emotionName;				}
-(float)		emotionLevel						{   return emotionLevel;			}
-(float)		emotionRateOfChange					{   return emotionRateOfChange;		}
-(float)		lastEmotionLevel					{   return lastEmotionLevel;		}
-(void)			setEmotionProcessGain:(float)gain   {   emotionProcessGain=gain;		}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString  textAt:pos.x y:pos.y text:emotionName color:[NSColor greenColor]];
[displayString floatNumberAt:pos.x+100 y:pos.y value:emotionLevel color:[NSColor greenColor]];
}
// ******************************************************************************************

@end
