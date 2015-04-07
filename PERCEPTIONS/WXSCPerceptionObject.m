// ******************************************************************************************
//  WXSCPerceptionObject
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCPerceptionObject.h"

@implementation WXSCPerceptionObject

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	perceptName=[[NSMutableString alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[perceptName release];
[super dealloc];
}
// ******************************************************************************************
-(void)			setValueObject:(id)vo					{   valueObject=vo;						}
-(id)			valueObject								{   return valueObject;					}
-(void)			setPerceptionName:(NSString*)name		{   [perceptName setString:name];		}
-(void)			setPerceptStrength:(float)strength		{   perceptStrength=strength;			}
-(float)		perceptStrength							{   return perceptStrength;				}
-(NSString*)	perceptName								{   return perceptName;					}
-(float)		floatValue								{   return [valueObject floatValue];	}
// ******************************************************************************************
-(float)	updateStrength
{
perceptStrength=perceptStrength-0.001;
return perceptStrength;
}
// ******************************************************************************************

@end
