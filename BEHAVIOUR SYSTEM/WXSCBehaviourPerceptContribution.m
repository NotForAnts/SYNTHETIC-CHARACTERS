// ******************************************************************************************
//  WXSCBehaviourPerceptContribution
//  Created by Paul Webb on Thu Feb 09 2006.
// ******************************************************************************************

#import "WXSCBehaviourPerceptContribution.h"


@implementation WXSCBehaviourPerceptContribution

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	perceptBlackboard=nil;
	}
return self;
}

// ******************************************************************************************
-(void)			setPerceptSystem:(id)pc
{
perceptCentre=pc;
perceptBlackboard=[perceptCentre perceptBlackboard];
}
// ******************************************************************************************
-(void)		setContributionName:(NSString*)name				
{	
perceptName=name;
[perceptName retain];	
}
// ******************************************************************************************
-(void)		setAsEqual:(float)value contribution:(float)contribution error:(float)error
{
type=2;
equalValue=value;
contributionValue=contribution;
contributionError=error;

printf("PERCEPT EQUAL CONTRIBUTION MAP = %f %f\n",equalValue,contributionValue,error,contributionError);
}
// ******************************************************************************************
-(void)		setMapper:(NSString*)mapString
{
type=1;
NSArray *map=[mapString componentsSeparatedByString:@" "];
map1=[[map objectAtIndex:0]floatValue];
map2=[[map objectAtIndex:1]floatValue];
range1=[[map objectAtIndex:2]floatValue];
range2=[[map objectAtIndex:3]floatValue];

printf("PERCEPT CONTRIBUTION MAP = %f %f -> %f %f\n",map1,map2,range1,range2);
}
// ******************************************************************************************
-(float)	processContribution
{
contributionObject=nil;
contributionObject=[perceptBlackboard getPerceptObjectOfName:perceptName];
currentLevel=0;
if(contributionObject==nil)
	{
	return currentLevel;
	}
	
perceptLevel=[contributionObject floatValue];
if(perceptLevel<map1)  return 0;


switch(type)
	{
	case 1:	
		currentLevel=WXUNormalise(perceptLevel,map1,map2,range1,range2);
		break;
		
	case 2:
		currentLevel=contributionError;
		if(equalValue==perceptLevel) currentLevel=contributionValue;
		break;
	}
	
return currentLevel;
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString  textAt:pos.x y:pos.y text:perceptName color:[NSColor yellowColor]];

if(contributionObject==nil)
	contributionObject=[perceptBlackboard getPerceptObjectOfName:perceptName];
if(contributionObject==nil)
	{
	[displayString  textAt:pos.x+100 y:pos.y text:@"Not In Blackboard" color:[NSColor yellowColor]];
	}
else
	{
	[displayString floatNumberAt:pos.x+100 y:pos.y value:perceptLevel color:[NSColor yellowColor]];
	[displayString floatNumberAt:pos.x+150 y:pos.y value:currentLevel color:[NSColor yellowColor]];
	}
}
// ******************************************************************************************

@end
