// ******************************************************************************************
//  WXSCFacialExpressionHeadLines
//  Created by Paul Webb on Thu Feb 16 2006.
// ******************************************************************************************
#import "WXSCFacialExpressionHeadLines.h"

// ******************************************************************************************

@implementation WXSCFacialExpressionHeadLines


// ******************************************************************************************
-(id)		initAt:(float)x y:(float)y
{
if(self=[super initAt:x y:y])
	{
	
	}
return self;
}

// ******************************************************************************************
// DRAW STUFF
// ******************************************************************************************
-(void) doDraw
{
return;
NSPoint p1=NSMakePoint(xpos-100,ypos);
NSPoint p2=NSMakePoint(xpos+100,ypos);

[[NSColor whiteColor]set];
[NSBezierPath strokeLineFromPoint:p1 toPoint:p2];

}
// ******************************************************************************************


@end
