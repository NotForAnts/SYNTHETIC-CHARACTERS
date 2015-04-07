// ******************************************************************************************
//  WXSCStateFloatSet
//  Created by Paul Webb on 25/09/2006.
// ******************************************************************************************

#import "WXSCStateFloatSet.h"


@implementation WXSCStateFloatSet
// ******************************************************************************************
-(id)   initSet:(NSString*)set match:(BOOL)match
{
if(self=[super init])
	{
	int t;
	theMatch=match;
	theSet=[match componentsSeparatedByString:@" "];
	theSetNumber=[[NSMutableArray alloc]init];
	for(t=0;t<[theSet count];t++)
		[theSetNumber addObject:[NSNumber numberWithFloat:[[theSet objectAtIndex:t]floatValue]]];
	}
return self;
}
// ******************************************************************************************
-(BOOL) compareToFloat:(float)value
{
BOOL result;
result=[theSetNumber containsObject:[NSNumber numberWithFloat:value]];

return (result==theMatch);
}
// ******************************************************************************************
-(BOOL) compareToString:(NSString*)value
{
return NO;
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString textAt:pos.x y:pos.y text:@"Set" color:[NSColor yellowColor]];
//[displayString numberAt:pos.x+70 y:pos.y value:theValue color:[NSColor yellowColor]];
}
// ******************************************************************************************
@end
