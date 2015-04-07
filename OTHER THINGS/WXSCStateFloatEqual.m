// ******************************************************************************************
//  WXSCStateFloatEqual
//  Created by Paul Webb on 25/09/2006.
// ******************************************************************************************


#import "WXSCStateFloatEqual.h"


@implementation WXSCStateFloatEqual
// ******************************************************************************************
-(id)   initEqual:(float)value
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
[displayString textAt:pos.x y:pos.y text:@"Equal" color:[NSColor yellowColor]];
[displayString numberAt:pos.x+70 y:pos.y value:theValue color:[NSColor yellowColor]];
}
// ******************************************************************************************
@end
