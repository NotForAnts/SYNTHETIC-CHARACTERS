// ******************************************************************************************
//  WXSCStateFloatGreater
//  Created by Paul Webb on Sat Feb 11 2006.
// ******************************************************************************************

#import "WXSCStateFloatGreater.h"

// ******************************************************************************************

@implementation WXSCStateFloatGreater


// ******************************************************************************************
-(id)   initGreater:(float)value
{
if(self=[super init])
	{
	theValue=value;
	}
return self;
}
// ******************************************************************************************
-(BOOL) compareToFloat:(float)value
{
return value>theValue;
}
// ******************************************************************************************
-(BOOL) compareToString:(NSString*)value
{
return NO;
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString textAt:pos.x y:pos.y text:@"Greater" color:[NSColor yellowColor]];
[displayString numberAt:pos.x+70 y:pos.y value:theValue color:[NSColor yellowColor]];
}
// ******************************************************************************************

@end
