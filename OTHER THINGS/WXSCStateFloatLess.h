// ******************************************************************************************
//  WXSCStateFloatLess
//  Created by Paul Webb on Mon Feb 13 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCSystemBasic.h"
// ******************************************************************************************

@interface WXSCStateFloatLess : WXSCSystemBasic {

float   theValue;
}

-(id)   initLess:(float)value;
-(BOOL) compareToFloat:(float)value;
-(BOOL) compareToString:(NSString*)value;


// ******************************************************************************************

@end
