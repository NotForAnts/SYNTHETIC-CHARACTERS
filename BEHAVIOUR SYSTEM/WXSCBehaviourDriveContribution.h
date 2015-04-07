// ******************************************************************************************
//  WXSCBehaviourDriveContribution
//  Created by Paul Webb on Thu Feb 09 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCMotivationDriveBasic.h"
#import "WXUsefullCode.h"
#import "WXSCSystemBasic.h"
// ******************************************************************************************

@interface WXSCBehaviourDriveContribution : WXSCSystemBasic {

WXSCMotivationDriveBasic   *contributionObject;

int		emotionIndex;
float   map1,map2,range1,range2;	
float   driveLevel,currentLevel;
}


-(void)		setContributionObject:(id)eo;
-(void)		setMapper:(NSString*)mapString;
-(float)	processContribution;

// ******************************************************************************************


@end
