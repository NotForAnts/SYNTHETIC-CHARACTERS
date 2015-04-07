// ******************************************************************************************
//  WXSCPerceptSymbol
//  Created by Paul Webb on Mon Feb 13 2006.
// ******************************************************************************************

#import <Foundation/Foundation.h>

// ******************************************************************************************

@interface WXSCPerceptSymbol : NSObject {

NSMutableString   *currentValue;
}

-(void)			setValue:(id)value;
-(float)		floatValue;
-(NSString*)	stringValue;

// ******************************************************************************************

@end
