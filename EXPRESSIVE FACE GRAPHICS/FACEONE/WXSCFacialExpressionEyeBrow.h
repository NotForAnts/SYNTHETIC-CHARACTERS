// ******************************************************************************************
//  WXSCFacialExpressionEyeBrow
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCFacialExpressionFeatureBasic.h"
#import "WXGraphicRotatedNSImage.h"
// ******************************************************************************************

@interface WXSCFacialExpressionEyeBrow : WXSCFacialExpressionFeatureBasic {



float			angle,angleMult,angleChange;
float			currentAngle,cxdisp,cydisp;

WXSCFaceExpressionTragectory	*trag1;
WXSCFaceExpressionTragectory	*trag2;
WXSCFaceExpressionTragectory	*trag3;

WXGraphicRotatedNSImage *rotateImage;
}

-(id)		initBrowAt:(float)x y:(float)y name:(NSString*)name view:(NSView*)view direction:(float)direction;
-(void)		goSadWithLevel:(NSNumber*)level;
-(void)		goNeutral;



@end
