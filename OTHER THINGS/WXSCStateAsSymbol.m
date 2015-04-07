// ******************************************************************************************
//  WXSCStateAsSymbol
//  Created by Paul Webb on Fri Feb 10 2006.
// ******************************************************************************************

#import "WXSCStateAsSymbol.h"


@implementation WXSCStateAsSymbol
// ******************************************************************************************

-(id)   initStateSymbol:(NSString*)name
{
if(self=[super init])
	{
	symbol=name;
	[symbol retain];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[symbol release];
[super dealloc];
}
// ******************************************************************************************
-(BOOL) compareToFloat:(float)value
{
return [symbol isEqualToString:[NSString stringWithFormat:@"%f",value]];
}
// ******************************************************************************************
-(BOOL) compareToString:(NSString*)value
{
return [symbol isEqualToString:value];
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString textAt:pos.x y:pos.y text:@"IsSymbol" color:[NSColor yellowColor]];
[displayString textAt:pos.x+70 y:pos.y text:symbol color:[NSColor yellowColor]];
}
// ******************************************************************************************

@end
