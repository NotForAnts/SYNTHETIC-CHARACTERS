// ******************************************************************************************
//  WXSCMotivationEmotionBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCSystemBasic.h"
// ******************************************************************************************

@interface WXSCMotivationEmotionBasic : WXSCSystemBasic {

NSMutableString		*emotionName;

int				emotionIndex;
float			emotionLevel,maxEmotionLevel;
float			emotionRateOfChange,lastEmotionLevel;
float			emotionProcessGain;

NSMutableArray			*theDataGraph;
}

-(id)		initEmotion:(NSString*)name index:(int)index;
-(void)		processEmotion;

-(NSString*)	emotionName;
-(float)		emotionLevel;
-(float)		emotionRateOfChange;
-(float)		lastEmotionLevel;
-(void)			setEmotionProcessGain:(float)gain;
-(void)			stimulateEmotion:(float)ammount;

// ******************************************************************************************

@end
