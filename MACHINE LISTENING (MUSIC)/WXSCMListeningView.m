// ******************************************************************************************
//  WXSCMListeningView
//  Created by Paul Webb on Tue Jun 13 2006.
// ******************************************************************************************


#import "WXSCMListeningView.h"

@implementation WXSCMListeningView
// ******************************************************************************************

- (id)initWithFrame:(NSRect)frameRect
{
if ((self = [super initWithFrame:frameRect]) != nil) 
	{
	displayString=[[WXDisplayStrings alloc]init];
	screenX=frameRect.size.width;
	screenY=frameRect.size.height;
	
	listenThings=[[NSMutableArray alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void) setListenDictionary:(id)ld
{
listenProperties=ld;
}
// ******************************************************************************************
- (void)drawRect:(NSRect)rect
{
[[NSColor whiteColor]set];
NSRectFill(rect);

[displayString textAt:20 y:screenY-14 text:@"Listening Values" color:[NSColor blackColor]];

[listenThings makeObjectsPerformSelector:@selector(showInformation)];
[listenProperties showResults];
}
// ******************************************************************************************
-(void)		addListenThing:(id)object
{
[listenThings addObject:object];
}
// ******************************************************************************************

@end
