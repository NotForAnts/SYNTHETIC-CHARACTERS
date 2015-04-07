// ******************************************************************************************
//  WXSCBehaviourAlarmManager
//  Created by Paul Webb on 04/10/2006.
// ******************************************************************************************


#import <Cocoa/Cocoa.h>
#import "WXSCSystemBasic.h"
#import "WXSCBehaviourAlarmProcess.h"
// ******************************************************************************************

@interface WXSCBehaviourAlarmManager : WXSCSystemBasic {

NSMutableArray	*theAlarms;
BOOL			hasThread;


}


-(void)		addAlarmProcess:(id)alarm;

// ******************************************************************************************


@end
