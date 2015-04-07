// ******************************************************************************************
//  WXSCAnimSequenceScripting
//  Created by Paul Webb on Sun Jan 22 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCAnimSequenceBank.h"
#import "WXSCAnimSequence.h"
#import "WXSCAnimBodyWhole.h"
#import "WXSCAnimBodyPartBasic.h"
#import "WXUsefullCode.h"
// ******************************************************************************************
@interface WXSCAnimSequenceScripting : NSObject {

WXSCAnimSequenceBank	*theBank;
WXSCAnimBodyWhole		*theBody;

}

-(void)		setBank:(WXSCAnimSequenceBank*)p;
-(void)		setBody:(WXSCAnimSequenceBank*)p;
-(void)		setView:(id)p;

@end
