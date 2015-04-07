// ******************************************************************************************
//  WXSCStateFloatEqual
//  Created by Paul Webb on 25/09/2006.
// ******************************************************************************************

#import <Cocoa/Cocoa.h>
#import "WXSCSystemBasic.h"
// ******************************************************************************************

@interface WXSCStateFloatEqual : WXSCSystemBasic {

float   theValue;
}

-(id)   initEqual:(float)value;
-(BOOL) compareToFloat:(float)value;
-(BOOL) compareToString:(NSString*)value;

// ******************************************************************************************

@end
