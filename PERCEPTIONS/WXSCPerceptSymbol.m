// ******************************************************************************************
//  WXSCPerceptSymbol
//  Created by Paul Webb on Mon Feb 13 2006.
// ******************************************************************************************


#import "WXSCPerceptSymbol.h"


@implementation WXSCPerceptSymbol
// ******************************************************************************************

-(id)   init
{
if(self=[super init])
	{
	currentValue=[[NSMutableString alloc]init];
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[currentValue release];
[super dealloc];
}
// ******************************************************************************************
-(void)		setValue:(id)value		{		[currentValue setString:value];				}
-(float)	floatValue				{		return [currentValue floatValue];			}
-(NSString*)	stringValue			{		return currentValue;						}
// ******************************************************************************************

@end
