// ******************************************************************************************
//  WXSCMListeningTextureClassifications
//  Created by Paul Webb on Mon Jun 19 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>

#import "WXSCMListeningSubCentreBasic.h"
#import "WXUsefullCode.h"
#import "WXDisplayStrings.h"
#import "WXXGDrumNameConstants.h"
#import "WXPitchMidiConstants.h"

// ******************************************************************************************

#import		"WXMidiListenerMultiDuration.h"
#import		"WXMidiListenerSpotTexturalChange.h"
#import		"WXMidiListenerTextureClassify.h"
#import		"WXMidiListenerTextureGestures.h"
#import		"WXMidiListenerTextureTrendSpot.h"
// ******************************************************************************************

@interface WXSCMListeningTextureClassifications : WXSCMListeningSubCentreBasic {

WXDisplayStrings	*displayString;


WXMidiListenerMultiDuration				*durationTexture;
WXMidiListenerSpotTexturalChange		*textureChangeSpotter;

WXMidiListenerTextureClassify			*volumeTextureClassify;
WXMidiListenerTextureClassify			*pitchTextureClassify;
WXMidiListenerTextureGestures			*pitchTextureGestures;

WXMidiListenerTextureTrendSpot			*volumeTrendClassify;
}


-(void)		doStart;
-(void)		doStop;
-(void)		doAllLoopUpdate:(long)time;
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint;
-(void)		showInformation;


// ******************************************************************************************

@end
