// ******************************************************************************************
//  WXSCMassSpringControlPointMover
//  Created by Paul Webb on Thu May 19 2005.
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCMassSpring.h"
// ******************************************************************************************

@interface WXSCMassSpringControlPointMover : NSObject {

WXSCMassSpring  *theMass;
short		numberSteps,currentStep;
NSPoint		position1,position2,currentPosition;
NSPoint		origPoint;

int			moveType;

}

-(id)		initForMass:(WXSCMassSpring*)mass;
-(void)		moveToPoint:(NSPoint)pos count:(short)count;
-(void)		moveToOrigin:(short)count;
-(void)		displaceByPixels:(float)xd yd:(float)yd count:(short)count;

-(BOOL)		isDoneMove;
-(void)		doUpdate;

@end
