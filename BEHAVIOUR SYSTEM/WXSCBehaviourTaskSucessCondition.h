// ******************************************************************************************
//  WXSCBehaviourTaskSucessCondition
//  Created by Paul Webb on Wed Feb 08 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCSystemBasic.h"
#import "WXSCPerceptionBlackboard.h"
// ******************************************************************************************

@interface WXSCBehaviourTaskSucessCondition : WXSCSystemBasic {

WXSCPerceptionBlackboard	*perceptBlackboard;
NSString	*taskConditionName;
BOOL		conditionMet;

}

-(id)		initTaskCondition:(NSString*)name;
-(BOOL)		conditionMet;
-(void)		doReset;

// ******************************************************************************************

@end
