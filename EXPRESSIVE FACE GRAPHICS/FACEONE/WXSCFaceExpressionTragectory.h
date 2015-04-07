// ******************************************************************************************
//  WXSCFaceExpressionTragectory
//  Created by Paul Webb on Wed Aug 24 2005.
// ******************************************************************************************
// many parameters have to go from position to position in number of moves
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
// ******************************************************************************************

@interface WXSCFaceExpressionTragectory : NSObject {

float   currentValue;
float   value1,value2;
int		currentStep,numberSteps;
}


-(id)		initWithValue:(float)v;


-(void)		setMove:(float)v1 v2:(float)v2 steps:(int)steps;
-(void)		setAimTo:(float)v2 steps:(int)steps;
-(void)		setAimPause:(float)v2 steps:(int)steps pause:(int)pause;
-(BOOL)		doUpdate:(float*)param;
-(BOOL)		isDone;

// ******************************************************************************************



@end
