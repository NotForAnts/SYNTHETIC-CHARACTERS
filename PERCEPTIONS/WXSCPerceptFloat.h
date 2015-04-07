// ******************************************************************************************
//  WXSCPerceptFloat
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>

// ******************************************************************************************

@interface WXSCPerceptFloat : NSObject {

float   currentValue;
}

-(void)			setValue:(id)value;
-(float)		floatValue;
-(NSString*)	stringValue;
// ******************************************************************************************

@end