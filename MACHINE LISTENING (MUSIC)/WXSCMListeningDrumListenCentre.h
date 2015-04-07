// ******************************************************************************************
//  WXSCMListeningDrumListenCentre
//  Created by Paul Webb on Mon Jun 12 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>

#import "WXUsefullCode.h"
#import "WXSCMListeningSubCentreBasic.h"

#import "WXMidiListenerChannelActiveStats.h"
#import "WXMidiListenerDrumRegularity.h"
#import "WXMidiListenerDrumStatistics.h"

#import "WXXGDrumNameConstants.h"
// ******************************************************************************************

@interface WXSCMListeningDrumListenCentre : WXSCMListeningSubCentreBasic {

int		theDrumMidiChannel;
int		drumType;
int		drumTypeStore[128];

WXMidiListenerChannelActiveStats		*bassActive;
WXMidiListenerChannelActiveStats		*snareActive;
WXMidiListenerChannelActiveStats		*hiHatsActive;
WXMidiListenerChannelActiveStats		*tomsActive;
WXMidiListenerChannelActiveStats		*drumsActive;

WXMidiListenerDrumRegularity			*bassRegular;
WXMidiListenerDrumRegularity			*snareRegular;
WXMidiListenerDrumRegularity			*hiHatsRegular;

WXMidiListenerDrumStatistics			*bassStats;
WXMidiListenerDrumStatistics			*snareStats;
WXMidiListenerDrumStatistics			*hiHatsStats;
}


-(void)		initDrumTypes;

// ******************************************************************************************


@end
