// ******************************************************************************************
//  WXSCBehaviourActionManager
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXSCBehaviourActionBasic.h"
#import "WXSCBehaviourTaskManager.h"
#import "WXSCBehaviourTaskRequest.h"
#import "WXSCSystemBasic.h"
// ******************************************************************************************

@interface WXSCBehaviourActionManager : WXSCSystemBasic {

NSMutableArray				*currentActions;
WXSCBehaviourTaskManager	*taskRequestManager;
}


-(void)		setTaskRequestManager:(id)tm;
-(void)		processTaskRequests;
-(void)		addAction:(id)action;
-(void)		removeAction:(id)action;
// ******************************************************************************************

@end
