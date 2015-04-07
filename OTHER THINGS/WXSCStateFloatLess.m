// ******************************************************************************************
//  WXSCStateFloatLess
//  Created by Paul Webb on Mon Feb 13 2006.
// ******************************************************************************************

#import "WXSCStateFloatLess.h"


@implementation WXSCStateFloatLess

// ******************************************************************************************
-(id)   initLess:(float)value
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
return value<theValue;
}
// ******************************************************************************************
-(BOOL) compareToString:(NSString*)value
{
return NO;
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString textAt:pos.x y:pos.y text:@"Less" color:[NSColor yellowColor]];
[displayString numberAt:pos.x+70 y:pos.y value:theValue color:[NSColor yellowColor]];
}
// ******************************************************************************************

@end
