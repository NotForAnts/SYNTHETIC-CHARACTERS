// ******************************************************************************************
//  WXSCMListeningMidiRouter
//  Created by Paul Webb on Tue Jun 13 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>

#import "WXMidiListenConstants.h"
#import "WXUsefullCode.h"
#import "WXCoreMidiPlayer.h"
#import "WXMidiEventKeyOff.h"

@class WXSCMListeningCentre;
// ******************************************************************************************

@interface WXSCMListeningMidiRouter : NSObject {

WXCoreMidiPlayer		*midiPlayer;
NSMutableArray			*theDestinations;
NSMutableArray			*noteOffQueue;
WXMidiEventKeyOff		*noteOff;
}


-(void)		setMidiPlayer:(id)player;
-(void)		midiNote:(short)_channel pitch:(short)pitch volume:(short)volume duration:(int)duration;
-(void)		midiCC:(short)channel type:(short)type value:(short)value;
-(void)		addDestination:(id)dest;
-(void)		doNoteOffQueue;

// ******************************************************************************************

@end
