// ******************************************************************************************
//  WXSCFaceExpressSimple
//  Created by Paul Webb on Fri Feb 10 2006.
// ******************************************************************************************

#import "WXSCFaceExpressSimple.h"


@implementation WXSCFaceExpressSimple

// ******************************************************************************************
-(id)   initWithFrame:(NSRect)frameRect
{
if ((self = [super initWithFrame:frameRect]) != nil) 
	{
	face[0]=[self doLoadImage:@"happyFace.tif"];
	face[1]=[self doLoadImage:@"tiredFace.tif"];
	face[2]=[self doLoadImage:@"fearFace.tif"];
	face[3]=[self doLoadImage:@"sternFace.tif"];
	face[4]=[self doLoadImage:@"sadFace.tif"];
	face[5]=[self doLoadImage:@"sadFace.tif"];
	face[6]=[self doLoadImage:@"pleasedFace.tif"];
	
	displayString=[[WXDisplayStrings alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void) drawRect:(NSRect)rect
{
NSString	*name;
int index=2;
id emotion=[emotionCentre currentEmotionObject];

NSRect imageRect;

if(emotion!=nil)
	{
	name=[emotion emotionName];
	if([name isEqualToString:@"Happy"])			index=0;
	if([name isEqualToString:@"Tired"])			index=1;
	if([name isEqualToString:@"Fear"])			index=2;
	if([name isEqualToString:@"Frustration"])   index=3;
	if([name isEqualToString:@"Boredom"])		index=4;
	if([name isEqualToString:@"Sorrow"])		index=5;
	if([name isEqualToString:@"Interest"])		index=6;
	
	imageRect=NSMakeRect(0,0,[face[index] size].width,[face[index] size].height);
	[face[index] drawAtPoint:NSMakePoint(20,20) fromRect:imageRect operation:NSCompositeSourceOver fraction:1.0];
	[displayString textAt:0 y:0 text:name color:[NSColor blackColor]];
	}
else
	[displayString textAt:0 y:0 text:@"No Emotion" color:[NSColor blackColor]];



}
// ******************************************************************************************
-(void)		setEmotionCentre:(id)ec			{   emotionCentre=ec;   }
// ******************************************************************************************
-(NSImage*) doLoadImage:(NSString*)imageName
{
NSImage* newimage;
newimage=[NSImage imageNamed:imageName];
[newimage	retain];
[newimage	lockFocus];
[newimage	unlockFocus];
return newimage;
}
// ******************************************************************************************

@end
