// ******************************************************************************************
//  WXSCPerceptionSensorBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>

#import "WXSCSystemBasic.h"
#import "WXSCPerceptionBlackboard.h"
#import "WXSCPerceptionObject.h"
#import "WXSCPerceptFloat.h"
#import "WXSCPerceptSymbol.h"

#import "WXPoller.h"
// ******************************************************************************************

@interface WXSCPerceptionSensorBasic : WXSCSystemBasic {

NSTimeInterval		rate;
NSMutableString		*perceptName;
SEL selector;
id  sensorObject;
id  sensorValue;
WXSCPerceptionBlackboard	*perceptBlackboard;
WXSCPerceptionObject		*perceptionObject;
WXPoller					*theTimer;

}

-(void) setName:(NSString*)name;
-(void) setSensorObject:(id)so;
-(void) setSelector:(SEL)sel;
-(void) setSensorValue:(id)sv;
-(void) setBlackboard:(id)bb;

// ******************************************************************************************


@end
