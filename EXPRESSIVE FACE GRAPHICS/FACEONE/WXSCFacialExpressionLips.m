// ******************************************************************************************
//  WXSCFacialExpressionLips
//  Created by Paul Webb on Thu Feb 16 2006.
// ******************************************************************************************
#import "WXSCFacialExpressionLips.h"

// ******************************************************************************************

@implementation WXSCFacialExpressionLips


// ******************************************************************************************
-(id)		initAt:(float)x y:(float)y
{
if(self=[super initAt:x y:y])
	{
	theMouthShape=[[NSMutableArray alloc]init];
	theLipShape=[[NSMutableArray alloc]init];
	topLip=[[NSMutableArray alloc]init];
	baseLip=[[NSMutableArray alloc]init];
	openShape=[[NSMutableArray alloc]init];
	
	controlPoints=[[NSMutableArray alloc]init];
	[self makeLipShapes];
	[self makeLipControlPoints];
	
	closeTrag=[[WXSCFaceExpressionTragectory alloc]initWithValue:0];
	topLipTrag=[[WXSCFaceExpressionTragectory alloc]initWithValue:0];
	ovalTrag=[[WXSCFaceExpressionTragectory alloc]initWithValue:0];
	openTrag=[[WXSCFaceExpressionTragectory alloc]initWithValue:0];
	mouthWidthTrag=[[WXSCFaceExpressionTragectory alloc]initWithValue:0];	
	
	
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
//[topLipUpper release];
//[topLipLower release];
//[baseLipUpper release];
//[baseLipLower release];
[super dealloc];
}

// ******************************************************************************************
// EXPRESSIONS
// ******************************************************************************************
-(void)		goHappyWithLevel:(NSNumber*)level
{
[ovalTrag  setAimTo:0 steps:2];
[closeTrag setAimTo:1.0-[level floatValue] steps:4];
[self smileTo:-40*[level floatValue] count:5];
//[mouthWidthTrag  setAimTo:0 steps:2];
}
// ******************************************************************************************
-(void)		goNeutralWithLevel:(NSNumber*)level			
{   
[self neutralTo:10];
}
// ******************************************************************************************
-(void)		goFrustratedWithLevel:(NSNumber*)level		{   }
// ******************************************************************************************
-(void)		goAngryWithLevel:(NSNumber*)level			
{   
[closeTrag setAimTo:0.9-[level floatValue]*0.8 steps:2];
[self smileTo:0 count:5];
}
// ******************************************************************************************
-(void)		goTiredWithLevel:(NSNumber*)level			
{   
[closeTrag setAimTo:0.9-[level floatValue]*0.8 steps:2];
[self smileTo:0 count:5];
}
// ******************************************************************************************
-(void)		goInterestedWithLevel:(NSNumber*)level		{   }
-(void)		goBoredWithLevel:(NSNumber*)level			{   }
// ******************************************************************************************
-(void)		goSadWithLevel:(NSNumber*)level
{
[closeTrag setAimTo:0.9 steps:2];
[self smileTo:20*[level floatValue] count:2];
}
// ******************************************************************************************
-(void)		goFearWithLevel:(NSNumber*)level
{
[closeTrag setAimTo:0.9-[level floatValue]*0.2 steps:1];
[self smileTo:70*[level floatValue] count:2];
}
// ******************************************************************************************
-(void)		goSurpriseWithLevel:(NSNumber*)level
{
[ovalTrag  setAimTo:20+[level floatValue]*10.0 steps:1];
[closeTrag setAimTo:0.9-[level floatValue]*0.2 steps:1];
[self smileTo:0 count:2];
}
// ******************************************************************************************
-(void)			neutralTo:(int)count
{
[self smileTo:0 count:count];
[ovalTrag setAimTo:0 steps:count];
[closeTrag setAimTo:1.0 steps:count];


//[openTrag setAimTo:disp steps:count];
//[topLipTrag setAimTo:disp steps:count];
}
// ******************************************************************************************
-(void)			resetToNormal
{
}
// ******************************************************************************************


// ******************************************************************************************
// SMILE THING
// ******************************************************************************************
-(void)			smileTo:(float)disp count:(int)count
{
[mover1 displaceByPixels:disp yd:-disp count:count];				// top left
[mover2 displaceByPixels:-disp yd:-disp count:count];				// top right
[mover3 displaceByPixels:-disp yd:-disp*2 count:count];				// bottom left
[mover4 displaceByPixels:disp yd:-disp*2 count:count];				// bottom right
}
// ******************************************************************************************
-(void)		moveCloseLipAnimated
{
if(![closeTrag doUpdate:&closeDisp]);
	[self moveCloseLips:closeDisp];
}
// ******************************************************************************************
-(void)		doMouthWidthTrag
{
return;
int t,npoint;
float level;
if(![mouthWidthTrag doUpdate:&widthDisplace])
	{
	npoint=[line1 count];
	for(t=0;t<npoint;t++)
		{
		level=WXUTopBottomSineNormalise(t,0,npoint-1,-1,1)*widthDisplace;
		[[line1 objectAtIndex:t] setXDisplacement:level];
		}
		
	npoint=[line2 count];
	for(t=0;t<npoint;t++)
		{
		level=WXUTopBottomSineNormalise(t,0,npoint-1,-1,1)*widthDisplace;
		[[line2 objectAtIndex:t] setXDisplacement:level];
		}
	
	npoint=[line3 count];
	for(t=0;t<npoint;t++)
		{
		level=WXUTopBottomSineNormalise(t,0,npoint-1,-1,1)*widthDisplace;
		[[line3 objectAtIndex:t] setXDisplacement:level];
		}

	npoint=[line4 count];
	for(t=0;t<npoint;t++)
		{
		level=WXUTopBottomSineNormalise(t,0,npoint-1,-1,1)*widthDisplace;
		[[line4 objectAtIndex:t] setXDisplacement:level];
		}		
												
	}
}
// ******************************************************************************************
-(void)		moveOpen
{
int t;
float   value;
if(![openTrag doUpdate:&value])

	{
	jawDisp=value*0.2;	
	jawDisp=value;

	for(t=0;t<[line1 count]-0;t++)
		[[line1 objectAtIndex:t] contractReturnMassToPoint:NSMakePoint(xpos,ypos) xpercent:100+value*0.4 ypercent:100-value*1.0];	
		
	for(t=0;t<[line4 count]-0;t++)
		[[line4 objectAtIndex:t] contractReturnMassToPoint:NSMakePoint(xpos,ypos) xpercent:100+value*0.4 ypercent:100-value*0.5];	
		
	for(t=0;t<[line2 count]-0;t++)
		[[line2 objectAtIndex:t] contractReturnMassToPoint:NSMakePoint(xpos,ypos) xpercent:100+value*0.4 ypercent:100-value*1.7];	
		
	for(t=0;t<[line3 count]-0;t++)
		[[line3 objectAtIndex:t] contractReturnMassToPoint:NSMakePoint(xpos,ypos) xpercent:100+value*0.4 ypercent:100-value*0.6];							
	
	}

}
// ******************************************************************************************
-(void)		moveOval
{
int t;
//[ovalTrag doUpdate:&ovalDisp];
if(![ovalTrag doUpdate:&ovalDisp])
	{
	}
//	{
//	for(t=0;t<[theLipShape count]-0;t++)
//		[[theLipShape objectAtIndex:t]  contractReturnMassToPoint:NSMakePoint(xpos,ypos) xpercent:100-ovalDisp ypercent:100-ovalDisp*0.5];	
//	}
	
}
// ******************************************************************************************
-(void)		moveTopLip
{
int t;
float   value;

if(![topLipTrag doUpdate:&value])
	{
	for(t=0;t<[line1 count]-0;t++)
		[[line1 objectAtIndex:t] setYDisplacement:value];
	
	for(t=0;t<[line4 count]-0;t++)
		[[line4 objectAtIndex:t] setYDisplacement:value];		
	}

}
// ******************************************************************************************
-(void)		moveCloseLips:(float)closeAmmont
{
float   level;
int		t,npoint;

closeDisp=closeAmmont;
// top inner
npoint=[line1 count];
for(t=1;t<[line1 count]-1;t++)							
	{
	level=WXUSmoothSineNormalise(t,0,npoint-1,7,20)*closeAmmont;
	[[line1 objectAtIndex:t] setYDisplacement:-level];
	}

// top outer
npoint=[line4 count];	
for(t=0;t<[line4 count]-0;t++)
	{
	level=WXUSmoothSineNormalise(t,0,npoint-1,2,13)*closeAmmont;
	[[line4 objectAtIndex:t] setYDisplacement:-level];	
	}

// bottom innner
npoint=[line2 count];	
for(t=0;t<[line2 count]-0;t++)
	{
	level=WXUSmoothSineNormalise(t,0,npoint-1,2,15)*closeAmmont;
	level+=jawDisp;
	[[line2 objectAtIndex:t] setYDisplacement:level];
	}

// bottom outer
npoint=[line3 count];	
for(t=0;t<[line3 count]-0;t++)
	{
	level=WXUSmoothSineNormalise(t,0,npoint-1,0,10)*closeAmmont;
	level+=jawDisp;
	[[line3 objectAtIndex:t] setYDisplacement:level];	
	}
		
}

// ******************************************************************************************
-(void)		moveWithJaw:(float)disp
{
int t;
float ovalX=-ovalDisp;
float ovalY=-ovalDisp*0.5;

jawDisp=disp;

/*
	for(t=0;t<[line2 count]-0;t++)
		[[line2 objectAtIndex:t] setYDisplacement:jawDisp];
		
	for(t=0;t<[line3 count]-0;t++)
		[[line3 objectAtIndex:t] setYDisplacement:jawDisp];	
		
*/

[[line1 objectAtIndex:0] setYDisplacement:jawDisp];	
[[line1 lastObject] setYDisplacement:jawDisp];	
[[line4 objectAtIndex:0] setYDisplacement:jawDisp];	
[[line4 lastObject] setYDisplacement:jawDisp];		


for(t=0;t<[theLipShape count]-0;t++)
	{
	[[theLipShape objectAtIndex:t]  contractReturnMassToPoint:NSMakePoint(xpos,ypos) xpercent:100+jawDisp*2+ovalX ypercent:100+ovalY];
	}
	//[[theLipShape objectAtIndex:t]  contractReturnMass:xpos percent:100+jawDisp*2];
}

// ******************************************************************************************
-(void) moveEveryThingInUnison
{
}
// ******************************************************************************************
// DEFINITION
// ******************************************************************************************
-(NSMutableArray*)  makeMassLineArray:(NSPoint)p1 p2:(NSPoint)p2 n:(int)n join:(BOOL)join
{
NSMutableArray  *massShape=[[NSMutableArray alloc]init];
WXSCMassSpring  *mass;
float xp,yp;
int t;

for(t=0;t<n;t++)
	{
	xp=WXUNormalise(t,0,n-1,p1.x,p2.x);
	yp=WXUNormalise(t,0,n-1,p1.y,p2.y);
	mass=[self makeNewMass:NSMakePoint(xp,yp) fix:NO];
	if(t>0) [self doubleConnect:[massShape lastObject] m2:mass];
	[massShape addObject:mass];
	}

return massShape;
}
// ******************************************************************************************
-(void)		connectToShapeMirror:(WXSCMassSpring*)dest i1:(int)i1 i2:(int)i2 shape:(NSMutableArray*)shape strength:(float)strength
{
int t,size=[shape count]-1;
for(t=i1;t<=i2;t++)
	[[shape objectAtIndex:size-t] addConnection:dest spring:strength];
}
// ******************************************************************************************
-(void)		connectToShape:(WXSCMassSpring*)dest i1:(int)i1 i2:(int)i2 shape:(NSMutableArray*)shape strength:(float)strength;
{
int t;
for(t=i1;t<=i2;t++)
	[[shape objectAtIndex:t] addConnection:dest spring:strength];
}
// ******************************************************************************************
-(void) doubleConnect:(WXSCMassSpring*)m1 m2:(WXSCMassSpring*)m2
{
[m1 addConnection:m2 spring:1.0];
[m2 addConnection:m1 spring:1.0];
}
// ******************************************************************************************
-(WXSCMassSpring*)   makeNewMass:(NSPoint)mp  fix:(BOOL)fix
{
WXSCMassSpring *mass=[[WXSCMassSpring alloc]init];
[mass setPosition:mp];
[mass setMass:10];
[mass setFixed:fix];
[mass addReturnMass];
return mass;
}
// ******************************************************************************************
-(void) makeLipControlPoints
{
WXSCMassSpring  *m1;

m1=[self makeNewMass:NSMakePoint(xpos-80,ypos+50) fix:YES]; 
mover1=[[WXSCMassSpringControlPointMover alloc]initForMass:m1];

[self connectToShape:m1 i1:0 i2:0 shape:line1 strength:1.2];
[self connectToShape:m1 i1:0 i2:0 shape:line2 strength:1.2];
[self connectToShape:m1 i1:0 i2:0 shape:line4 strength:1.2];
[controlPoints   addObject:m1]; [m1 release];


m1=[self makeNewMass:NSMakePoint(xpos+80,ypos+50) fix:YES]; 
mover2=[[WXSCMassSpringControlPointMover alloc]initForMass:m1];

[self connectToShapeMirror:m1 i1:0 i2:0 shape:line1 strength:1.2];
[self connectToShapeMirror:m1 i1:0 i2:0 shape:line2 strength:1.2];
[self connectToShapeMirror:m1 i1:0 i2:0 shape:line4 strength:1.2];
[controlPoints   addObject:m1]; [m1 release];


m1=[self makeNewMass:NSMakePoint(xpos-80,ypos-50) fix:YES]; 
mover3=[[WXSCMassSpringControlPointMover alloc]initForMass:m1];

[self connectToShape:m1 i1:0 i2:0 shape:line1 strength:1.2];
[self connectToShape:m1 i1:0 i2:0 shape:line2 strength:1.2];
[self connectToShape:m1 i1:0 i2:0 shape:line3 strength:1.2];
[controlPoints   addObject:m1]; [m1 release];


m1=[self makeNewMass:NSMakePoint(xpos+80,ypos-50) fix:YES]; 
mover4=[[WXSCMassSpringControlPointMover alloc]initForMass:m1];

[self connectToShapeMirror:m1 i1:0 i2:0 shape:line1 strength:1.2];
[self connectToShapeMirror:m1 i1:0 i2:0 shape:line2 strength:1.2];
[self connectToShapeMirror:m1 i1:0 i2:0 shape:line3 strength:1.2];
[controlPoints   addObject:m1];


}
// ******************************************************************************************
-(void) makeLipShapes
{
int number=20;
WXSCMassSpring  *corner1,*corner2;

openness=30;
mouthWide=60;

// top lip
line1=[self makeMassCurveArray:NSMakePoint(xpos-mouthWide,ypos) p2:NSMakePoint(xpos+mouthWide,ypos) d1:3.14 d2:6.28 h:-openness/2 n:number join:YES];
line4=[self makeMassCurveArray:NSMakePoint(xpos-mouthWide,ypos) p2:NSMakePoint(xpos+mouthWide,ypos) d1:3.14 d2:6.28 h:-openness n:number join:YES];

// base lip
line2=[self makeMassCurveArray:NSMakePoint(xpos-mouthWide,ypos) p2:NSMakePoint(xpos+mouthWide,ypos) d1:3.14 d2:6.28 h:openness/2 n:number join:YES];
line3=[self makeMassCurveArray:NSMakePoint(xpos-mouthWide,ypos) p2:NSMakePoint(xpos+mouthWide,ypos) d1:3.14 d2:6.28 h:openness n:number join:YES];

corner1=[line4 objectAtIndex:number/2];
[corner1 setOrigPosition:NSMakePoint([corner1 position].x,[corner1 position].y-3)];
corner1=[line1 objectAtIndex:0];
corner2=[line1 lastObject];


[self doubleConnect:[line2 objectAtIndex:0] m2:corner1];
[self doubleConnect:[line2 lastObject] m2:corner2];
[self doubleConnect:[line3 objectAtIndex:0] m2:corner1];
[self doubleConnect:[line3 lastObject] m2:corner2];
[self doubleConnect:[line4 objectAtIndex:0] m2:corner1];
[self doubleConnect:[line4 lastObject] m2:corner2];

[theLipShape addObjectsFromArray:line1];
[theLipShape addObjectsFromArray:line2];
[theLipShape addObjectsFromArray:line3];
[theLipShape addObjectsFromArray:line4];

// form lips
int t;
[topLip addObjectsFromArray:line1];
for(t=[line4 count]-1;t>=0;t--)
	[topLip addObject:[line4 objectAtIndex:t]];	

// base fill shape	
//[baseLip addObjectsFromArray:line2];
[baseLip addObject:[line1 objectAtIndex:1]];
[baseLip addObject:[line1 objectAtIndex:0]];
for(t=0;t<[line3 count];t++)
	[baseLip addObject:[line3 objectAtIndex:t]];	
[baseLip addObject:[line1 objectAtIndex:19]];
[baseLip addObject:[line1 objectAtIndex:18]];	
for(t=[line2 count]-2;t>=1;t--)
	[baseLip addObject:[line2 objectAtIndex:t]];	

// teeth fill shape	
for(t=1;t<[line1 count]-2;t++)
	[openShape addObject:[line1 objectAtIndex:t]];
	
for(t=[line2 count]-2;t>=2;t--)
	[openShape addObject:[line2 objectAtIndex:t]];	
}

// ******************************************************************************************
-(NSMutableArray*)  makeMassCurveArray:(NSPoint)p1 p2:(NSPoint)p2 d1:(float)d1 d2:(float)d2 h:(float)h n:(int)n join:(BOOL)join
{
NSMutableArray  *massShape=[[NSMutableArray alloc]init];
WXSCMassSpring  *mass;
float xp,yp,degree,yd;
int t;

for(t=0;t<n;t++)
	{
	xp=WXUNormalise(t,0,n-1,p1.x,p2.x);
	yp=WXUNormalise(t,0,n-1,p1.y,p2.y);
	degree=WXUNormalise(t,0,n-1,d1,d2);
	yd=sin(degree)*h;
	
	mass=[self makeNewMass:NSMakePoint(xp,yp+yd) fix:NO];
	if(t>0) [self doubleConnect:[massShape lastObject] m2:mass];
	[massShape addObject:mass];
	}

return massShape;

}
// ******************************************************************************************
// DRAW STUFF
// ******************************************************************************************
-(void) doDraw
{
int t;
NSBezierPath *path;

path=[[NSBezierPath alloc]init];
[path moveToPoint:[[topLip objectAtIndex:0]position]];
for(t=1;t<[topLip count];t++)
	[path lineToPoint:[[topLip objectAtIndex:t]position]];

[path setLineWidth:1.0];
[path closePath];
[path setLineJoinStyle:NSRoundLineJoinStyle];
[[NSColor redColor]set];
[path fill];
[path release];

path=[[NSBezierPath alloc]init];
[path moveToPoint:[[baseLip objectAtIndex:0]position]];
for(t=1;t<[topLip count];t++)
	[path lineToPoint:[[baseLip objectAtIndex:t]position]];

[path setLineWidth:1.0];
[path closePath];
[path setLineJoinStyle:NSRoundLineJoinStyle];
[[NSColor redColor]set];
[path fill];
[path release];
}
// ******************************************************************************************
-(void) doDrawBlack
{
int t;

NSBezierPath *path;

path=[[NSBezierPath alloc]init];
[path moveToPoint:[[openShape objectAtIndex:0]position]];
for(t=1;t<[openShape count];t++)
	[path lineToPoint:[[openShape objectAtIndex:t]position]];

[path setLineWidth:1.0];
[path closePath];
[path setLineJoinStyle:NSRoundLineJoinStyle];
[[NSColor blackColor]set];
[path fill];
[path release];
}
// ******************************************************************************************
-(BOOL)		hasDoneExpression
{
if(![closeTrag isDone])   return NO;
if(![topLipTrag isDone])   return NO;
if(![ovalTrag isDone])   return NO;
if(![openTrag isDone])   return NO;
if(![mover1 isDoneMove])   return NO;
if(![mover2 isDoneMove])   return NO;
if(![mover3 isDoneMove])   return NO;
if(![mover4 isDoneMove])   return NO;

return YES;
}
// ******************************************************************************************
-(void)		doAnimate
{
BOOL isMoving=YES;
int t,count=0;


[self moveTopLip];
[self moveOval];
[self moveOpen];
[self moveCloseLipAnimated];
//[self doMouthWidthTrag];

[mover1 doUpdate];
[mover2 doUpdate];
[mover3 doUpdate];
[mover4 doUpdate];


while(isMoving && count<10)
	{
	isMoving=NO;
	count++;
	for(t=0;t<[theLipShape count];t++)
		{
		[[theLipShape objectAtIndex:t] calcPosition]; 
		isMoving=isMoving | [[theLipShape objectAtIndex:t]isMoving];
		}
	}
}
// ******************************************************************************************


@end
