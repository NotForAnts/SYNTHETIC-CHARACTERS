// ******************************************************************************************
//  WXSCMListeningScaleKeyCentre
//  Created by Paul Webb on Wed Jun 14 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>

#import "WXSCMListeningSubCentreBasic.h"
#import "WXUsefullCode.h"
#import "WXDisplayStrings.h"
#import "WXMidiListenConstants.h"

#import "WXMidiListenerKeyScaleClassify.h"
// ******************************************************************************************

@interface WXSCMListeningScaleKeyCentre : WXSCMListeningSubCentreBasic {

WXDisplayStrings	*displayString;

WXMidiListenerKeyScaleClassify*		scaleKeyPerceptor;

short   currentKey,currentMode,currentConfidence;

}

-(short)	currentKey;
-(short)	currentMode;

-(void)		doStart;
-(void)		doStop;
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint;
-(void)		showInformation;

// ******************************************************************************************
@end
