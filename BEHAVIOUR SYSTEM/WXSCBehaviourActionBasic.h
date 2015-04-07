// ******************************************************************************************
//  WXSCBehaviourActionBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************
// actual object to do the action is delegate using
//
// concreteAction
// concreteMethod
//
// so this is a fairly abstract class
//
// see the task manager
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXSCSystemBasic.h"
#import "WXPoller.h"
// ******************************************************************************************

@interface WXSCBehaviourActionBasic : WXSCSystemBasic {

NSTimeInterval  timeActive,maxTimeInterval;
WXPoller		*theTimer;
NSString		*actionName;
BOOL			isActive;
int				processMaxTimes,processCount;

id			concreteAction;
SEL			concreteMethod;
}

-(id)   initNullAction:(NSString*)name;
-(id)   initAction:(NSString*)name ob:(id)on sel:(SEL)sel;

-(void)	doResetForStart;
-(void)	doResetForStop;
-(void) setActive:(BOOL)state;
-(void) setActionObject:(id)object;
-(void) setActionSelelector:(SEL)sel;
-(void) setMaxTimeInterval:(NSTimeInterval)mt;
-(void) setMaxCount:(int)mt;	

-(void) showMoreInfo:(NSPoint)pos;
// ******************************************************************************************

@end
