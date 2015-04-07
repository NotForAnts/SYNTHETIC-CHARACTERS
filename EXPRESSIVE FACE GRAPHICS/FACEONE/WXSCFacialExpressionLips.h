// ******************************************************************************************
//  WXSCFacialExpressionLips
//  Created by Paul Webb on Thu Feb 16 2006.
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCFacialExpressionFeatureBasic.h"
#import "WXNSPointWrapper.h"
#import "WXSCFacialExpressionLipMussle.h"
#import "WXSCMassSpring.h"
#import "WXSCMassSpringControlPointMover.h"
// ******************************************************************************************
@interface WXSCFacialExpressionLips : WXSCFacialExpressionFeatureBasic {

NSMutableArray		*line1;
NSMutableArray		*line2;
NSMutableArray		*line3;
NSMutableArray		*line4;


NSMutableArray  *theLipShape,*topLip,*baseLip,*openShape,*theMouthShape;

float   mouthWide,openness;
float	jawDisp,ovalDisp,closeDisp,widthDisplace;

// LIP CONTROL

WXSCMassSpringControlPointMover *mover1,*mover2,*mover3,*mover4;
NSMutableArray  *controlPoints;


WXSCFaceExpressionTragectory	*closeTrag;
WXSCFaceExpressionTragectory	*topLipTrag;
WXSCFaceExpressionTragectory	*ovalTrag;
WXSCFaceExpressionTragectory	*openTrag;
WXSCFaceExpressionTragectory	*mouthWidthTrag;

}

-(void)		smileTo:(float)disp count:(int)count;
-(void)		neutralTo:(int)count;
-(void)		moveWithJaw:(float)disp;
-(void)		moveCloseLips:(float)closeAmmont;
-(void)		moveTopLip;
-(void)		moveOval;
-(void)		moveOpen;
-(void)		doMouthWidthTrag;
-(void)		moveCloseLipAnimated;
//


-(void)		doDrawBlack;
-(void)		makeLipShapes;
-(void)		makeLipControlPoints;

-(void)		doubleConnect:(WXSCMassSpring*)m1 m2:(WXSCMassSpring*)m2;
-(void)		connectToShape:(WXSCMassSpring*)dest i1:(int)i1 i2:(int)i2 shape:(NSMutableArray*)shape strength:(float)strength;
-(void)		connectToShapeMirror:(WXSCMassSpring*)dest i1:(int)i1 i2:(int)i2 shape:(NSMutableArray*)shape strength:(float)strength;
-(WXSCMassSpring*)   makeNewMass:(NSPoint)mp  fix:(BOOL)fix;
-(NSMutableArray*)  makeMassCurveArray:(NSPoint)p1 p2:(NSPoint)p2 d1:(float)d1 d2:(float)d2 h:(float)h n:(int)n join:(BOOL)join;
// ******************************************************************************************

@end
