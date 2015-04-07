// ******************************************************************************************
//  WXSCMListeningChannelListener
//  Created by Paul Webb on Tue Jun 27 2006.
// ******************************************************************************************
// THIS IS FOR A SINGLE CHANNEL
// see WXSCMListeningChannelListenSubCentre
// ******************************************************************************************
//
// consonance of segments
// WXMidiListenerMarkovNoteWithPhraseAndLazy - make markovs
// cadence spotter
// 

#import <Foundation/Foundation.h>

#import "WXSCMListeningSubCentreBasic.h"
#import "WXUsefullCode.h"
#import "WXDisplayStrings.h"


#import "WXMidiListenerIntervalsConsonanceKompact.h"
#import "WXMidiListenerIntervalsConsonantClassify.h"
#import "WXMidiListenerTonalCadenceSpotter.h"
#import "WXMidiListenerMelodicStepSizeStats.h"
#import "WXMidiListenerChannelActiveStats.h"
// ******************************************************************************************

@interface WXSCMListeningChannelListener : WXSCMListeningSubCentreBasic {


WXMidiListenerIntervalsConsonanceKompact	*segmentConsonance;
WXMidiListenerIntervalsConsonantClassify	*segmentConsonanceTwo;
WXMidiListenerTonalCadenceSpotter			*chordCadenceSpotter;
WXMidiListenerMelodicStepSizeStats			*stepSizeStats;
WXMidiListenerChannelActiveStats			*channelActive;
}

-(void)		setCurrentKeyAndMode:(short)key mode:(short)mode;


// ******************************************************************************************

@end
