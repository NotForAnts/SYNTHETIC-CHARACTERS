// ******************************************************************************************
//  WXSCMListeningView
//  Created by Paul Webb on Tue Jun 13 2006.
// ******************************************************************************************

#import <Cocoa/Cocoa.h>

#import "WXDisplayStrings.h"
#import "WXMidiListenerResultStore.h"
// ******************************************************************************************

@interface WXSCMListeningView : NSView
{
WXMidiListenerResultStore		*listenProperties;
WXDisplayStrings				*displayString;

float   screenX,screenY;


NSMutableArray		*listenThings;
}

-(void)		addListenThing:(id)object;
-(void)		setListenDictionary:(id)ld;
// ******************************************************************************************

@end
