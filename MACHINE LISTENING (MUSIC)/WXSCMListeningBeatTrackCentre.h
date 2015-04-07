// ******************************************************************************************
//  WXSCMListeningBeatTrackCentre
//  Created by Paul Webb on Mon Jun 12 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>

#import "WXUsefullCode.h"
#import "WXDisplayStrings.h"
#import "WXSCMListeningSubCentreBasic.h"

#import "WXMidiListenerBeatTracker.h"
#import "WXMidiListenerDrumBeatTracker.h"
#import "WXXGDrumNameConstants.h"
#import "WXTimeWindowStore.h"

// ******************************************************************************************
@interface WXSCMListeningBeatTrackCentre : WXSCMListeningSubCentreBasic {

WXDisplayStrings	*displayString;

BOOL	isActive;
WXMidiListenerDrumBeatTracker		*beatTrack1;
WXMidiListenerBeatTracker			*beatTrack2;

NSMutableArray						*singleDestinations;

//WXInformationView   *view1;

long		updateTime;
int			lastBeatTheory1,currentBeatTheory1;
int			lastBeatTheory2,currentBeatTheory2;
int			useTheoryType,currentTheoryType;
int			score1,score2,lastConfirm1,lastConfirm2,theory1Time,theory2Time;
int			minScoreForDrumNeeded;
int			updateInfoCounter;
int			numberChangedTheories1,numberChangedTheories2,checkWhichTheoryCounter;
BOOL		doing2BeatCheck1,doing2BeatCheck2,wasUpdate;


WXTimeWindowStore*		theoryChangeWindow1;
WXTimeWindowStore*		theoryChangeWindow2;

//WXSCSystemState		*numberTheoryChangesState1;
//WXSCSystemState		*numberTheoryChangesState2;

int			testPitch;
}

-(void)		setDrumTrackerPitchWeight;
-(void)		theBeatTrackLockThread;
-(void)		doBeatTrackingUpdates:(long)timePoint;
-(void)		doSendBeatLock:(long)timePoint rate:(int)rate;
-(void)		addToBeatTrack:(id)anObject;
-(long)		wasUpdated;
-(int)		getBeatPulseTime;
-(BOOL)		hasATheory;
-(void)		beatTrack:(NSNotification*)notification;

-(void)		showInformation;
-(void)		doStart;
-(void)		doStop;
-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint;

// ******************************************************************************************

@end
