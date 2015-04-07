// ******************************************************************************************
//  WXSCTestAnAction
//  Created by Paul Webb on Sat Feb 11 2006.
// ******************************************************************************************

#import "WXSCTestAnAction.h"
static  WXSCTestAnAction*   myWXSCTestAnActionSharedInstance=nil;
// ******************************************************************************************

@implementation WXSCTestAnAction

// ******************************************************************************************
-(id)   initWithFrame:(NSRect)frameRect
{
if ((self = [super initWithFrame:frameRect]) != nil) 
	{
	myWXSCTestAnActionSharedInstance=self;
	render=[[NSImage alloc]initWithSize:NSMakeSize(frameRect.size.width,frameRect.size.height)];
	
	screenX=frameRect.size.width;
	screenY=frameRect.size.height;
	}
return self;
}
// ******************************************************************************************
+(id)		sharedInstance
{
if(myWXSCTestAnActionSharedInstance==nil)
	myWXSCTestAnActionSharedInstance=[[WXSCTestAnAction alloc]init];

return myWXSCTestAnActionSharedInstance;
}
// ******************************************************************************************
-(void) awakeFromNib
{
//[NSThread detachNewThreadSelector:@selector(backGroundThread) toTarget:self withObject:self];
}
// ******************************************************************************************
-(void) drawRect:(NSRect)rect
{
[render drawAtPoint:NSZeroPoint fromRect:rect operation:NSCompositeSourceOver fraction:1.0];
}
// ******************************************************************************************
-(void)		doFill1
{
float x=WXURandomInteger(10,screenX);
float y=WXURandomInteger(10,screenY);
float s=WXURandomInteger(2,5);

[render lockFocus];
[[NSColor blueColor]set];
NSRectFill(NSMakeRect(x,y,s,s));
[render unlockFocus];

[self setNeedsDisplay:YES];
}
// ******************************************************************************************
-(void)		doFill2
{
float x=WXURandomInteger(10,screenX);
float y=WXURandomInteger(10,screenY);
float s=WXURandomInteger(2,5);

[render lockFocus];
[[NSColor redColor]set];
NSRectFill(NSMakeRect(x,y,s,s));
[render unlockFocus];

[self setNeedsDisplay:YES];
}
// ******************************************************************************************
-(void)		doFill3
{
float x=WXURandomInteger(10,screenX);
float y=WXURandomInteger(10,screenY);
float s=WXURandomInteger(2,15);

[render lockFocus];
[[NSColor yellowColor]set];
NSRectFill(NSMakeRect(x,y,s,s));
[render unlockFocus];

[self setNeedsDisplay:YES];
}
// ******************************************************************************************
-(void)		doClear
{
[render lockFocus];
[[NSColor clearColor]set];
NSRectFill(NSMakeRect(0,0,screenX,screenY));
[render unlockFocus];
[self doFill2];
}
// ******************************************************************************************
-(void)		doProcess
{
float x=WXURandomInteger(10,50);
float y=WXURandomInteger(10,50);
[render lockFocus];
[[NSColor redColor]set];
NSFrameRect(NSMakeRect(x,y,y,x));
[render unlockFocus];
}
// ******************************************************************************************
-(void)		backGroundThread
{
NSAutoreleasePool *pool2;
pool2 = [[NSAutoreleasePool alloc] init];

do{
	[self setNeedsDisplay:YES];

	[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.25]];
	}while(YES);


[pool2 release];
}
// ******************************************************************************************


@end
