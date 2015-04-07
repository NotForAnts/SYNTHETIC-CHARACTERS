// ******************************************************************************************
//  WXSCMotivationDriveManager
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXSCSystemBasic.h"
#import "WXPoller.h"
// ******************************************************************************************

@interface WXSCMotivationDriveManager : WXSCSystemBasic {

WXPoller		*theTimer;
NSMutableArray  *theDrives;

}


-(void)		addDrive:(id)drive;
-(id)		getDriveObjectNamed:(NSString*)name;
-(int)		numberDrives;
-(void)		addStimulateToDrive:(NSString*)name gain:(float)gain;

// ******************************************************************************************

@end
