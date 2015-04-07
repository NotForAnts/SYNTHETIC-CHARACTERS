// ******************************************************************************************
//  WXSCStateFloatBetween
//  Created by Paul Webb on Mon Feb 13 2006.
// ******************************************************************************************
#import "WXSCStateFloatBetween.h"


@implementation WXSCStateFloatBetween
// ******************************************************************************************
-(id)   initBetween:(float)v1 v2:(float)v2
{
if(self=[super init])
	{
	theValue1=v1;
	theValue2=v2;
	}
return self;
}
// ******************************************************************************************
-(BOOL) compareToFloat:(float)value
{
return WXUIsFloatBetween(value,theValue1,theValue2);
}
// ******************************************************************************************
-(BOOL) compareToString:(NSString*)value
{
return NO;
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString textAt:pos.x y:pos.y text:@"Between" color:[NSColor yellowColor]];
[displayString numberAt:pos.x+70 y:pos.y value:theValue1 color:[NSColor yellowColor]];
[displayString numberAt:pos.x+90 y:pos.y value:theValue2 color:[NSColor yellowColor]];
}
// ******************************************************************************************
@end
