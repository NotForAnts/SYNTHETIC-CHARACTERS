// ******************************************************************************************
//  WXSCPerceptSymbol
//  Created by Paul Webb on Mon Feb 13 2006.
// ******************************************************************************************

#import <Cocoa/Cocoa.h>
#import "WXUsefullCode.h"
#import "WXDisplayStrings.h"
#import "WXSCFacialExpressionFace.h"
#import "WXSCMotivationEmotionCentre.h"
// ******************************************************************************************

@interface WXSCFacialExpressionFaceOneView : NSView
{

int		counter;
float   emotionLevel,lastLevel;

NSMutableString	*emotionName;
id  lastEmotion;
WXSCMotivationEmotionCentre *emotionCentre;
WXDisplayStrings			*displayStrings;
WXSCFacialExpressionFace	*theFace;


BOOL	useTestGui;
int		guiType;
float   guiLevel;
}


-(void)		updateEmotion;
-(void)		backGroundThread;

-(void)			updateEmotionGui;
- (IBAction)	popUpAction:(id)sender;
- (IBAction)	levelAction:(id)sender;

// ******************************************************************************************

@end
