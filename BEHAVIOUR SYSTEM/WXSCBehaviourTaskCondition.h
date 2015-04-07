// ******************************************************************************************
//  WXSCBehaviourTaskCondition
//  Created by Paul Webb on Thu Feb 09 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCSystemBasic.h"
#import "WXSCPerceptionBlackboard.h"
#import "WXSCMotivationDriveManager.h"
#import "WXSCMotivationEmotionCentre.h"
#import "WXSCMotivationEmotionBasic.h"
#import "WXSCMotivationDriveBasic.h"

#import "WXSCStateAsSymbol.h"
// ******************************************************************************************


@interface WXSCBehaviourTaskCondition : WXSCSystemBasic {

WXSCPerceptionBlackboard	*perceptBlackboard;
id  theEmotionCentre;
id  theDriveCentre;

NSString	*taskConditionName;
BOOL		conditionMet;
int			testCounter;

int type;
id  theConditionObject;
id  theConditionState;
}


-(id)		initTaskCondition:(NSString*)name;
-(BOOL)		conditionMet;
-(void)		doReset;

-(void)		makePerceptCondition:(NSString*)name state:(id)state;
-(void)		makeDriveCondition:(NSString*)name state:(id)state;
-(void)		makeEmotionCondition:(NSString*)name state:(id)state;

-(BOOL)		doPerceptCondition;
-(BOOL)		doDriveCondition;
-(BOOL)		doEmotionCondition;
-(BOOL)		doAffectivePerceptCondition;

-(void)		setDriveCentre:(id)dc;
-(void)		setEmotionCentre:(id)ec;

-(void)		showAllInfo:(NSPoint)pos;
// ******************************************************************************************

@end
