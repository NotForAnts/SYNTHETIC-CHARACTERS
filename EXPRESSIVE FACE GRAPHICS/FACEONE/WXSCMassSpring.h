// ******************************************************************************************
//  WXSCMassSpring
//  Created by Paul Webb on Wed May 18 2005.
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
// ******************************************************************************************

@interface WXSCMassSpring : NSObject {

NSPoint				position,oposition,rPosition;
float				ydisplacement;
float				mass;
float				xspeed,yspeed;
BOOL				fixed,inDrag,isActive;

float		xdisplacement;

NSMutableArray		*conectionMasses;
NSMutableArray		*conectionSprings;
NSMutableArray		*springLength;

WXSCMassSpring		*returnMass;
}

-(void)		contractReturnMass:(float)xcentre percent:(float)percent;
-(void)		contractReturnMassToPoint:(NSPoint)centre xpercent:(float)xpercent ypercent:(float)ypercent;
-(void)		gotoOriginalPosition;
-(void)		setYDisplacement:(float)yd;
-(void)		setXDisplacement:(float)xd;
-(void)		setNewPosition:(NSPoint)p;
-(void)		setPosition:(NSPoint)p;
-(void)		setOrigPosition:(NSPoint)p;
-(BOOL)		isActive;
-(void)		setIsActive:(BOOL)b;
-(NSPoint)  position;
-(NSPoint)  origposition;
-(BOOL)		fixed;
-(void)		setMass:(float)m;
-(void)		setFixed:(BOOL)b;	
-(void)		addConnection:(WXSCMassSpring*)ms   spring:(float)spring;
-(void)		addReturnMass;
-(BOOL)		isMoving;

-(void)		contract;
-(void)		calcPosition;
-(void)		renderMass;

-(float)	massDistance:(WXSCMassSpring*)m2;
-(float)	distance:(NSPoint)p1 p2:(NSPoint)p2;

- (void)mouseDragged:(NSEvent *)theEvent	view:(NSView*)view;
- (void)mouseUp:(NSEvent *)theEvent		view:(NSView*)view;
- (void)mouseDown:(NSEvent *)theEvent	view:(NSView*)view;

@end
