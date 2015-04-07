// ******************************************************************************************
//  WXSCAnimStandAloneMaster
//  Created by Paul Webb on Sun Feb 05 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"

#import "WXSCAnimBodyPartBasic.h"
#import "WXSCAnimBodyWhole.h"
#import "WXSCAnimSequence.h"
#import "WXSCAnimSequenceBank.h"
// ******************************************************************************************

@interface WXSCAnimStandAloneMaster : NSObject {

id		stageView;

WXSCAnimBodyWhole			*theBody;
WXSCAnimSequenceBank		*sequenceBank;

BOOL	isActive;

}

-(void) initStuff;
-(void) setStageView:(id)v;
-(void) loadSequence;
-(void) runSequence;
-(void) doStop;
-(void) doFlipStart;
-(void) doDraw;

// ******************************************************************************************

@end
