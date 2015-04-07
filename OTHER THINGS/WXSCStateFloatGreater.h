// ******************************************************************************************
//  WXSCStateFloatGreater
//  Created by Paul Webb on Sat Feb 11 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCSystemBasic.h"
// ******************************************************************************************

@interface WXSCStateFloatGreater : WXSCSystemBasic {

float   theValue;
}

-(id)   initGreater:(float)value;
-(BOOL) compareToFloat:(float)value;
-(BOOL) compareToString:(NSString*)value;

// ******************************************************************************************

@end
