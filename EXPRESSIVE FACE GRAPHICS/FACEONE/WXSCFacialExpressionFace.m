// ******************************************************************************************
//  WXSCFacialExpressionFace
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************


#import "WXSCFacialExpressionFace.h"


@implementation WXSCFacialExpressionFace

// ******************************************************************************************
-(id)		initWithView:(NSView*)view;
{
if(self=[super init])
	{
	mouth=[[WXSCFacialExpressionMouth alloc]initAt:140 y:60+20];
	eyes=[[WXSCFacialExpressionEye alloc]initAt:140 y:150+20];
	
	brow1=[[WXSCFacialExpressionEyeBrow alloc]initBrowAt:140-60 y:140+90 name:@"browLeft.gif" view:view direction:-1.0];
	brow2=[[WXSCFacialExpressionEyeBrow alloc]initBrowAt:140+60 y:140+90 name:@"browRight.gif" view:view direction:1.0];
	
	headline=[[WXSCFacialExpressionHeadLines alloc]initAt:140 y:140+120];
	
	theFeatures=[[NSMutableArray alloc]init];		
	[theFeatures addObject:mouth];		[mouth release];
	[theFeatures addObject:eyes];		[eyes release];
	[theFeatures addObject:brow1];		[brow1 release];
	[theFeatures addObject:brow2];		[brow2 release];
	[theFeatures addObject:headline];   [headline release];
	
	
	scriptMethod=[[NSMutableArray alloc]init];
	scriptValue=[[NSMutableArray alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[theFeatures release];
[scriptMethod release];
[scriptValue release];
[super dealloc];
}
// ******************************************************************************************
-(void) doDraw
{
[theFeatures makeObjectsPerformSelector:@selector(doDraw)];
}
// ******************************************************************************************
-(void)		doAnimate
{
[self doScript];

[theFeatures makeObjectsPerformSelector:@selector(doAnimate)];
}
// ******************************************************************************************
-(void)		addToScript:(NSString*)method value:(float)value
{
[scriptMethod addObject:method];
[scriptValue addObject:[NSNumber numberWithFloat:value]];
}
// ******************************************************************************************
-(void)		doScript
{
int t;
SEL selector;
id  feature;

//printf("SCRIPT SIZE = %d\n",[scriptMethod count]);
if(![[theFeatures objectAtIndex:0] hasDoneExpression])  return;
//printf("DONE MOVE\n");


if([scriptMethod count]>0)
	{
	selector=NSSelectorFromString([scriptMethod objectAtIndex:0]);
	
	for(t=0;t<[theFeatures count];t++)
		{
		feature=[theFeatures objectAtIndex:t];
		if([feature respondsToSelector:selector])
			[feature performSelector:selector withObject:[scriptValue objectAtIndex:0]];
		}
	
	
	
	[scriptMethod removeObjectAtIndex:0];
	[scriptValue removeObjectAtIndex:0];
	}
}
// ******************************************************************************************
// MOUSE EVENT STUFF
// ******************************************************************************************
- (void)mouseDragged:(NSEvent *)theEvent	view:(NSView*)view
{
[mouth mouseDragged:theEvent view:view];
}
// ******************************************************************************************
- (void)mouseUp:(NSEvent *)theEvent	view:(NSView*)view
{
[mouth mouseUp:theEvent view:view];
}
// ******************************************************************************************
- (void)mouseDown:(NSEvent *)theEvent	view:(NSView*)view
{
[mouth mouseDown:theEvent view:view];
}
// ******************************************************************************************

@end
