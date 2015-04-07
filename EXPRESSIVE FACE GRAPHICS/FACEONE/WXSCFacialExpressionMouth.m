// ******************************************************************************************
//  WXSCFacialExpressionMouth
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************

#import "WXSCFacialExpressionMouth.h"

// ******************************************************************************************

@implementation WXSCFacialExpressionMouth

// ******************************************************************************************
-(id)		initAt:(float)x y:(float)y
{
if(self=[super initAt:x y:y])
	{
	theLips=[[WXSCFacialExpressionLips alloc]initAt:x y:y];

	
	teeth=[self doLoadImage:@"teeth.gif"];
	teethRect=NSMakeRect(0,0,[teeth size].width,[teeth size].height);
	
	tx=xpos-3-[teeth size].width/2;
	ty=ypos+10-[teeth size].height/2;
	
	teeth=[self doLoadImage:@"teeth2.gif"];
	ty=ypos-[teeth size].height/2;
	
	topTeeth=[self doLoadImage:@"topTeeth.gif"];
	bottomTeeth=[self doLoadImage:@"bottomTeeth.gif"];
	topRect=NSMakeRect(0,0,[topTeeth size].width,[topTeeth size].height);
	bottomRect=NSMakeRect(0,0,[bottomTeeth size].width,[bottomTeeth size].height);

	
	jawTrag=[[WXSCFaceExpressionTragectory alloc]initWithValue:0];

	
	[self initstuff];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[theLips release];
[super dealloc];
}
// ******************************************************************************************
//  make it go to certain expression
// ******************************************************************************************
-(void)		goNeutralWithLevel:(NSNumber*)level			
{   
[self neutralTo:10];
[theLips neutralTo:10];
}
// ******************************************************************************************
-(void)		goFrustratedWithLevel:(NSNumber*)level		{   }
// ******************************************************************************************
-(void)		goAngryWithLevel:(NSNumber*)level			
{   
[jawTrag setAimTo:-20*[level floatValue]*0.3 steps:2];
[theLips goAngryWithLevel:level];
}
// ******************************************************************************************
-(void)		goTiredWithLevel:(NSNumber*)level			
{   
[jawTrag setAimTo:-10*[level floatValue] steps:2];
[theLips goTiredWithLevel:level];
}
// ******************************************************************************************
-(void)		goInterestedWithLevel:(NSNumber*)level		{   }
-(void)		goBoredWithLevel:(NSNumber*)level			{   }
// ******************************************************************************************
-(void)		goSadWithLevel:(NSNumber*)level
{
[jawTrag setAimTo:0 steps:3];
[theLips goSadWithLevel:level];
}
// ******************************************************************************************
-(void)		goHappyWithLevel:(NSNumber*)level
{
[jawTrag setAimTo:-5*[level floatValue] steps:2];
[theLips goHappyWithLevel:level];
}
// ******************************************************************************************
-(void)		goFearWithLevel:(NSNumber*)level
{
[jawTrag setAimTo:-20*[level floatValue]*1.0 steps:2];
[theLips goSurpriseWithLevel:level];
}
// ******************************************************************************************
-(void)		goSurpriseWithLevel:(NSNumber*)level
{
[jawTrag setAimTo:-20*[level floatValue]*1.0 steps:2];
[theLips goSurpriseWithLevel:level];
}
// ******************************************************************************************
-(void)			neutralTo:(int)count
{
[theLips neutralTo:count];
[jawTrag setAimTo:0 steps:count];
}
// ******************************************************************************************
-(void)			resetToNormal
{
}

// ******************************************************************************************
// DRAWING MOUTH 
// ******************************************************************************************
-(void) doDraw
{
[theLips doDrawBlack];

[bottomTeeth compositeToPoint:NSMakePoint(tx,ypos-42+jawDisp) fromRect:bottomRect operation:NSCompositeSourceAtop fraction:1.0];
[topTeeth compositeToPoint:NSMakePoint(tx,ypos-17+teethY1) fromRect:topRect operation:NSCompositeSourceAtop fraction:1.0];

[theLips doDraw];
}
// ******************************************************************************************
-(BOOL)		hasDoneExpression
{
if(![jawTrag isDone])   return NO;
if(![theLips hasDoneExpression])	return NO;
return YES;
}
// ******************************************************************************************
-(void)		doAnimate
{
[self moveJaw];
[theLips doAnimate];
}
// ******************************************************************************************
-(void)		moveJaw
{
if(![jawTrag doUpdate:&jawDisp]);

[theLips moveWithJaw:jawDisp];
}
// ******************************************************************************************
// MOUSE STUFF
// ******************************************************************************************
- (void)mouseDragged:(NSEvent *)theEvent	view:(NSView*)view
{
//int t;
//for(t=0;t<[controlPoints count];t++)
//	[[controlPoints objectAtIndex:t] mouseDragged:theEvent view:view];
	
}
// ******************************************************************************************
- (void)mouseDown:(NSEvent *)theEvent	view:(NSView*)view
{
int t;
//for(t=0;t<[controlPoints count];t++)
//	[[controlPoints objectAtIndex:t] mouseDown:theEvent view:view];

[super mouseDown:theEvent view:view];	
}
// ******************************************************************************************
- (void)mouseUp:(NSEvent *)theEvent	view:(NSView*)view
{
int t;
//for(t=0;t<[controlPoints count];t++)
//	[[controlPoints objectAtIndex:t] mouseUp:theEvent view:view];

[super mouseUp:theEvent view:view];
}
// ******************************************************************************************
@end
