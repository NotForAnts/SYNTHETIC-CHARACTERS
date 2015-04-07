// ******************************************************************************************
//  WXSCFacialExpressionFeatureBasic
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************
#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXSCFaceExpressionTragectory.h"
// ******************************************************************************************
@interface WXSCFacialExpressionFeatureBasic : NSObject {

int		moodType;
float   xpos,ypos;
BOOL	mouseIsDown;
}


-(id)		initAt:(float)x y:(float)y;
-(NSImage*) doLoadImage:(NSString*)imageName;
-(void)		doDraw;
-(void)		doAnimate;
-(void)		initstuff;
-(BOOL)		hasDoneExpression;


-(void)		goNeutral;
-(void)		goSad;

//  put into expression for emotion
-(void)		goHappyWithLevel:(NSNumber*)level;
-(void)		goSadWithLevel:(NSNumber*)level;
-(void)		goNeutralWithLevel:(NSNumber*)level;
-(void)		goFrustratedWithLevel:(NSNumber*)level;
-(void)		goAngryWithLevel:(NSNumber*)level;
-(void)		goTiredWithLevel:(NSNumber*)level;
-(void)		goInterestedWithLevel:(NSNumber*)level;
-(void)		goBoredWithLevel:(NSNumber*)level;
-(void)		goFearWithLevel:(NSNumber*)level;
-(void)		goSurpriseWithLevel:(NSNumber*)level;


-(void)		resetToNormal;

// for testing
-(void)		mouseDragged:(NSEvent*)theEvent	view:(NSView*)view;
-(void)		mouseDown:(NSEvent*)theEvent view:(NSView*)view;
-(void)		mouseUp:(NSEvent*)theEvent view:(NSView*)view;


// ******************************************************************************************
@end
