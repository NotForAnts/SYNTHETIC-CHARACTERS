// ******************************************************************************************
//  WXSCMotivationSystemBasic
//  Created by Paul Webb on Tue Jan 10 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXSCSystemBasic.h"

#import "WXSCMotivationDriveManager.h"
#import "WXSCMotivationDriveBasic.h"

#import "WXSCMotivationEmotionCentre.h"
#import "WXSCMotivationEmotionBasic.h"
// ******************************************************************************************

@interface WXSCMotivationSystemBasic : WXSCSystemBasic {

WXSCMotivationDriveManager  *driveManager;
WXSCMotivationDriveBasic	*newDrive;

WXSCMotivationEmotionCentre  *emotionManager;
WXSCMotivationEmotionBasic	 *newEmotion;
}

-(void)		initDriveManager;
-(void)		initEmotionManager;


-(void)		addReleaseDrive:(id)newDrive;
-(void)		addReleaseEmotion:(id)newEmotion;
-(void)		initEmotions;
-(void)		initDrives;
-(id)		emotionCentre;
-(id)		driveCentre;

// ******************************************************************************************


@end
