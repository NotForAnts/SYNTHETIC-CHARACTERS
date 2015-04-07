// ******************************************************************************************
//  WXSCMListeningCentre
//  Created by Paul Webb on Mon Jun 12 2006.
// ******************************************************************************************
//
//  this is the SinduEntes....machine listening centre in which it will be responsible
//  for having all the sub centres that listen to music and form the music theories.
//  
//  not sure if it will provide affective accessment.....
//
// ******************************************************************************************

#import <Foundation/Foundation.h>


#import "WXUsefullCode.h"
#import "WXCoreMidiPlayer.h"
#import "WXSCMListeningMidiRouter.h"
#import "WXMidiEventChord.h"
#import "WXMidiEventNoteList.h"
#import "WXCCEvent.h"

#import "WXMidiListenerResultStore.h"
#import "WXMidiListenerNotificationCentre.h"

#import "WXSCMListeningView.h"

#import "WXSCMListeningChordProgListenCentre.h"
#import "WXSCMListeningBeatTrackCentre.h"
#import "WXSCMListeningScaleKeyCentre.h"
#import "WXSCMListeningTextureClassifications.h"
#import "WXSCMListeningChannelListenSubCentre.h"
#import "WXSCMListeningDrumListenCentre.h"
#import "WXSCMListeningSysExListener.h"

// not sure if need....
#import "WXSCMListeningMelodyListenCentre.h"
#import "WXSCMListeningBassLineListenCentre.h"

//
#import "WXMidiListenerChordSpotter.h"
#import "WXMidiListenerMultiChannelSegmentGrabber.h"
#import "WXMidiListenerMusicStorage.h"

#import "WXSCMListeningGenerateTestMidi.h"

// ******************************************************************************************

@interface WXSCMListeningCentre : NSObject {

WXCoreMidiPlayer					*theMidiPlayer;
WXSCMListeningMidiRouter			*theMidiRouter;
WXSCMListeningGenerateTestMidi		*generateTestMidi;

// to store information
WXMidiListenerResultStore				*listenProperties;
WXMidiListenerNotificationCentre		*listenNotifications;

// storage of music material listened to
WXMidiListenerMusicStorage				*storageCentre;

// parses
WXMidiListenerChordSpotter					*chordSpotter;
WXMidiListenerMultiChannelSegmentGrabber	*segmentGrabber;

// what centres to use
BOOL	useChordCentre;
BOOL	useChannelCentre;
BOOL	useTextureCentre;
BOOL	useBeatTrackCentre;
BOOL	useScaleKeyCentre;
BOOL	useDrumCentre;
BOOL	useSysExCentre;

// other data
int		currentKey,currentMode;

// sub centres
WXSCMListeningBeatTrackCentre			*beatTracker;
WXSCMListeningScaleKeyCentre			*scaleKeyFinder;
WXSCMListeningTextureClassifications	*textureClassifications;
WXSCMListeningChordProgListenCentre		*chordListenCentre;
WXSCMListeningChannelListenSubCentre	*channelListenSubCentre;
WXSCMListeningDrumListenCentre			*drumListenCentre;
WXSCMListeningSysExListener				*sysExListenCentre;

// information
WXSCMListeningView  *listeningView;
int updateInfoCounter;
}

-(void)		addDestinationToRouter:(id)anObject;
-(void)		addToBeatTrack:(id)anObject;
-(void)		setMachineListenView:(id)view;
-(void)		generateTestMidiThread;
-(void)		doStart;
-(void)		doAllLoopUpdate:(long)time;
-(void)		doUpdateInformationView;

-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint;
-(void)		handleChord:(WXMidiEventChord*)aChord channel:(int)channel time:(long)timePoint;
-(void)		handleCCEvent:(WXCCEvent*)anEvent channel:(int)channel time:(long)timePoint;
-(void)		handleCCInput:(short)channel type:(short)type value:(short)value time:(long)timePoint;
-(void)		handleEventList:(WXMidiEventNoteList*)eventList channel:(int)channel time:(long)timePoint;

// ******************************************************************************************


@end
