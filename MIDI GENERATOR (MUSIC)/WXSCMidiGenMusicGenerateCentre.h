// ******************************************************************************************
//  WXSCMidiGenMusicGenerateCentre
//  Created by Paul Webb on Mon Jun 19 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXCoreMidiPlayer.h"

#import "WXSCMidiGenMusicGenerateReactive.h"
// ******************************************************************************************

@interface WXSCMidiGenMusicGenerateCentre : NSObject {

WXCoreMidiPlayer		*theMidiPlayer;

WXSCMidiGenMusicGenerateReactive	*reactiveSubCentre;
}


-(void)		doStart;
-(void)		doAllLoopUpdate:(long)time;
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint;
-(void)		handleCCInput:(short)channel type:(short)type value:(short)value time:(long)timePoint;
-(void)		handleBeatTrackSignal:(long)timepoint rate:(int)rate;

// ******************************************************************************************

@end
