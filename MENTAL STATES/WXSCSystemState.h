// ******************************************************************************************
//  WXSCSystemState
//  Created by Paul Webb on Wed May 11 2005.
// ******************************************************************************************
#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
@class WXSCSystemStateManager;

// ******************************************************************************************

@interface WXSCSystemState : NSObject {

NSString		*stateName;
int				*externalVarPointer;
int				stateValue;
int				flipValue;
NSMutableString	*symbolValue;
BOOL			stateDidChange,flipStateActive;
int				changeCount;
long			lastStateChangeTime;
long			flipTimePoint;

WXSCSystemStateManager	*systemStateManager;
}

-(id)		initState:(NSString*)name;
-(id)		initStateWithPointer:(NSString*)name vp:(int*)vp;
-(void)		resetTo:(int)value;
-(void)		reset;

-(int)		decrement:(long)timePoint;
-(int)		increment:(long)timePoint;
-(BOOL)		checkShouldFlip:(long)timePoint;
-(BOOL)		setStateWithUpdateRange:(int)value time:(long)timePoint range:(int)range;
-(BOOL)		setStateBoolIfTimeDifference:(long)checkTime time:(long)timePoint diff:(int)diff;
-(BOOL)		setStateToFlip:(int)value time:(long)timePoint delay:(int)delay flip:(int)flip;
-(BOOL)		setState:(int)value time:(long)timePoint;
-(BOOL)		setSymbol:(NSMutableString*)value time:(long)timePoint;
-(int)		getChangePeriod:(long)timePoint;

-(BOOL)		boolValue;
-(int)		intValue;
-(float)	floatValue;
-(NSString*)	stateName;

@end
