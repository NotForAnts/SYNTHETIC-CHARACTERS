// ******************************************************************************************
//  WXSCFacialExpressionEyeBrow
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************

#import "WXSCFacialExpressionEyeBrow.h"


@implementation WXSCFacialExpressionEyeBrow
// ******************************************************************************************
-(id)		initBrowAt:(float)x y:(float)y name:(NSString*)name view:(NSView*)view direction:(float)direction
{
if(self=[super initAt:x y:y])
	{
	currentAngle=0;
	

	
	rotateImage=[[WXGraphicRotatedNSImage alloc]initRImage:name];
	
	if(direction>0)
		[rotateImage setPivot:-22 yp:-7];
	else
		[rotateImage setPivot:22 yp:-7];
	
	
	moodType=0;
	angleMult=direction;
	angleChange=5;
	
	

	trag1=[[WXSCFaceExpressionTragectory alloc]initWithValue:360];
	trag2=[[WXSCFaceExpressionTragectory alloc]init];
	trag3=[[WXSCFaceExpressionTragectory alloc]init];

	}
return self;
}
// ******************************************************************************************
-(void)		goHappyWithLevel:(NSNumber*)level			
{  
//[self setAngleTo:0 ydisp:0 xdisp:0];
[trag1 setAimTo:360 steps:3];
[trag2 setAimTo:0 steps:3];
[trag3 setAimTo:0 steps:3];  
}
// ******************************************************************************************
-(void)		goSadWithLevel:(NSNumber*)level				
{   
[trag1 setAimTo:345-[level floatValue]*20 steps:12];
[trag2 setAimTo:10+13*[level floatValue] steps:12];
[trag3 setAimTo:10*[level floatValue] steps:12];
}
// ******************************************************************************************
-(void)		goNeutralWithLevel:(NSNumber*)level			
{ 
//[self setAngleTo:0 ydisp:0 xdisp:0];

[trag1 setAimTo:360 steps:1];
[trag2 setAimTo:0 steps:1];
[trag3 setAimTo:0 steps:1];  
}
// ******************************************************************************************
-(void)		goFrustratedWithLevel:(NSNumber*)level		{   }
// ******************************************************************************************
-(void)		goAngryWithLevel:(NSNumber*)level			
{   
[trag1 setAimTo:345-[level floatValue]*3 steps:4];		// angle
//[self setAngleTo:0 ydisp:0 xdisp:0];
[trag2 setAimTo:10-4*[level floatValue] steps:4];		// cx
[trag3 setAimTo:-2*[level floatValue] steps:4];			// cy
}
// ******************************************************************************************
-(void)		goTiredWithLevel:(NSNumber*)level			
{   
[trag1 setAimTo:345-[level floatValue]*10 steps:10];
[trag2 setAimTo:10+5*[level floatValue] steps:10];
[trag3 setAimTo:5*[level floatValue] steps:10];
}
// ******************************************************************************************
-(void)		goInterestedWithLevel:(NSNumber*)level		{   }
-(void)		goBoredWithLevel:(NSNumber*)level			{   }
// ******************************************************************************************
-(void)		goFearWithLevel:(NSNumber*)level
{
float lvl=1.0;
//lvl=[level floatValue];

[trag1 setAimTo:345-lvl*20 steps:1];		// angle
[trag2 setAimTo:10+8*lvl steps:1];		// cx
[trag3 setAimTo:10+13*lvl steps:1];			// cy
}
// ******************************************************************************************

-(void)		goSurpriseWithLevel:(NSNumber*)level
{
float lvl=1.0;
//lvl=[level floatValue];

[trag1 setAimTo:345-lvl*20 steps:1];		// angle
[trag2 setAimTo:10+8*lvl steps:1];		// cx
[trag3 setAimTo:10+13*lvl steps:1];			// cy
}
// ******************************************************************************************
-(void) doDraw
{
[rotateImage showAtPointRotatePoint:NSMakePoint(xpos+cxdisp*angleMult,ypos+cydisp) angle:(float)WXUDegreeToRadian(currentAngle*angleMult)]; 
}
// ******************************************************************************************
-(void)		doAnimate
{
BOOL done=[trag1 doUpdate:&currentAngle];
[trag2 doUpdate:&cxdisp];
[trag3 doUpdate:&cydisp];

}
// ******************************************************************************************

@end
