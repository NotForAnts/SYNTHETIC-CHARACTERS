// ******************************************************************************************
//  WXSCSystemBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCCharacterView.h"
#import "WXNSArrayDataPlotter.h"
#import "WXDisplayStrings.h"
// ******************************************************************************************

@interface WXSCSystemBasic : NSObject {

WXDisplayStrings		*displayString;
WXSCCharacterView		*view;
WXNSArrayDataPlotter	*plotter;
}

-(void)		initViews;
-(void)		doStart;
-(void)		doAllLoopUpdate:(long)time;
-(void)		showInfo:(NSPoint)pos;
// ******************************************************************************************

@end
