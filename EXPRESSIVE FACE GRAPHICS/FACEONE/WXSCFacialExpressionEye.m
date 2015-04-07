// ******************************************************************************************
//  WXSCFacialExpressionEye
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************

#import "WXSCFacialExpressionEye.h"


@implementation WXSCFacialExpressionEye
// ******************************************************************************************
-(id)		initAt:(float)x y:(float)y
{
if(self=[super initAt:x y:y])
	{
	eye1=[self doLoadImage:@"eye1.gif"];
	eyeWhite1=[self doLoadImage:@"eyeWhite1.gif"];
	edge1=[self doLoadImage:@"eyeEdge1.gif"];
	eyeClose1=[self doLoadImage:@"eyeClose1.gif"];
	
	eye2=[self doLoadImage:@"eye2.gif"];
	eyeWhite2=[self doLoadImage:@"eyeWhite2.gif"];
	edge2=[self doLoadImage:@"eyeEdge2.gif"];
	eyeClose2=[self doLoadImage:@"eyeClose2.gif"];
	eyeBall=[self doLoadImage:@"eyeBall.gif"];
	
	eyeRect=NSMakeRect(0,0,[eye1 size].width,[eye1 size].height);
	closeRect=NSMakeRect(0,0,[eyeClose1 size].width,[eyeClose1 size].height);
	
	ex1=xpos-70-[eye1 size].width/2;
	ex2=xpos+70-[eye1 size].width/2;
	
	ballXDisp=0;		ballYDisp=0;
	ballXD=1.0;			ballYD=0.2;
	ballXSpeed=1.0;		movePause=0;	ballMaxY=16;	ballMinY=-10;
	ballXSpeedMult=1.0;
	
	closey1=137;			closeyd=8.0;
	shutSpeed=12;
	blinkChance=100;	blinkSpeed=10;
	
	minClosePosition=137;
	
	eyePlacement=0;
	
	
	ballTrag1=[[WXSCFaceExpressionTragectory alloc]init];
	ballTrag2=[[WXSCFaceExpressionTragectory alloc]init];
	blinkTrag=[[WXSCFaceExpressionTragectory alloc]initWithValue:closey1];
	}
return self;
}
// ******************************************************************************************
// DEFINE THINGS ACCORDING TO EMOTION
// ******************************************************************************************
-(void)		goHappyWithLevel:(NSNumber*)level			
{   
[self resetToNormal];
}
// ******************************************************************************************
-(void)		goSadWithLevel:(NSNumber*)level				
{  
minClosePosition=16;	[blinkTrag setAimTo:minClosePosition steps:7];
blinkChance=2; blinkSpeed=5;

ballMaxY=-5;
ballMinY=-12;
eyePlacement=1;
ballXSpeedMult=0.2;
currentEmotion=2;

[ballTrag1 setAimTo:10 steps:4];
[ballTrag2 setAimTo:-10 steps:4];
}
// ******************************************************************************************
-(void)		goFearWithLevel:(NSNumber*)level
{
[self resetToNormal];
ballMaxY=-5;
ballMinY=-12;
eyePlacement=0;
ballXSpeedMult=0.2;
currentEmotion=-1;

[ballTrag1 setAimTo:10 steps:1];
[ballTrag2 setAimTo:0 steps:1];
}
// ******************************************************************************************
-(void)		goSurpriseWithLevel:(NSNumber*)level
{
[self resetToNormal];
ballMaxY=-5;
ballMinY=-12;
eyePlacement=1;
ballXSpeedMult=0.2;
currentEmotion=-1;

[ballTrag1 setAimTo:10 steps:1];
[ballTrag2 setAimTo:0 steps:1];
}
// ******************************************************************************************
-(void)		goNeutralWithLevel:(NSNumber*)level			
{   
[self resetToNormal];


ballMaxY=16;
ballMinY=-10;
eyePlacement=1;
minClosePosition=137;
ballXSpeedMult=1.0;
currentEmotion=0;
ballYD=0.5;
[ballTrag1 setAimTo:10 steps:4];
[ballTrag2 setAimTo:5 steps:4];
}
// ******************************************************************************************
-(void)		goFrustratedWithLevel:(NSNumber*)level		
{   
}
// ******************************************************************************************
-(void)		goAngryWithLevel:(NSNumber*)level			
{   
[self resetToNormal];
}
// ******************************************************************************************
-(void)		goTiredWithLevel:(NSNumber*)level			
{   
[self resetToNormal];
minClosePosition=20-([level floatValue]*10); [blinkTrag setAimTo:minClosePosition steps:5];
blinkChance=2;  blinkSpeed=20;
}
// ******************************************************************************************
-(void)		goInterestedWithLevel:(NSNumber*)level		
{  
 }
// ******************************************************************************************
-(void)		goBoredWithLevel:(NSNumber*)level			
{   
}
// ******************************************************************************************
-(void)		resetToNormal
{
minClosePosition=137;   [blinkTrag setAimTo:minClosePosition steps:7];
blinkChance=100;	blinkSpeed=10;
eyePlacement=1;
}
// ******************************************************************************************
// DRAW STUFF
// ******************************************************************************************
-(void) doDraw
{
//[[NSColor blackColor]set];
//NSBezierPath	*path=[[NSBezierPath alloc]init];
//[path appendBezierPathWithRect:NSMakeRect(ex1+10,0,20,500)];
//[path fill];
float xd;

switch(eyePlacement)
	{
	case 0:
		[eyeWhite2 drawAtPoint:NSMakePoint(ex1,ypos) fromRect:eyeRect operation:NSCompositeSourceOver fraction:1.0];
		[eyeBall compositeToPoint:NSMakePoint(ex1+20+ballXDisp,ypos+5+ballYDisp) fromRect:eyeRect operation:NSCompositeSourceAtop fraction:1.0];
		[edge2 drawAtPoint:NSMakePoint(ex1,ypos) fromRect:eyeRect operation:NSCompositeSourceOver fraction:1.0];
		[eyeClose2 drawAtPoint:NSMakePoint(ex1,ypos+closey1) fromRect:closeRect operation:NSCompositeSourceAtop fraction:1.0];
		
		[eyeWhite1 drawAtPoint:NSMakePoint(ex2,ypos) fromRect:eyeRect operation:NSCompositeSourceOver fraction:1.0];
		[eyeBall compositeToPoint:NSMakePoint(ex2+20+ballXDisp,ypos+5+ballYDisp) fromRect:eyeRect operation:NSCompositeSourceAtop fraction:1.0];
		[edge1 drawAtPoint:NSMakePoint(ex2,ypos) fromRect:eyeRect operation:NSCompositeSourceOver fraction:1.0];
		[eyeClose1 drawAtPoint:NSMakePoint(ex2,ypos+closey1) fromRect:closeRect operation:NSCompositeSourceAtop fraction:1.0];
		break;
		
	case 1:
		xd=0;
		[eyeWhite2 drawAtPoint:NSMakePoint(ex2+xd,ypos) fromRect:eyeRect operation:NSCompositeSourceOver fraction:1.0];
		[eyeBall compositeToPoint:NSMakePoint(ex2+20+ballXDisp+xd,ypos+5+ballYDisp) fromRect:eyeRect operation:NSCompositeSourceAtop fraction:1.0];
		[edge2 drawAtPoint:NSMakePoint(ex2+xd,ypos) fromRect:eyeRect operation:NSCompositeSourceOver fraction:1.0];
		[eyeClose2 drawAtPoint:NSMakePoint(ex2+xd,ypos+closey1) fromRect:closeRect operation:NSCompositeSourceAtop fraction:1.0];
		
		[eyeWhite1 drawAtPoint:NSMakePoint(ex1+xd,ypos) fromRect:eyeRect operation:NSCompositeSourceOver fraction:1.0];
		[eyeBall compositeToPoint:NSMakePoint(ex1+20+ballXDisp+xd,ypos+5+ballYDisp) fromRect:eyeRect operation:NSCompositeSourceAtop fraction:1.0];
		[edge1 drawAtPoint:NSMakePoint(ex1+xd,ypos) fromRect:eyeRect operation:NSCompositeSourceOver fraction:1.0];
		[eyeClose1 drawAtPoint:NSMakePoint(ex1+xd,ypos+closey1) fromRect:closeRect operation:NSCompositeSourceAtop fraction:1.0];
		break;
	}
}
// ******************************************************************************************
-(void)		doEyeBallMoving
{
if([ballTrag1 doUpdate:&ballXDisp])
	{
	switch(currentEmotion)
		{
		case 0:		[ballTrag1 setAimPause:WXURandomInteger(-17,33) steps:WXURandomInteger(10,20) pause:30];		break;  // Neutral
		case 2:		[ballTrag1 setAimTo:WXURandomInteger(5,15) steps:WXURandomInteger(10,20)];						break;  // Sad
		}
	}
	
if([ballTrag2 doUpdate:&ballYDisp])
	{
	switch(currentEmotion)
		{
		case 0:		[ballTrag2 setAimPause:WXURandomInteger(ballMinY,ballMaxY) steps:WXURandomInteger(10,20)pause:30];		break;
		case 2:		[ballTrag2 setAimTo:WXURandomInteger(ballMinY,ballMaxY) steps:WXURandomInteger(10,20)];					break;		
		}
	}	
}
// ******************************************************************************************
-(void)		doEyeLidMoving
{
if(![blinkTrag doUpdate:&closey1])
	{
	
	}
else
	{
	if(closey1<=-6)					[blinkTrag setAimTo:minClosePosition steps:blinkSpeed];
	if(closey1>=minClosePosition && WXUPercentChance(blinkChance))		[blinkTrag setAimTo:-6 steps:blinkSpeed];
	}
}
// ******************************************************************************************
-(void)		doAnimate
{
[self doEyeBallMoving];
[self doEyeLidMoving];
}
// ******************************************************************************************


@end
