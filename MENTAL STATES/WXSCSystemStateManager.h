// ******************************************************************************************
//  WXSCSystemStateManager
//  Created by Paul Webb on Tue May 17 2005.
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCSystemState.h"


// ******************************************************************************************
@interface WXSCSystemStateManager : NSObject {


NSMutableArray		*flipObjects;
}


+(id)		sharedInstance;


-(void)		addFlipObject:(WXSCSystemState*)state;
-(void)		doSlowUpdates:(long)timePoint;
-(void)		doReset;


@end
