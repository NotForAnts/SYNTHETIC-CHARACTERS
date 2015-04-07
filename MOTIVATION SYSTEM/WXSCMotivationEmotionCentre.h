// ******************************************************************************************
//  WXSCMotivationEmotionCentre
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************
// now it is based on
//
// EMOTIONAL RELEASER GENERATORS
// AFFECTIVE ASSESSMENTS - and send SOMONTIC MARKERS
// EMOTION ELICITORS
// EMOTION ARBITRATION
//
// NOTES: this is again following from Brezeals design. And is part of the system 
// which I least understand the overall structure and process.
//
//
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXSCSystemBasic.h"
#import "WXPoller.h"
#import "WXSCMotivationEmotionBasic.h"
#import "WXSCReleaserAffectiveIntent.h"

// ******************************************************************************************
// for *new* expanded version - April 2007

#import "WXSCMotivationEmotionArbitration.h"
#import "WXSCMotivationEmotionAffectiveAccessment.h"
#import "WXSCMotivationEmotionElicitation.h"
#import "WXSCMotivationEmotionReleaserSystem.h"

// ******************************************************************************************


@interface WXSCMotivationEmotionCentre : WXSCSystemBasic {

WXPoller					*theTimer;
NSMutableArray				*emotionStates;
WXSCMotivationEmotionBasic  *currentEmotionObject;
NSMutableString				*currentEmotionName;
int numberEmotions,lastEmotionIndex;

}

-(void)		addEmotion:(id)emotion;
-(id)		getEmotionObjectNamed:(NSString*)name;
-(void)		postGoalFailure:(float)penalty;
-(void)		postGoalSucess:(float)reward;
-(void)		addStimulateToEmotion:(NSString*)name gain:(float)gain;

-(id)		currentEmotionObject;

// ******************************************************************************************

@end
