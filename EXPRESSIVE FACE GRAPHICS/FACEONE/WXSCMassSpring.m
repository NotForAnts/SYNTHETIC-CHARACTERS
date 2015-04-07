// ******************************************************************************************
//  WXSCMassSpring
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************

#import "WXSCMassSpring.h"

// ******************************************************************************************

@implementation WXSCMassSpring

-(id)		init
{
if(self=[super init])
	{
	conectionMasses=[[NSMutableArray alloc]init];
	conectionSprings=[[NSMutableArray alloc]init];
	springLength=[[NSMutableArray alloc]init];
	mass=10;
	fixed=NO;
	inDrag=NO;
	xspeed=0;
	yspeed=0;
	xdisplacement=0;
	isActive=YES;
	}
return self;
}
// ******************************************************************************************
-(BOOL)		isMoving
{
if(xspeed!=0.0)		return YES;
if(yspeed!=0.0)		return YES;
return NO;
}
// ******************************************************************************************
-(void)		setYDisplacement:(float)yd						
{  
rPosition=NSMakePoint(oposition.x,oposition.y+yd);
[returnMass setPosition:NSMakePoint(oposition.x,oposition.y+yd)];
[self setNewPosition:NSMakePoint(oposition.x,oposition.y+yd)];
}
// ******************************************************************************************
-(void)		setXDisplacement:(float)xd						
{  
xdisplacement=xd;
return;
rPosition=NSMakePoint(oposition.x+xd,oposition.y);
[returnMass setPosition:NSMakePoint(oposition.x+xd,oposition.y)];
[self setNewPosition:NSMakePoint(oposition.x+xd,oposition.y)];
}
 // ******************************************************************************************
-(void)		setOrigPosition:(NSPoint)p
{
position=p;		
oposition=p;
[returnMass setPosition:position];
}
 // ******************************************************************************************

-(void)		gotoOriginalPosition;				{   position=oposition;				}
-(void)		setNewPosition:(NSPoint)p			{   position=p;						}
-(void)		setPosition:(NSPoint)p				{   position=p;		oposition=p;	}
-(NSPoint)  position							{   return position;	}
-(NSPoint)  origposition						{   return oposition;   }
-(void)		setMass:(float)m					{   mass=m;				}
-(void)		setFixed:(BOOL)b					{   fixed=b;			}
-(BOOL)		fixed								{   return fixed;		}
-(BOOL)		isActive							{   return isActive;	}
-(void)		setIsActive:(BOOL)b					{   isActive=b;			}
// ******************************************************************************************
-(void)		addConnection:(WXSCMassSpring*)ms   spring:(float)spring
{
[conectionMasses addObject:ms];
[conectionSprings addObject:[NSNumber numberWithFloat:spring]];
[springLength addObject:[NSNumber numberWithFloat:[self massDistance:ms]]];
}

// ******************************************************************************************
-(void)		contractReturnMassToPoint:(NSPoint)centre xpercent:(float)xpercent ypercent:(float)ypercent
{
float xdiff=centre.x-rPosition.x;
float ydiff=centre.y-rPosition.y;
xdiff=xdiff*xpercent/100;
ydiff=ydiff*ypercent/100;
[returnMass setNewPosition:NSMakePoint(centre.x-xdiff,centre.y-ydiff)];
}
// ******************************************************************************************
-(void)		contractReturnMass:(float)xcentre percent:(float)percent
{
float diff=xcentre-rPosition.x;
diff=diff*percent/100;
[returnMass setNewPosition:NSMakePoint(xcentre-diff,rPosition.y)];
}
// ******************************************************************************************
-(void)		addReturnMass
{
returnMass=[[WXSCMassSpring alloc]init];
[returnMass setPosition:position];
[returnMass setFixed:YES];
[self addConnection:returnMass spring:1.0];
rPosition=position;
}
// ******************************************************************************************
-(void)		contract
{
int t;
float   slength;
for(t=0;t<[conectionMasses count];t++)
	{
	slength=[[springLength objectAtIndex:t]floatValue];
	slength=slength*0.5;
	[springLength replaceObjectAtIndex:t withObject:[NSNumber numberWithFloat:slength]];
	}
}
// ******************************************************************************************
-(void)		calcPosition
{
int t;
float   cdistance,slength,difference,xd,yd,xc,yc,angle;
float   force,percent;
NSPoint p1;

if(fixed)
	{
	return;
	}


WXSCMassSpring  *m2;
for(t=0;t<[conectionMasses count];t++)
	{
	m2=[conectionMasses objectAtIndex:t];
	percent=[[conectionSprings objectAtIndex:t]floatValue];
	if([m2 isActive])
		{
		p1=[m2 position];
		xd=position.x-p1.x; 
		yd=position.y-p1.y;
		slength=[[springLength  objectAtIndex:t]floatValue];
		cdistance=[self massDistance:m2];
		difference=cdistance-slength;
		if(difference>20.0) difference=20.0;
		if(difference<-100.0) difference=-100.0;
		if(difference>0)
			{
			force=(difference*difference)*0.01;
			force=force*percent;
			if(xd==0.0) xd=0.0001;
			angle=atan(yd/xd);
			xc=force*cos(angle);
			yc=force*sin(angle);
			if(xd>0.0)			{	xc*=-1;		yc*=-1; }

			xspeed+=xc;		
			yspeed+=yc;		
			}
		}
	}
	

position.x+=xspeed;
position.x+=xdisplacement;
position.y+=yspeed;	

xspeed=xspeed*0.68;	
yspeed=yspeed*0.68;	
}
// ******************************************************************************************
-(void)		renderMass
{
int t;
WXSCMassSpring  *m2;



//[[NSColor redColor]set];
//NSRectFill(NSMakeRect(oposition.x-2,oposition.y-2,4,4));
[[NSColor blueColor]set];
if(fixed) [[NSColor lightGrayColor]set];
//if(fixed) [[NSColor blackColor]set];
if(!fixed) NSFrameRect(NSMakeRect(position.x-2,position.y-2,4,4));
if(fixed) NSFrameRect(NSMakeRect(position.x-2,position.y-2,8,8));

[[NSColor whiteColor]set];
for(t=0;t<[conectionMasses count];t++)
	{
	m2=[conectionMasses objectAtIndex:t];
	if(![m2 fixed])		[NSBezierPath setDefaultLineWidth:1.0];
	if(![m2 fixed])		[NSBezierPath strokeLineFromPoint:position toPoint:[m2 position]];
	[NSBezierPath setDefaultLineWidth:1.0];	
	}
}
// ******************************************************************************************
-(float)	massDistance:(WXSCMassSpring*)m2
{
NSPoint p2;
p2=[m2 position];
return [self distance:position p2:p2];
}
// ******************************************************************************************
-(float)	distance:(NSPoint)p1 p2:(NSPoint)p2
{
float   xd=p1.x-p2.x;
float   yd=p1.y-p2.y;
return sqrt(xd*xd+yd*yd);
}
// ******************************************************************************************
- (void)mouseDragged:(NSEvent *)theEvent	view:(NSView*)view
{
if(!fixed) return;
NSPoint mouseLoc=[view convertPoint:[theEvent locationInWindow] fromView:nil];
if(inDrag)  position=mouseLoc;

}
// ******************************************************************************************
- (void)mouseUp:(NSEvent *)theEvent		view:(NSView*)view
{
inDrag=NO;
}
// ******************************************************************************************
- (void)mouseDown:(NSEvent *)theEvent	view:(NSView*)view
{
if(!fixed) return;
NSPoint mouseLoc=[view convertPoint:[theEvent locationInWindow] fromView:nil];
NSRect r=NSMakeRect(position.x-4,position.y-4,8,8);

if(NSPointInRect(mouseLoc,r)) inDrag=YES;
}
// ******************************************************************************************

@end
