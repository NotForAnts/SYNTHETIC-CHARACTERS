// ******************************************************************************************
//  WXSCMListeningSysExListener
//  Created by Paul Webb on Mon Jul 24 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"

#import "WXSystemexclusiveconstants.h"
#import "WXSCMListeningSubCentreBasic.h"
#import "WXMidiListenerCCTextureGestures.h"
// ******************************************************************************************


// ******************************************************************************************

@interface WXSCMListeningSysExListener : WXSCMListeningSubCentreBasic {

int		theCCTypes[10];
int		currentIndex,typeIndex;
int		typeToIndex[128];

WXMidiListenerCCTextureGestures			*ccTextureGestures[10];
}

-(void)		initStuff;
-(void)		addListenersForType:(int)type name:(NSString*)name;
-(void)		showInformation;

// ******************************************************************************************


@end
