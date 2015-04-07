// ******************************************************************************************
//  WXSCBehaviourTaskManager
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXPoller.h"

#import "WXSCBehaviourTaskRequest.h"
#import "WXSCSystemBasic.h"
// ******************************************************************************************
@interface WXSCBehaviourTaskManager : WXSCSystemBasic {

WXPoller			*theTimer;
NSMutableArray		*theTaskRequests;
NSMutableArray		*theTaskOwner;
id  *theActionManager;
}

-(void)		setActionManager:(id)am;
-(void)		addsTaskFromArray:(NSArray*)tasks sender:(id)sender;
-(void)		removeTaskFromArray:(NSArray*)tasks sender:(id)sender;
-(void)		removeSuccessfulTask;
// ******************************************************************************************

@end
