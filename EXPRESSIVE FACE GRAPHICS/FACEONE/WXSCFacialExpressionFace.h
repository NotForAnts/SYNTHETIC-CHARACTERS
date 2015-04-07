// ******************************************************************************************
//  WXSCFacialExpressionFace
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************
// to build up an expressive face I am having a face made up of several components
// eyes, eyeBrow, mouth, cheekLines, foreHeadLines
//
// each of these can be commanded to go to a certain position to shape it
// in which there will be some CONTROL POINTS which can be positioned
// and make the expression. Can morph from shape1...shape2
// an expression is the correct shape for each facial feature
//
// to draw a face (a cartoon sexdoll face) I will use a bezier path with a solid fill
// and some composed images such as an eyeball / teeth which can be positioned
// 
// Then a expressive face controller will set up animation of feature morph in time 
// so can have coninual dynamic expression. The facial expression controller will be
// MIDI (chan16) controllable so can put on a different computer
//
// THE FACE IS AIMING FOR A BACK PROJECTION ONTO A SKIN COLORED SURFACE OF THE DOLL
// for now I will use a small view 
// 
// 
// as a reference for emotive face expressions I will use the sketches on DSR page 178
//
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCFacialExpressionMouth.h"
#import "WXSCFacialExpressionEye.h"
#import "WXSCFacialExpressionEyeBrow.h"
#import "WXSCFacialExpressionHeadLines.h"
// ******************************************************************************************
@interface WXSCFacialExpressionFace : NSObject {

WXSCFacialExpressionMouth		*mouth;
WXSCFacialExpressionEye			*eyes;
WXSCFacialExpressionEyeBrow		*brow1;
WXSCFacialExpressionEyeBrow		*brow2;
WXSCFacialExpressionHeadLines   *headline;

NSMutableArray  *theFeatures;

NSMutableArray  *scriptMethod;
NSMutableArray  *scriptValue;

}

-(id)		initWithView:(NSView*)view;

-(void)		doDraw;
-(void)		doAnimate;
-(void)		doScript;
-(void)		addToScript:(NSString*)method value:(float)value;


- (void)mouseDragged:(NSEvent *)theEvent	view:(NSView*)view;

// ******************************************************************************************

@end
