// ******************************************************************************************
//  WXSCMListeningChannelListenSubCentre
//  Created by Paul Webb on Tue Jun 27 2006.
// ******************************************************************************************
//
//  see WXSCMListeningChannelListener ( which does stuff for each channel)
//
// this class is a container
//
// ******************************************************************************************


#import <Foundation/Foundation.h>

#import "WXSCMListeningSubCentreBasic.h"
#import "WXUsefullCode.h"
#import "WXDisplayStrings.h"
#import "WXSCMListeningChannelListener.h"
// ******************************************************************************************

@interface WXSCMListeningChannelListenSubCentre : WXSCMListeningSubCentreBasic {

WXSCMListeningChannelListener		*theListeners[16];

BOOL		channelActive[16];
}


-(void)		initStuff;
-(void)		setChannelsActive:(NSString*)active;
-(void)		setCurrentKeyAndMode:(short)key mode:(short)mode;

// ******************************************************************************************

@end
