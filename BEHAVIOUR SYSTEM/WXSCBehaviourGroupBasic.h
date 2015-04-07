// ******************************************************************************************
//  WXSCBehaviourGroupBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************
// A behaviour is either a Single Behaviour which calls for a Task Request
// or an array of behaviour group which compete to be the current behaviour
// This creates a hierarchy - and can be thought of as going from abstract to
// more concrete behaviours lower down toward task
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCBehaviourTaskRequest.h"

#import "WXSCSystemBasic.h"
#import "WXSCBehaviourPerceptContribution.h"
#import "WXSCBehaviourEmotionContribution.h"
#import "WXSCBehaviourDriveContribution.h"
#import "WXSCBehaviourTaskManager.h"

#import "WXSCMotivationSystemBasic.h"
#import "WXSCMotivationEmotionCentre.h"
#import "WXSCMotivationDriveManager.h"

#import "WXSCPerceptionBlackboard.h"
// ******************************************************************************************

@interface WXSCBehaviourGroupBasic : WXSCSystemBasic {

id  theMotivationCentre;
id  theEmotionCentre;
id  theDriveCentre;
id	perceptCentre;
id  perceptBlackboard;
id  lastAction;
id  lastTask;

WXSCBehaviourTaskManager	*taskManager;

NSMutableArray			*behaviourGroup;
NSMutableArray			*behaviourTasks;
NSMutableArray			*emotionContributions;
NSMutableArray			*driveContributions;
NSMutableArray			*releaserContributions;
NSMutableArray			*perceptContributions;
NSMutableArray			*goalReachedContributions;
NSMutableArray			*theDataGraph;

WXSCBehaviourTaskRequest	*taskRequest;

NSString	*behaveName;
float		activationLevel,frustration,frustrationGain,frustrationLevel;
float		giveUpFrustrationLevel,numberTaskRequests;
float		defaultPersistance,currentPersistance,persistMultiple;
float		alarmLevelGain;
BOOL		isActive,doneGraphAdd;
BOOL		isAnAlarmGroup;
long		timePoint;
int			currentBehaviourGroupIndex,behaveIndex;

}

-(id)		initBehaviour:(NSString*)name;
-(void)		doStart;
-(void)		doUpdate;

-(void)			addDriveContribution:(NSString*)refName map:(NSString*)map;
-(void)			addEmotionContribution:(NSString*)refName map:(NSString*)map;
-(void)			addPerceptContribution:(NSString*)refName map:(NSString*)map;
-(void)			addPerceptContributionEqual:(NSString*)refName value:(float)value contribution:(float)weight  error:(float)error;

-(void)			addSubBehaviourAndRelease:(id)object;
-(void)			addEndGoalContributionAndRelease:(id)object;

// alarms
-(void)			setIsAnAlarm:(BOOL)state;

//  task request
-(void)			addBehaviourTask:(id)object;
-(void)			addBehaviourTaskAndRelease:(id)object;
-(void)			addActionToTask:(NSString*)name action:(id)action;
-(void)			addConditionToTask:(NSString*)name condition:(id)condition;
-(void)			addSucessConditionToTask:(NSString*)name condition:(id)condition;
-(id)			task:(NSString*)name;
-(id)			getTaskWithName:(NSString*)name;
-(id)			lastAction;
-(id)			lastTask;
//  process
-(void)			chooseSubBehaviour;
-(void)			backGroundThread;
-(void)			doProcess;
-(BOOL)			allTasksRequestsSuccess;
-(BOOL)			allGoalsReached;

-(void)			setTaskManager:(id)tm;
-(NSString*)	behaveName;
-(float)		activationLevel;
-(BOOL)			isActive;
-(void)			setFrustrationGain:(float)g;	
-(void)			setFrustrationLevel:(float)l;	
-(void)			setPersistMultiple:(float)v;
-(void)			setPersistLevel:(float)v;
-(void)			setIsActive:(BOOL)state;
-(void)			resetBehaveGroup;
-(float)		currentPersistance;
-(float)		frustration;
-(void)			setAlarmLevel:(float)level;
-(int)			numberSubBehaviours;
-(int)			numberTasks;
-(int)			numberDriveContributions;
-(int)			numberEmotionContributions;
-(int)			numberPerceptContributions;
-(int)			numberReleaserContributions;
-(int)			numberReachGoalContributions;
-(void)			setMotivationCentre:(id)mc;
-(void)			setPerceptSystem:(id)pc;
-(void)			printInfo;


// ******************************************************************************************

@end
