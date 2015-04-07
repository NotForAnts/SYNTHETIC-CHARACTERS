// ******************************************************************************************
//  WXSCFacialExpressionMouth
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCFacialExpressionFeatureBasic.h"
#import "WXSCFacialExpressionLips.h"

#import "WXSCMassSpring.h"
#import "WXSCMassSpringControlPointMover.h"
// ******************************************************************************************

@interface WXSCFacialExpressionMouth : WXSCFacialExpressionFeatureBasic {


WXSCFacialExpressionLips	*theLips;

NSImage			*teeth,*topTeeth,*bottomTeeth;
NSRect			teethRect,topRect,bottomRect;
float			tx,ty;
float			teethOpenY3,teethY1,jawDisp;


WXSCFaceExpressionTragectory	*jawTrag;


}

-(void)		neutralTo:(int)count;
-(void)		moveJaw;

// ******************************************************************************************

@end
