// ******************************************************************************************
//  WXSCStateFloatSet
//  Created by Paul Webb on 25/09/2006.
// ******************************************************************************************


#import <Cocoa/Cocoa.h>
#import "WXSCSystemBasic.h"
// *******************************************************************************************

@interface WXSCStateFloatSet : WXSCSystemBasic {

BOOL				theMatch;
NSArray				*theSet;
NSMutableArray		*theSetNumber;
}

-(id)   initSet:(NSString*)set match:(BOOL)match;
-(BOOL) compareToFloat:(float)value;
-(BOOL) compareToString:(NSString*)value;

// ******************************************************************************************


@end
