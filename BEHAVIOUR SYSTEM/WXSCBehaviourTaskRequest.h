// ******************************************************************************************
//  WXSCBehaviourTaskRequest
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCSystemBasic.h"
#import "WXSCBehaviourActionBasic.h"
#import "WXSCMotivationEmotionCentre.h"
#import "WXSCBehaviourTaskCondition.h"
#import "WXPoller.h"
// ******************************************************************************************

@interface WXSCBehaviourTaskRequest : WXSCSystemBasic {

id  theActionManager;
id  theMotivationCentre;
id  theEmotionCentre;
id  theDriveCentre;

float				taskFrustration,taskFrustrationIncrement;
NSMutableArray		*successEmotionGain;
NSMutableArray		*successEmotion;
NSMutableArray		*failureEmotionGain;
NSMutableArray		*failureEmotion;

NSString		*taskName;
WXPoller		*theTimer;
NSTimeInterval  timeActive;
BOOL			actionConditionsMet,isActive,isSuccess,wasSuccess;

NSMutableArray				*taskConditions;
NSMutableArray				*sucessConditions;
WXSCBehaviourActionBasic	*theAction;
}


-(id)		initTaskRequest:(NSString*)name;

-(void)		setTaskFrustrationIncrement:(float)f;
-(void)		addCondition:(id)object;
-(void)		addConditionAndRelease:(id)object;
-(void)		addSucessCondition:(id)object;
-(void)		addSucessConditionAndRelease:(id)object;

-(void)		setAction:(id)object;
-(NSString*) taskName;
-(void)		setActionManager:(id)am;
-(void)		setEmotionCentre:(id)ec;
-(void)		resetWasSucess;
-(void)		makeActive;
-(void)		makeInActive;
-(void)		doReset;
-(void)		doTaskCheckSucessConditionMet;
-(void)		doSuccessEmotionSends;
-(void)		doFailureEmotionSends;
-(void)		doTaskIfConditionsMet;
-(void)		doTaskFrustration;
-(void)		updateTaskRequest;
-(BOOL)		isSuccess;
-(BOOL)		wasSucess;
-(float)	taskFrustration;
-(int)		numberConditions;
-(void)		addSuccessEmotionGain:(NSString*)name gain:(float)gain;
-(void)		addFailureEmotionGain:(NSString*)name gain:(float)gain;

-(void)		printInfo;
-(void)		showAllInfo:(NSPoint)pos;
// ******************************************************************************************
@end
