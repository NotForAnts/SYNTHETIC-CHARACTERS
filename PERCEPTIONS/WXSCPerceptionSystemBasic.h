// ******************************************************************************************
//  WXSCPerceptionSystemBasic
//  Created by Paul Webb on Wed Jan 11 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCSystemBasic.h"
#import "WXSCPerceptionObject.h"
#import "WXSCPerceptionSensorBasic.h"
#import "WXSCPerceptionBlackboard.h"

#import "WXSCPerceptFloat.h"
#import "WXSCPerceptSymbol.h"
// test stuff sensors
#import "WXSCTestSensorOne.h"


// 
// ******************************************************************************************

@interface WXSCPerceptionSystemBasic : WXSCSystemBasic {


WXSCPerceptionBlackboard	*perceptBlackboard;

NSMutableArray		*sensorArray;

}

-(void)		makeSensorArray;
-(id)		perceptBlackboard;
-(void)		addSensor:(id)aSensor;

// ******************************************************************************************

@end
