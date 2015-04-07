// ******************************************************************************************
//  WXSCMListeningGenerateTestMidi
//  Created by Paul Webb on Tue Jun 13 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXCoreMidiPlayer.h"
#import "WXSCMListeningMidiRouter.h"

#import "WXXGDrumNameConstants.h"
#import "WXPitchMidiConstants.h"
#import "WXSystemexclusiveconstants.h"
// ******************************************************************************************

@interface WXSCMListeningGenerateTestMidi : NSObject {

WXSCMListeningMidiRouter	*midiRouter;

int			counter;
int			mod1,cpitch,cduration,mod2,hatMod;
float		volume;

int			p1,p2,p3,p4;
}



-(void)		setMidiRouter:(id)root;
-(void)		doReset;
-(void)		doGenerate;

// ******************************************************************************************

@end
