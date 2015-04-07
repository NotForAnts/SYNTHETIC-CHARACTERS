// ******************************************************************************************
//  WXSCAnimBodyPartBasic
//  Created by Paul Webb on Tue Jan 17 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>

#import "WXUsefullCode.h"
#import "WXDisplayStrings.h"
#import "WXUsefullFileReadWrite.h"
#import "WXSCAnimImageCollection.h"

@class  WXSCAnimBodyWhole;
// ******************************************************************************************

#define kPivotSize 3
// ******************************************************************************************

@interface WXSCAnimBodyPartBasic : NSObject {

WXSCAnimBodyWhole		*theBody;
WXSCAnimImageCollection *imageCollection;
WXDisplayStrings		*displayString;
//WXSCAnimBodyPartBasic   *refElement;
int						refPointIndex,imageIndexId,joinPartIndex;
int						partNumberIndex;

NSPoint		p1,p2,p3,p4;
NSPoint		lastMouse;

NSPoint		positionPoint;
NSPoint		point1;
NSPoint		point2;

float		scale;
float		angle,angleRange1,angleRange2,opacity,redOpacity;
float		angle90,twoPi;
float		relativeAngle,currentAngle;
float		xshift,yshift,pivotxshift,pivotyshift;
float		xsize,ysize,bxsize,bysize;
BOOL		isJoined,showPivot;
BOOL		useRelativeToJoin,inDrag,useBlocks,onDisplay,isSelected,useBlockYAsImage;

BOOL		canDragWhole;
BOOL		isDragWhole;
BOOL		positionUpdated;

NSRect		dragRect;

NSBezierPath	*path;
NSImage			*theImage;
NSMutableString *partName;
}

//  manipulation
-(void)		doAngleLimits;
-(BOOL)		hasLimits;

//  accessors
-(void)		setBody:(WXSCAnimBodyWhole*)b;
-(void)		setPartNumberIndex:(int)v;
-(void)		setImageType:(int)v;
-(void)		setXPivot:(float)v;
-(void)		setYPivot:(float)v;
-(void)		setXShift:(float)v;
-(void)		setYShift:(float)v;
-(void)		setPoint1:(float)x y:(float)y;
-(void)		setXPos:(float)v;
-(void)		setYPos:(float)v;
-(void)		setIsAbsoluteAngle:(BOOL)v;
-(void)		setIsJoined:(BOOL)v;
-(void)		setJoinPartTo:(int)v;
-(void)		setShowPivot:(BOOL)v;

-(int)		getPartNumberIndex;
-(NSPoint)  getPoint1;
-(float)	getAngleRadians;
-(BOOL)		nameIs:(NSString*)name;
-(float)	getAngle;
-(BOOL)		isSelected;
-(float)	pivotX;
-(float)	pivotY;
-(float)	shiftX;
-(float)	shiftY;
-(float)	positionX;
-(float)	positionY;
-(int)		joinIndex;
-(BOOL)		isJoined;
-(BOOL)		isAbsAngle;
-(int)		imageIndexId;
-(float)	getDistanceFrom:(NSPoint)loc;
-(void)		setSelected:(BOOL)state;
-(void)		setImageCollection:(id)v;
-(void)		adjustImagesAsRemoved:(int)index;
-(void)		adjustJoinsAsDeletePartAtIndex:(int)index;

// definint
-(void)		setImage:(NSImage*)ir imageId:(int)imageId;
-(void)		setName:(NSString*)name;
-(void)		setUseBlocks:(BOOL)state;
-(void)		setOnDisplay:(BOOL)state;
-(void)		setJoinShift:(float)xs ys:(float)ys;
-(void)		setPivotShift:(float)xs ys:(float)ys;
-(void)		setOnlyRefElement:(WXSCAnimBodyPartBasic*)e;
-(void)		setRefElement:(int)rindex index:(int)index;
-(void)		setPoint1:(NSPoint)p;
-(void)		setDegreeAngle:(float)a;
-(void)		setRadianAngle:(float)a;
-(void)		setFreedomDegree:(float)d1 d2:(float)d2;
-(void)		setSize:(float)x y:(float)y;
-(void)		setRelative:(BOOL)r;
-(void)		setCanDragWhole:(BOOL)state;
-(void)		setJoinPointIndex:(int)v;
-(BOOL)		onDisplay;

// drawing
-(void)		drawBlockWithScale:(float)scale xd:(float)xd yd:(float)yd;
-(void)		draw;
-(void)		drawWithOpacity:(float)op red:(float)red;
-(void)		drawPivot;
-(void)		drawFrameBox;
-(NSPoint)  calcPointAroundPoint:(float)xs ys:(float)ys point:(NSPoint)point;
-(NSPoint)  calcPointAroundPointWithPivotShift:(float)xs ys:(float)ys point:(NSPoint)point;
-(void)		updatePositions;
-(void)		updateFrameBox;
-(void)		drawInfoAt:(float)ypos;

-(void) deSelect;
-(void) doMouseUp:(NSPoint)loc;
-(BOOL) doMouseDown:(NSPoint)loc;
-(void) doMouseDragged:(NSPoint)loc flag:(unsigned int)flag;

// LOAD SAVE
-(void) writeDataUsing:(WXUsefullFileReadWrite*)reader;
// ******************************************************************************************

@end
