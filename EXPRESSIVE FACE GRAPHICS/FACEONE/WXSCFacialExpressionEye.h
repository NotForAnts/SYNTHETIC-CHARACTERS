// ******************************************************************************************
//  WXSCFacialExpressionEye
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCFacialExpressionFeatureBasic.h"


// ******************************************************************************************

@interface WXSCFacialExpressionEye : WXSCFacialExpressionFeatureBasic {

NSRect  eyeRect,closeRect;
float   ex1,ex2;
float   closey1,closeyd;
float   ballXDisp,ballXD,ballXSpeed,ballMaxY,ballMinY;
float   ballXSpeedMult;
float   ballYDisp,ballYD;
float   minClosePosition;

float   shutSpeed,movePause;
int		blinkChance,blinkSpeed;
int		eyePlacement;

short   currentEmotion;

NSImage *eyeBall;
NSImage *eye1,*edge1,*eyeWhite1,*eyeClose1;
NSImage *eye2,*edge2,*eyeWhite2,*eyeClose2;

WXSCFaceExpressionTragectory	*ballTrag1,*ballTrag2;
WXSCFaceExpressionTragectory	*blinkTrag;
}

// ******************************************************************************************


@end
