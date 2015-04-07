// ******************************************************************************************
//  WXSCFaceExpressSimple
//  Created by Paul Webb on Fri Feb 10 2006.
// ******************************************************************************************


#import <Cocoa/Cocoa.h>

#import "WXUsefullCode.h"
#import "WXSCMotivationEmotionCentre.h"
#import "WXDisplayStrings.h"
// ******************************************************************************************

@interface WXSCFaceExpressSimple : NSView {

NSImage *face[20];

WXSCMotivationEmotionCentre *emotionCentre;
WXDisplayStrings	*displayString;
}

-(void)		setEmotionCentre:(id)ec;
-(NSImage*) doLoadImage:(NSString*)imageName;


// ******************************************************************************************

@end
