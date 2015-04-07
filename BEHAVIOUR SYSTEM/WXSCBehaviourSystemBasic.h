// ******************************************************************************************
//  WXSCBehaviourSystemBasic
//  Created by Paul Webb on Tue Jan 10 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXSCBehaviourGroupBasic.h"
#import "WXSCBehaviourTaskManager.h"
#import "WXSCBehaviourActionManager.h"
#import "WXSCBehaviourActionBasic.h"
#import "WXSCBehaviourTaskCondition.h"

#import "WXSCSystemBasic.h"
#import "WXSCMotivationSystemBasic.h"
#import "WXSCPerceptionSystemBasic.h"

// alarm system
#import "WXSCBehaviourAlarmManager.h"
#import "WXSCBehaviourAlarmProcess.h"

// states
#import "WXSCStateFloatGreater.h"
#import "WXSCStateFloatLess.h"
#import "WXSCStateFloatBetween.h"
#import "WXSCStateFloatEqual.h"
#import "WXSCStateFloatNotEqual.h"

#import "WXSCStateAsSymbol.h"

// TEST REMOVE HEADER
#import "WXSCTestAnAction.h"
// ******************************************************************************************
@interface WXSCBehaviourSystemBasic : WXSCSystemBasic {

WXSCBehaviourGroupBasic			*topLevelBehaviours;
WXSCBehaviourTaskManager		*taskRequestManager;
WXSCBehaviourAlarmManager		*alarmManager;
WXSCBehaviourActionManager		*actionManager;

// external pointer for evaluations
WXSCMotivationSystemBasic		*motivationCentre;
WXSCPerceptionSystemBasic		*perceptCentre;

}

-(void)		maketopLevelBehaviours;
-(id)		taskRequestManager;
-(void)		setMotivationCentre:(id)mc;	
-(void)		setPerceptionSystem:(id)pc;

// ******************************************************************************************
@end
