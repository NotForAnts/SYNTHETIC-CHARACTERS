// ******************************************************************************************
//  WXSCBehaviourMusicControl
//  Created by Paul Webb on Mon Jun 19 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>

#import "WXMidiListenerResultStore.h"

// ******************************************************************************************

@interface WXSCBehaviourMusicControl : NSObject {

WXMidiListenerResultStore				*listenProperties;

}

-(void)		doStart;
-(void)		doAllLoopUpdate:(long)time;

// ******************************************************************************************

@end
