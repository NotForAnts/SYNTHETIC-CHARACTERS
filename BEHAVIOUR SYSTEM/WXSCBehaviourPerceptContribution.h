// ******************************************************************************************
//  WXSCBehaviourPerceptContribution
//  Created by Paul Webb on Thu Feb 09 2006.
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXSCSystemBasic.h"
#import "WXSCPerceptionObject.h"
#import "WXSCPerceptionBlackboard.h"
// ******************************************************************************************
@interface WXSCBehaviourPerceptContribution : WXSCSystemBasic {

id	perceptCentre;
WXSCPerceptionBlackboard	*perceptBlackboard;
WXSCPerceptionObject		*contributionObject;

NSString	*perceptName;

int		perceptIndex,type;
float   map1,map2,range1,range2;	
float   perceptLevel,currentLevel;

float	equalValue,contributionValue,contributionError;
}

-(void)		setContributionName:(NSString*)name;
-(void)		setMapper:(NSString*)mapString;
-(void)		setAsEqual:(float)value contribution:(float)contribution error:(float)error;
-(float)	processContribution;

// ******************************************************************************************

@end
