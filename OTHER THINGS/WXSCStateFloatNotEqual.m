// ******************************************************************************************
//  WXSCStateFloatNotEqual
//  Created by Paul Webb on 25/09/2006.
// ******************************************************************************************

#import "WXSCStateFloatNotEqual.h"


@implementation WXSCStateFloatNotEqual
// ******************************************************************************************
-(id)   initNEqual:(float)value
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
return value==theValue;
}
// ******************************************************************************************
-(BOOL) compareToString:(NSString*)value
{
return NO;
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString textAt:pos.x y:pos.y text:@"NotEqual" color:[NSColor yellowColor]];
[displayString numberAt:pos.x+70 y:pos.y value:theValue color:[NSColor yellowColor]];
}
// ******************************************************************************************

@end
