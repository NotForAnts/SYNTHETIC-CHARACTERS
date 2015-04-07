// ******************************************************************************************
//  WXSCBehaviourDriveContribution
//  Created by Paul Webb on Thu Feb 09 2006.
// ******************************************************************************************

#import "WXSCBehaviourDriveContribution.h"


@implementation WXSCBehaviourDriveContribution

// ******************************************************************************************
-(void)		setContributionObject:(id)eo				{	contributionObject=eo;		}
// ******************************************************************************************
-(void)		setMapper:(NSString*)mapString
{
NSArray *map=[mapString componentsSeparatedByString:@" "];
map1=[[map objectAtIndex:0]floatValue];
map2=[[map objectAtIndex:1]floatValue];
range1=[[map objectAtIndex:2]floatValue];
range2=[[map objectAtIndex:3]floatValue];

printf("DRIVE CONTRIBUTION MAP = %f %f -> %f %f\n",map1,map2,range1,range2);
}
// ******************************************************************************************
-(float)	processContribution
{
//printf("get Drive Contribution\n");
driveLevel=[contributionObject driveLevel];
currentLevel=0;
if(driveLevel<map1 && map1>0)  return 0;
if(driveLevel>map1 && map1<0)  return 0;
currentLevel=WXUNormalise(driveLevel,map1,map2,range1,range2);
return currentLevel;
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString  textAt:pos.x y:pos.y text:[contributionObject driveName] color:[NSColor greenColor]];
[displayString floatNumberAt:pos.x+100 y:pos.y value:driveLevel color:[NSColor greenColor]];
[displayString floatNumberAt:pos.x+150 y:pos.y value:currentLevel color:[NSColor greenColor]];
}
// ******************************************************************************************
@end
