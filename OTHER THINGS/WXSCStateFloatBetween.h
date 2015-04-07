// ******************************************************************************************
//  WXSCStateFloatBetween
//  Created by Paul Webb on Mon Feb 13 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCSystemBasic.h"
// ******************************************************************************************

@interface WXSCStateFloatBetween : WXSCSystemBasic {


float   theValue1,theValue2;
}

-(id)   initBetween:(float)v1 v2:(float)v2;
-(BOOL) compareToFloat:(float)value;
-(BOOL) compareToString:(NSString*)value;

// ******************************************************************************************

@end
