// ******************************************************************************************
//  WXSCFacialExpressionLipMussle
//  Created by Paul Webb on Thu Feb 16 2006.
// ******************************************************************************************

#import "WXSCFacialExpressionLipMussle.h"


@implementation WXSCFacialExpressionLipMussle

// ******************************************************************************************
-(id)   initAtPoint:(NSPoint)pos
{
if(self=[super init])
	{
	position=NSMakePoint(pos.x,pos.y);
	
	originalPosition=[[NSMutableArray alloc]init];
	pullObjects=[[NSMutableArray alloc]init];
	pullWeights=[[NSMutableArray alloc]init];
	}
return self;
}

// ******************************************************************************************
-(void) addPull:(id)object weight:(float)weight
{
[originalPosition addObject:[[WXNSPointWrapper alloc]initPoint:[object getPoint]]];
[pullObjects addObject:object];
[pullWeights addObject:[NSNumber numberWithFloat:weight]];
}
// ******************************************************************************************
-(void) doPull:(float)level
{
int t;
float xd,yd,weight;
WXNSPointWrapper	*thePoint;
NSPoint aPoint;

for(t=0;t<[pullObjects count];t++)
	{
	weight=[[pullWeights objectAtIndex:t]floatValue];
	thePoint=[pullObjects objectAtIndex:t];
	aPoint=[[originalPosition objectAtIndex:t] getPoint];
	
	xd=aPoint.x-position.x;
	yd=aPoint.y-position.y;
	
	xd=xd*level/100*weight/100;
	yd=yd*level/100*weight/100;
	
	aPoint.x=aPoint.x-xd;
	aPoint.y=aPoint.y-yd;
	
	[thePoint setPoint:aPoint];
	}
}
// ******************************************************************************************

@end
