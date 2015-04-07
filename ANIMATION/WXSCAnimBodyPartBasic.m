// ******************************************************************************************
//  WXSCAnimBodyPartBasic
//  Created by Paul Webb on Tue Jan 17 2006.
// ******************************************************************************************

#import "WXSCAnimBodyPartBasic.h"
#import "WXSCAnimBodyWhole.h"

@implementation WXSCAnimBodyPartBasic

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	displayString=[[WXDisplayStrings alloc]init];
	imageIndexId=-1;
	joinPartIndex=-1;
	refPointIndex=-1;
	partNumberIndex=0;
	isSelected=NO;
	showPivot=YES;
	onDisplay=YES;
	useBlocks=NO;
	canDragWhole=YES;
	xshift=yshift=0;
	useBlockYAsImage=YES;
	pivotxshift=pivotyshift=0;
	theImage=nil;
	inDrag=NO;
	angleRange1=angleRange2=0;
	angle90=WXUPIE()/2.0;
	twoPi=WXUPIE()*2.0;
	useRelativeToJoin=YES;
	relativeAngle=0;
	
	point1=NSMakePoint(0,0);
	point2=NSMakePoint(0,0);
	positionPoint=NSMakePoint(0,0);
	isJoined=NO;
	
	path=[[NSBezierPath alloc]init];
	partName=[[NSMutableString alloc]init];
	
	scale=2.0;
	}
return self;
}
// ******************************************************************************************
-(void)		doAngleLimits
{
if(![self hasLimits])	
	{
	if(angle<0) angle=angle+twoPi;
	angle=fmod(angle,twoPi);
	return;
	}

if(angle<angleRange1)  angle= angleRange1;
if(angle>angleRange2)  angle= angleRange2;
}
// ******************************************************************************************
-(BOOL)		hasLimits
{
if(angleRange1==0 && angleRange2==0)	return NO;
return YES;
}
// ******************************************************************************************
-(int)		getPartNumberIndex		{   return partNumberIndex;							}
-(NSPoint)  getPoint1				{   return point1;									}
-(float)	getAngleRadians			{   return currentAngle;							}
-(BOOL)		nameIs:(NSString*)name  {   return [partName isEqualToString:name];			}
-(float)	getAngle				{   return angle;									}
-(BOOL)		isSelected				{   return isSelected;								}
-(NSMutableString*) name			{   return partName;								}
-(float)	pivotX					{   return pivotxshift;								}
-(float)	pivotY					{   return pivotyshift;								}
-(float)	shiftX					{   return xshift;									}
-(float)	shiftY					{   return yshift;									}
-(int)		imageIndexId			{   return imageIndexId;							}
-(float)	positionX				{   return positionPoint.x;							}
-(float)	positionY				{   return positionPoint.y;							}
-(int)		joinIndex				{   return joinPartIndex;							}
-(int)		joinPointIndex			{   return refPointIndex;							}
-(BOOL)		isJoined				{   return isJoined;								}
-(BOOL)		isAbsAngle				{   return !useRelativeToJoin;						}
-(BOOL)		onDisplay				{   return onDisplay;								}
// ******************************************************************************************
-(NSPoint)  getPointForIndex:(int)index
{
switch(index)
	{
	case 1: return point1;  break;
	case 2: return point2;  break;
	case 3: return p1;  break;
	case 4: return p2;  break;
	case 5: return p3;  break;
	case 6: return p4;  break;
	}
	
 return point1;
}

// ******************************************************************************************
-(void)		setJoinShift:(float)xs ys:(float)ys
{
xshift=xs;
yshift=ys;
}
// ******************************************************************************************
-(void)		setPivotShift:(float)xs ys:(float)ys
{
pivotxshift=xs;
pivotyshift=ys;
}
// ******************************************************************************************
-(void)		setPoint1:(float)x y:(float)y   
{  
if(!canDragWhole)   return;
point1.x=x; 
point1.y=y;									
}
// ******************************************************************************************
-(void)		setBody:(WXSCAnimBodyWhole*)b	{   theBody=b;												}
-(void)		setPartNumberIndex:(int)v		{   partNumberIndex=v;										}
-(void)		setImageType:(int)v				{   [imageCollection setImageByIndex:v element:self];		}
-(void)		setXPivot:(float)v				{   pivotxshift=v;							}
-(void)		setYPivot:(float)v				{   pivotyshift=v;							}
-(void)		setXShift:(float)v				{   xshift=v;								}
-(void)		setYShift:(float)v				{   yshift=v;								}
-(void)		setName:(NSString*)name			{   [partName setString:name];				}
-(float)	getDistanceFrom:(NSPoint)loc	{   return  WXUDistancePoints(loc,point2);  }
-(void)		setSelected:(BOOL)state			{   isSelected=state;						}
-(void)		setImageCollection:(id)v		{   imageCollection=v;						}
-(void)		setShowPivot:(BOOL)v			{   showPivot=v;							}
-(void)		setRelative:(BOOL)r				{   useRelativeToJoin=r;					}
-(void)		setCanDragWhole:(BOOL)state		{   canDragWhole=state;						}
-(void)		setXPos:(float)v				{   point1.x=v;	positionPoint.x=v;			}
-(void)		setYPos:(float)v				{   point1.y=v;	positionPoint.y=v;			}
-(void)		setIsAbsoluteAngle:(BOOL)v		{   useRelativeToJoin=!v;					}
-(void)		setXSize:(float)v				{   bxsize=v;	xsize=bxsize;				}
-(void)		setYSize:(float)v				{   bysize=v;	ysize=bysize;				}
-(void)		setJoinPointIndex:(int)v		{   refPointIndex=v;						}
-(void)		setJoinPartTo:(int)v			{   joinPartIndex=v;						}   
-(void)		setOnDisplay:(BOOL)state		{   onDisplay=state;						}
-(void)		setPoint1:(NSPoint)p			{   point1=NSMakePoint(p.x,p.y);			}
-(void)		setRadianAngle:(float)a			{   angle=a;								}
-(void)		setDegreeAngle:(float)a			{   angle=WXUDegreeToRadian(a);				}
// ******************************************************************************************
-(void)		setIsJoined:(BOOL)v				
{   
isJoined=v;	
canDragWhole=!v;		
if(!isJoined)
	{
	point1.x=positionPoint.x;
	point1.y=positionPoint.y;
	}
}
// ******************************************************************************************
-(void)		setUseBlocks:(BOOL)state
{
useBlocks=state;

xsize=bxsize;
ysize=bysize;

if(theImage!=nil & !useBlocks) 
	{
	xsize=[theImage size].width/2;
	ysize=[theImage size].height/2;
	}
}
// ******************************************************************************************
-(void)		setImage:(NSImage*)ir  imageId:(int)imageId
{
imageIndexId=imageId;
theImage=ir;
if(theImage!=nil)
	{
	xsize=[theImage size].width/2;
	ysize=[theImage size].height/2;
	if(useBlockYAsImage) 
		{
		bysize=[theImage size].height/2;
		if(bysize>bxsize)
			bxsize=[theImage size].width/8;
		else
			bxsize=[theImage size].width/2;
		}
	}
[self setUseBlocks:useBlocks];
}

// ******************************************************************************************
-(void)		setRefElement:(int)rindex index:(int)index
{
joinPartIndex=rindex;
refPointIndex=index;
isJoined=YES;
canDragWhole=!isJoined;
}
// ******************************************************************************************
-(void)		setFreedomDegree:(float)d1 d2:(float)d2
{
angleRange1=WXUDegreeToRadian(d1);
angleRange2=WXUDegreeToRadian(d2);
}
// ******************************************************************************************
-(void)		setSize:(float)x y:(float)y 
{
bxsize=x;
bysize=y;
}
// *********************************************************************************************
-(void)		adjustImagesAsRemoved:(int)index
{
if(imageIndexId>index)  imageIndexId--; else
if(imageIndexId==index) imageIndexId=-1;

[self setImageType:imageIndexId];	
}
// *********************************************************************************************
-(void)		adjustJoinsAsDeletePartAtIndex:(int)index
{
if(joinPartIndex==index)
	{
	isJoined=NO;
	joinPartIndex=-1;
	return;
	}
	
if(joinPartIndex>index)	joinPartIndex--;
}
// *********************************************************************************************
// DRAWING AND STUFF
// *********************************************************************************************
-(void)		doDrawImage
{
float   useScale,radAngle;
NSRect  pRect;

NSSize existingSize = [theImage size];
NSSize newSize = NSMakeSize(existingSize.width*2, existingSize.height*2);
NSImage *rotatedImage = [[NSImage alloc] initWithSize:newSize];

[rotatedImage lockFocus];                                                               
[[NSGraphicsContext currentContext]setImageInterpolation:NSImageInterpolationNone];
     
 NSAffineTransform *rotateTF = [NSAffineTransform transform];
 NSPoint centerPoint = NSMakePoint(existingSize.width / 2, existingSize.height / 2);

[rotateTF translateXBy:centerPoint.x yBy:centerPoint.y];
[rotateTF rotateByRadians:currentAngle-angle90];
[rotateTF translateXBy:-centerPoint.x yBy:-centerPoint.y];
[rotateTF concat];

[theImage drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0, 0, existingSize.width, existingSize.height) operation:NSCompositeSourceOver fraction:1.0]; 

[rotatedImage unlockFocus];

radAngle=angle;


float   px1=existingSize.width/4;
float   py1=existingSize.height/4;

float   px2=px1+cos(currentAngle)*existingSize.height/4;
float   py2=py1+sin(currentAngle)*existingSize.height/4;

float   xdiff=px1-px2;
float   ydiff=py1-py2;


float xxshift=-(existingSize.width/4*cos(currentAngle-angle90));
float yyshift=-100/4*sin(currentAngle);

xxshift=-existingSize.width/4-xdiff;
yyshift=-existingSize.height/4-ydiff;
	
useScale=1.0;
pRect=NSMakeRect(point1.x+xxshift,point1.y+yyshift,existingSize.width,existingSize.height);
	

[rotatedImage drawInRect:pRect fromRect:NSMakeRect(0,0,newSize.width,newSize.height) operation:NSCompositeSourceOver fraction:opacity];

	
[rotatedImage release];	
}
// ******************************************************************************************
-(void)		drawInfoAt:(float)ypos
{
float xdata=650;

[displayString textAt:xdata y:ypos text:partName color:[NSColor blueColor]]; ypos=ypos-10;
[displayString textAndFloatAt:xdata y:ypos text:@"angle" value:angle color:[NSColor blackColor]];
}
// ******************************************************************************************
-(void)		drawWithOpacity:(float)op red:(float)red
{
opacity=op;
redOpacity=red;
if(onDisplay)   [self drawFrameBox];

if(inDrag) [[NSColor redColor]set]; else [[NSColor blackColor]set];
if(theImage!=nil && !useBlocks && onDisplay)   [self doDrawImage];
}
// ******************************************************************************************
-(void)		drawPivot
{
if(opacity<1.0) return;
if(!showPivot)   return;
if(inDrag) [[NSColor redColor]set]; else [[NSColor blackColor]set];

[path removeAllPoints];
[path appendBezierPathWithOvalInRect:NSMakeRect(point2.x-kPivotSize,point2.y-kPivotSize,kPivotSize*2,kPivotSize*2)];

[path moveToPoint:NSMakePoint(positionPoint.x-kPivotSize,positionPoint.y)];
[path lineToPoint:NSMakePoint(positionPoint.x+kPivotSize,positionPoint.y)];

[path moveToPoint:NSMakePoint(positionPoint.x,positionPoint.y-kPivotSize)];
[path lineToPoint:NSMakePoint(positionPoint.x,positionPoint.y+kPivotSize)];
[path appendBezierPathWithOvalInRect:NSMakeRect(positionPoint.x-kPivotSize,positionPoint.y-kPivotSize,kPivotSize*2,kPivotSize*2)];

if(canDragWhole)
	{
	[path appendBezierPathWithOvalInRect:NSMakeRect(WXUNormalise(50,0,100,point1.x-5,point2.x-5),WXUNormalise(50,0,100,point1.y,point2.y),10,10)];
	}
[path stroke];
}
// ******************************************************************************************
-(void)		drawBlockWithScale:(float)scale xd:(float)xd yd:(float)yd
{
NSPoint spoint=NSMakePoint(xd+point1.x*scale,yd+point1.y*scale);
NSPoint sp1=[self calcPointAroundPoint:bxsize/2*scale ys:0 point:spoint];
NSPoint sp2=[self calcPointAroundPoint:-bxsize/2*scale ys:0 point:spoint];
NSPoint sp3=[self calcPointAroundPoint:bxsize/2*scale ys:bysize*scale point:spoint];
NSPoint sp4=[self calcPointAroundPoint:-bxsize/2*scale ys:bysize*scale point:spoint];

[[NSColor colorWithDeviceRed:0 green:0 blue:1.0 alpha:1.0] set];
[path removeAllPoints];
[path moveToPoint:sp1];
[path lineToPoint:sp2];
[path lineToPoint:sp4];
[path lineToPoint:sp3];
[path closePath];
[path fill];

[[NSColor colorWithDeviceRed:0 green:0 blue:0.0 alpha:opacity] set];
[path stroke];
}
// ******************************************************************************************
-(void)		drawFrameBox
{
if(theImage!=nil && !useBlocks)   return;

if(isSelected)
	[[NSColor colorWithDeviceRed:redOpacity green:1.0 blue:1.0 alpha:opacity] set];
else
	[[NSColor colorWithDeviceRed:redOpacity green:0 blue:1.0 alpha:opacity] set];	


[path removeAllPoints];
[path moveToPoint:p1];
[path lineToPoint:p2];
[path lineToPoint:p4];
[path lineToPoint:p3];
[path closePath];
[path fill];

[[NSColor colorWithDeviceRed:0 green:0 blue:0.0 alpha:opacity] set];
[path stroke];
}
// ******************************************************************************************
-(void)		prepareUpdate
{
positionUpdated=NO;
}

// ******************************************************************************************
-(void)		updatePositionsSelfCall
{
WXSCAnimBodyPartBasic   *refElement;
if(positionUpdated) return;
positionUpdated=YES;
if(isJoined)
	{
	refElement=[theBody elementAtIndex:joinPartIndex];
	if(refElement!=self) [refElement updatePositionsSelfCall];
	}
	
[self updatePositions];	

}
// ******************************************************************************************
-(void)		updatePositions
{
float   xp,yp;
WXSCAnimBodyPartBasic   *refElement=nil;

if(isJoined && joinPartIndex>=0 && refPointIndex>=0)
	{
	refElement=[theBody elementAtIndex:joinPartIndex];
	if(refElement==self) refElement=nil;
	else
		{
		point1=[refElement getPointForIndex:refPointIndex];
		if(useRelativeToJoin)   relativeAngle=[refElement getAngleRadians];
		}
	}

currentAngle=angle+relativeAngle;

positionPoint.x=point1.x;
positionPoint.y=point1.y;

if((xshift!=0 || yshift!=0) && refElement!=nil && isJoined)
	{
	point1=[refElement calcPointAroundPoint:xshift ys:yshift point:point1];
	}

if(isJoined)
	point1=[self calcPointAroundPointWithPivotShift:0 ys:0 point:point1];


xp=point1.x+cos(currentAngle)*ysize;
yp=point1.y+sin(currentAngle)*ysize;

point2.x=xp;
point2.y=yp;

[self updateFrameBox];
}
// ******************************************************************************************
-(void)		updateFrameBox
{
p1=[self calcPointAroundPoint:xsize/2 ys:0 point:point1];
p2=[self calcPointAroundPoint:-xsize/2 ys:0 point:point1];
p3=[self calcPointAroundPoint:xsize/2 ys:ysize point:point1];
p4=[self calcPointAroundPoint:-xsize/2 ys:ysize point:point1];
}
// ******************************************************************************************
-(NSPoint)  calcPointAroundPointWithPivotShift:(float)xs ys:(float)ys point:(NSPoint)point
{
float    x=point.x,y=point.y;

x=x+cos(currentAngle)*(ys+pivotyshift);
y=y+sin(currentAngle)*(ys+pivotyshift);
x=x+cos(currentAngle+angle90)*xs;
y=y+sin(currentAngle+angle90)*xs;
return NSMakePoint(x,y);
}
// ******************************************************************************************
-(NSPoint)  calcPointAroundPoint:(float)xs ys:(float)ys point:(NSPoint)point
{
float    x=point.x,y=point.y;

x=x+cos(currentAngle)*ys;
y=y+sin(currentAngle)*ys;
x=x+cos(currentAngle+angle90)*xs;
y=y+sin(currentAngle+angle90)*xs;
return NSMakePoint(x,y);
}
// ******************************************************************************************
-(void) doMouseUp:(NSPoint)loc
{
inDrag=NO;
}

// ******************************************************************************************
-(void) deSelect
{
isSelected=NO;
isDragWhole=NO;
}
// ******************************************************************************************
-(BOOL) doMouseDown:(NSPoint)loc
{
dragRect=NSMakeRect(point2.x-kPivotSize,point2.y-kPivotSize,kPivotSize*2,kPivotSize*2);
lastMouse=loc;
isSelected=NO;
isDragWhole=NO;
if(NSPointInRect(loc,dragRect)) 
	{
	inDrag=YES;
	isSelected=YES;
	return YES;
	}

if(canDragWhole)
	{
	dragRect=NSMakeRect(WXUNormalise(50,0,100,point1.x-5,point2.x-5),WXUNormalise(50,0,100,point1.y,point2.y),10,10);
	if(NSPointInRect(loc,dragRect)) 
		{
		isDragWhole=YES;
		isSelected=YES;
		return YES;
		}	
	}
return NO;
}
// ******************************************************************************************
-(void) doMouseDragged:(NSPoint)loc flag:(unsigned int)flag
{
float   xd,yd;
if(isDragWhole)				
	{
	
	xd=loc.x-lastMouse.x;
	yd=loc.y-lastMouse.y;
	point1.x+=xd;
	point1.y+=yd;
	lastMouse=loc;
	return;
	}


if(!inDrag) return;

float   tangle=WXUAngleOfPointToPoint(point1,loc),dangle;

dangle=WXUDegreeToRadian(tangle)-relativeAngle;
if(dangle<0) dangle+=twoPi;
angle=dangle;
[self doAngleLimits];
}
// ******************************************************************************************
// LOAD SAVE
// ******************************************************************************************
-(void) writeDataUsing:(WXUsefullFileReadWrite*)reader
{
[reader writeInteger:point1.x];
[reader writeInteger:point1.y];
[reader writeInteger:refPointIndex];
[reader writeInteger:imageIndexId];
[reader writeInteger:joinPartIndex];
[reader writeFloat:angle];
[reader writeFloat:xshift];
[reader writeFloat:yshift];
[reader writeFloat:pivotxshift];
[reader writeFloat:pivotyshift];
[reader writeFloat:bxsize];
[reader writeFloat:bysize];
[reader writeBool:isJoined];
[reader writeBool:useRelativeToJoin];
[reader writeBool:onDisplay];
[reader writeString:partName];
}
// ******************************************************************************************

@end
