// ******************************************************************************************
//  WXSCAnimRenderedSequence
//  Created by Paul Webb on Fri Feb 03 2006.
// ******************************************************************************************

#import "WXSCAnimRenderedSequence.h"

// ******************************************************************************************

@implementation WXSCAnimRenderedSequence

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	theRenderedPositions=[[NSMutableArray alloc]init];
	stageX=481;
	stageY=365;
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[theRenderedPositions release];
[super dealloc];
}
// ******************************************************************************************
-(void) reset
{
[theRenderedPositions removeAllObjects];
}
// ******************************************************************************************
-(void) makeNewImage
{
newImage=[[NSImage alloc]initWithSize:NSMakeSize(stageX,stageY)];
}
// ******************************************************************************************
-(void) lock
{
[newImage lockFocus];
}
// ******************************************************************************************
-(void) unlock
{
[newImage unlockFocus];
}
// ******************************************************************************************
-(void) addImage
{
[theRenderedPositions addObject:newImage];
[newImage release];
}
// ******************************************************************************************
-(void) showImage:(int)index
{
[[theRenderedPositions objectAtIndex:index] 
	drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0, 0, stageX, stageY) operation:NSCompositeSourceOver fraction:1.0]; 

}
// ******************************************************************************************
-(void) setStageSize:(float)x y:(float)y
{
stageX=x;
stageY=y;
}
// ******************************************************************************************

@end
