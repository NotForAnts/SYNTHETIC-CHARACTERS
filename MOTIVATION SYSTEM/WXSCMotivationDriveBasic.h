// ******************************************************************************************
//  WXSCMotivationDriveBasic
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXSCSystemBasic.h"
// ******************************************************************************************
@interface WXSCMotivationDriveBasic : WXSCSystemBasic {

NSMutableString		*driveName;
int			driveIndex;
float		driveMin,driveMax;
float		driveLevel,driveRate;
float		lastDriveLevel,rateOfChange;

NSMutableArray			*theDataGraph;
}


-(id)		initDrive:(NSString*)name rate:(float)rate index:(int)index max:(float)max;
-(void)		processDrive;
-(void)		stimulateDrive:(float)gain;
-(BOOL)		compareAsState:(id)state;
-(void)		postDriveState;
-(void)		driveToEmotionSignals;

-(void)			setName:(NSString*)name;
-(float)		driveLevel;
-(float)		driveRateOfChange;
-(NSString*)	driveName;
// ******************************************************************************************
@end
