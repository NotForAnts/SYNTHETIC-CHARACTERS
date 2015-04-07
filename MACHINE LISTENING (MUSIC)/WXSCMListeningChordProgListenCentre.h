// ******************************************************************************************
//  WXSCMListeningChordProgListenCentre
//  Created by Paul Webb on Mon Jun 12 2006.
// ******************************************************************************************
//  a set of things for examining chords
//
//  as with the other classifiers....this can be changed and have things BOOLEANED OUT
//  so can configure what kinds of classifiers are active
//
//
//  to add
//  -cadence spotter - use WXMidiListenerTonalCadenceSpotter on roots
//  -
//  -consonance of chord 
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCMListeningSubCentreBasic.h"

#import "WXMidiListenerChordClassifierOne.h"
#import "WXMidiListenerChordTonalClassify.h"
#import "WXMidiListenerIntervalsConsonanceKompact.h"
#import "WXMidiListenerIntervalsConsonantClassify.h"
#import "WXMidiListenerTonalCadenceSpotter.h"
#import "WXMidiListenerChordPlayedBeforeStore.h"

#import "WXTimeWindowStore.h"
#import "WXPoller.h"
// ******************************************************************************************

@interface WXSCMListeningChordProgListenCentre : WXSCMListeningSubCentreBasic {

WXMidiListenerChordClassifierOne			*chordClassifyOne;
WXMidiListenerChordTonalClassify			*chordTonalClassify;
WXMidiListenerIntervalsConsonanceKompact	*chordConsonance;
WXMidiListenerIntervalsConsonantClassify	*chordConsonanceTwo;
WXMidiListenerTonalCadenceSpotter			*chordCadenceSpotter;
WXMidiListenerChordPlayedBeforeStore		*chordBeforeStore;

WXTimeWindowStore			*theTimeWindow;
WXTimeWindowStore			*durationTimeWindow;
WXPoller					*allLoopTimer;

float   chordsPerSecond;
float   chordDensity;
int		totalDuration,averageDuration,numberSustained;
int		chordRoot,chordSize;

BOOL	noteIsActive[16][128];
long	noteStartTime[16][128];
}


-(void)		setCurrentKeyAndMode:(short)key mode:(short)mode;


// ******************************************************************************************


@end
