// ******************************************************************************************
//  WXSCSystemBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCSystemBasic.h"

// ******************************************************************************************

@implementation WXSCSystemBasic

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	displayString=[[WXDisplayStrings alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[displayString release];
[super dealloc];
}
// ******************************************************************************************
-(void) initViews
{
view=[WXSCCharacterView sharedInstance];
plotter=[WXNSArrayDataPlotter sharedInstance];
}
// ******************************************************************************************
-(void)		doStart
{
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
}
// ******************************************************************************************

@end
