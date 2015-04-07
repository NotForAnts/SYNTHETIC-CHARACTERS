// ******************************************************************************************
//  WXSCTestAnAction
//  Created by Paul Webb on Sat Feb 11 2006.
// ******************************************************************************************


#import <Cocoa/Cocoa.h>
#import "WXUsefullCode.h"
// ******************************************************************************************
@interface WXSCTestAnAction : NSView {

NSImage *render;
float   screenX,screenY;
}

+(id)		sharedInstance;
-(void)		doProcess;
-(void)		backGroundThread;
// ******************************************************************************************

@end
