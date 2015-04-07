// ******************************************************************************************
//  WXSCStateFloatNotEqual
//  Created by Paul Webb on 25/09/2006.
// ******************************************************************************************


#import <Cocoa/Cocoa.h>
#import "WXSCSystemBasic.h"
// ******************************************************************************************

@interface WXSCStateFloatNotEqual : WXSCSystemBasic {

float   theValue;
}

-(id)   initNEqual:(float)value;
-(BOOL) compareToFloat:(float)value;
-(BOOL) compareToString:(NSString*)value;


// ******************************************************************************************

@end
