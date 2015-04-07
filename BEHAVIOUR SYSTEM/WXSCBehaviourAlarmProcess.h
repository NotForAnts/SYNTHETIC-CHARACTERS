// ******************************************************************************************
//  WXSCBehaviourAlarmProcess
//  Created by Paul Webb on 04/10/2006.
// ******************************************************************************************


#import <Cocoa/Cocoa.h>
#import "WXSCSystemBasic.h"
#import "WXSCBehaviourGroupBasic.h"
// ******************************************************************************************
@interface WXSCBehaviourAlarmProcess : WXSCSystemBasic {


id		bahaveGroupObject;
id		bahaveGroupObjectParent;

}


-(void)		setWatchNotificationName:(NSString*)nn;
-(void)		AlarmNotification:(NSNotification *)notification;
-(void)		setBehaviourGroup:(id)anObject;
-(void)		setBehaviourGroupParent:(id)anObject;

-(void)		doAlarmStuff;

// ******************************************************************************************


@end
