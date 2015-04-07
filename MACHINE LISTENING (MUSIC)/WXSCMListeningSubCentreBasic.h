// ******************************************************************************************
//  WXSCMListeningSubCentreBasic
//  Created by Paul Webb on Mon Jun 26 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>

#import "WXUsefullCode.h"
#import "WXMidiListenerResultStore.h"
#import "WXMidiListenerNotificationCentre.h"
#import "WXMidiEventChord.h"
#import "WXMidiEventNoteList.h"
#import "WXCCEvent.h"
// ******************************************************************************************

@interface WXSCMListeningSubCentreBasic : NSObject {


WXMidiListenerResultStore				*listenProperties;
WXMidiListenerNotificationCentre		*listenNotifications;

NSMutableArray		*midiListenObjects;
}



-(void)		setListenDictionary:(id)ld;
-(void)		setListenNotificationCentre:(id)lnc;

-(void)		doStart;
-(void)		doStop;
-(void)		doAllLoopUpdate:(long)time;

-(void)		handleMidiInput:(short)type data1:(short)data1 data2:(short)data2 data3:(short)data3 time:(long)timePoint;
-(void)		handleChord:(WXMidiEventChord*)aChord channel:(int)channel time:(long)timePoint;
-(void)		handleEventList:(WXMidiEventNoteList*)eventList channel:(int)channel time:(long)timePoint;
-(void)		handleCCEvent:(WXCCEvent*)anEvent channel:(int)channel time:(long)timePoint;
-(void)		handleCCInput:(short)channel type:(short)type value:(short)value time:(long)timePoint;

// ******************************************************************************************


@end
