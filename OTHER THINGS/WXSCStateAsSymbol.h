// ******************************************************************************************
//  WXSCStateAsSymbol
//  Created by Paul Webb on Fri Feb 10 2006.
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCSystemBasic.h"

// ******************************************************************************************

@interface WXSCStateAsSymbol : WXSCSystemBasic {

NSString	*symbol;
}

-(id)   initStateSymbol:(NSString*)name;
-(BOOL) compareToFloat:(float)value;
-(BOOL) compareToString:(NSString*)value;

// ******************************************************************************************

@end
