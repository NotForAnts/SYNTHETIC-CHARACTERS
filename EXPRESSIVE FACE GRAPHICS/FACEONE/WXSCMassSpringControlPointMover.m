// ******************************************************************************************
//  WXSCMassSpringControlPointMover
//  Created by Paul Webb on Thu May 19 2005.
// ******************************************************************************************


#import "WXSCMassSpringControlPointMover.h"

// ******************************************************************************************

@implementation WXSCMassSpringControlPointMover


// ******************************************************************************************
-(id)		initForMass:(WXSCMassSpring*)mass
{
if(self=[super init])
	{
	theMass=mass;
	origPoint=[theMass origposition];
	currentPosition=origPoint;
	currentStep=0;
	}
return self;
}
// ******************************************************************************************
-(void)		moveToPoint:(NSPoint)pos count:(short)count
{
numberSteps=currentStep=count;
position1=currentPosition;
position2=pos;
}
// ******************************************************************************************
-(void)		moveToOrigin:(short)count
{
numberSteps=currentStep=count;
position1=currentPosition;
position2=origPoint;
}
// ******************************************************************************************
-(void)		displaceByPixels:(float)xd yd:(float)yd count:(short)count
{
numberSteps=currentStep=count;

position1=currentPosition;
position2=NSMakePoint(origPoint.x+xd,origPoint.y+yd);
}
// ******************************************************************************************
-(BOOL)		isDoneMove		{   return currentStep<1;   }
// ******************************************************************************************
-(void)		doUpdate
{
float xp,yp;
if(currentStep>0)
	{
	xp=WXUNormalise(currentStep,numberSteps,1, position1.x, position2.x);
	yp=WXUNormalise(currentStep,numberSteps,1, position1.y, position2.y);
	currentStep--;
	
	currentPosition=NSMakePoint(xp,yp);
	[theMass setNewPosition:currentPosition];
	}
}
// ******************************************************************************************


@end
