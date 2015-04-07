// ******************************************************************************************
//  WXSCPerceptFloat
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCPerceptFloat.h"


@implementation WXSCPerceptFloat



// ******************************************************************************************
-(void)		setValue:(id)value		{		currentValue=[value floatValue];			}
-(float)	floatValue				{		return currentValue;						}
-(NSString*)	stringValue			{		return @"N/A";								}
// ******************************************************************************************


@end
