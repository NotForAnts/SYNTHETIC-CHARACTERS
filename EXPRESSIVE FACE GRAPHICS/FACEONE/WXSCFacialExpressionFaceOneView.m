// ******************************************************************************************
//  WXSCPerceptSymbol
//  Created by Paul Webb on Mon Feb 13 2006.
// ******************************************************************************************

#import "WXSCFacialExpressionFaceOneView.h"

// ******************************************************************************************

@implementation WXSCFacialExpressionFaceOneView


// ******************************************************************************************

-(id)   initWithFrame:(NSRect)frameRect
{
if ((self = [super initWithFrame:frameRect]) != nil) 
	{
	emotionName=[[NSMutableString alloc]init];
	displayStrings=[[WXDisplayStrings alloc]init];
	theFace=[[WXSCFacialExpressionFace alloc]initWithView:self];
	[theFace addToScript:@"goNeutralWithLevel:" value:0];
	lastEmotion=nil;
	
	useTestGui=YES;
	guiType=1;  guiLevel=0.5;
	}
return self;
}
// ******************************************************************************************
-(void)		awakeFromNib
{
return;


[NSThread detachNewThreadSelector:@selector(backGroundThread) toTarget:self withObject:self];
}

// ******************************************************************************************
-(void)		setEmotionCentre:(id)ec			{   emotionCentre=ec;   }
// ******************************************************************************************
- (void)drawRect:(NSRect)rect
{
return;


[[NSColor whiteColor]set]; 
NSRectFill(rect);
[[NSColor clearColor]set]; 
NSRectFill(rect);

[theFace doDraw];

//[displayStrings centreTextAt:220 y:215+50 text:emotion color:WXWhite];
//[displayStrings centreTextAt:80 y:215+50 text:emotion color:WXWhite];


[displayStrings centreTextAt:140 y:120+50 text:@"O_O" color:[NSColor whiteColor]];
[displayStrings floatNumberAt:140 y:0 value:emotionLevel color:[NSColor whiteColor]];
[displayStrings centreTextAt:40 y:0 text:emotionName color:[NSColor whiteColor]];
}


// ******************************************************************************************
-(void)		updateEmotion
{
int index;
id emotion=[emotionCentre currentEmotionObject];

[emotionName setString:@"Neutral"];
if(emotion!=nil)
	{
	[emotionName setString:[emotion emotionName]];
	emotionLevel=[emotion emotionLevel];
	if(lastEmotion==emotion && emotionLevel==lastLevel)	return;

	if([emotionName isEqualToString:@"Happy"])			[theFace addToScript:@"goHappyWithLevel:" value:emotionLevel];
	if([emotionName isEqualToString:@"Tired"])			[theFace addToScript:@"goTiredWithLevel:" value:emotionLevel];
	if([emotionName isEqualToString:@"Fear"])			[theFace addToScript:@"goFearWithLevel:" value:emotionLevel];
	if([emotionName isEqualToString:@"Frustration"])    [theFace addToScript:@"goFrustratedWithLevel:" value:emotionLevel];
	if([emotionName isEqualToString:@"Boredom"])		[theFace addToScript:@"goBoredWithLevel:" value:emotionLevel];
	if([emotionName isEqualToString:@"Sorrow"])			[theFace addToScript:@"goSadWithLevel:" value:emotionLevel];
	if([emotionName isEqualToString:@"Interest"])		[theFace addToScript:@"goInterestedWithLevel:" value:emotionLevel];
	if([emotionName isEqualToString:@"Anger"])			[theFace addToScript:@"goAngerWithLevel:" value:emotionLevel];
	
	lastLevel=emotionLevel;
	}
else
	{
	if(lastEmotion==nil)	return;
	[theFace addToScript:@"goNeutralWithLevel:" value:0];
	lastLevel=-1;
	}
	
lastEmotion=emotion;	
}
// ******************************************************************************************
-(void)		backGroundThread
{
NSAutoreleasePool *pool2;
pool2 = [[NSAutoreleasePool alloc] init];

counter=0;

do{
	if(!useTestGui) [self updateEmotion];
	counter++;
	
	[theFace doAnimate];
	[self setNeedsDisplay:YES];


	[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
	}while(YES);


[pool2 release];
}
// ******************************************************************************************
- (IBAction)	popUpAction:(id)sender
{
guiType=[sender indexOfSelectedItem]+1;
emotionLevel=guiLevel;
[self updateEmotionGui];
}
// ******************************************************************************************
- (IBAction)	levelAction:(id)sender
{
guiLevel=[sender floatValue];
[self updateEmotionGui];
}
// ******************************************************************************************
-(void)		updateEmotionGui
{
[emotionName setString:@"Neutral"];

emotionLevel=guiLevel;
switch(guiType)
	{
	case 1:		[theFace addToScript:@"goNeutralWithLevel:" value:emotionLevel];	[emotionName setString:@"Neutral"];		break;
	case 2:		[theFace addToScript:@"goHappyWithLevel:" value:emotionLevel];		[emotionName setString:@"Happy"];		break;
	case 3:		[theFace addToScript:@"goTiredWithLevel:" value:emotionLevel];		[emotionName setString:@"Tired"];		break;
	case 4:		[theFace addToScript:@"goFearWithLevel:" value:emotionLevel];		[emotionName setString:@"Fear"];		break;
	case 5:		[theFace addToScript:@"goFrustratedWithLevel:" value:emotionLevel]; [emotionName setString:@"Frus"];		break;
	case 6:		[theFace addToScript:@"goBoredWithLevel:" value:emotionLevel];		[emotionName setString:@"Bored"];		break;
	case 7:		[theFace addToScript:@"goSadWithLevel:" value:emotionLevel];		[emotionName setString:@"Sad"];			break;
	case 8:		[theFace addToScript:@"goInterestedWithLevel:" value:emotionLevel];	[emotionName setString:@"Interested"];	break;	
	case 9:		[theFace addToScript:@"goAngryWithLevel:" value:emotionLevel];		[emotionName setString:@"Anger"];		break;	
	case 10:	[theFace addToScript:@"goSurpriseWithLevel:" value:emotionLevel];   [emotionName setString:@"surprise"];	break;	
	}
}
// ******************************************************************************************
- (void)mouseDragged:(NSEvent *)theEvent	
{
[theFace mouseDragged:theEvent view:self];
}
// ******************************************************************************************
- (void)mouseUp:(NSEvent *)theEvent	
{
[theFace mouseUp:theEvent view:self];
}
// ******************************************************************************************
- (void)mouseDown:(NSEvent *)theEvent	
{
[theFace mouseDown:theEvent view:self];
}
// ******************************************************************************************
@end
