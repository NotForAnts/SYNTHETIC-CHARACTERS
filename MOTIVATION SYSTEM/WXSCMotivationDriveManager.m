// ******************************************************************************************
//  WXSCMotivationDriveManager
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************
#import "WXSCMotivationDriveManager.h"


@implementation WXSCMotivationDriveManager
// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	theTimer=[[WXPoller alloc]init];
	theDrives=[[NSMutableArray alloc]init];
	
	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[theDrives release];
[super dealloc];
}
// ******************************************************************************************
-(void)		addStimulateToDrive:(NSString*)name gain:(float)gain
{
id object=[self getDriveObjectNamed:name];
if(object!=nil) 
	[object stimulateDrive:gain];
else
	printf("***error - could not find drive %s\n",[name cString]);
}
// ******************************************************************************************
-(int)		numberDrives					{		return [theDrives count];			}
-(void)		addDrive:(id)drive				{		[theDrives addObject:drive];		}
// ******************************************************************************************
-(id)		getDriveObjectNamed:(NSString*)name
{
int t;
for(t=0;t<[theDrives count];t++)
	if([[[theDrives objectAtIndex:t]driveName]isEqualToString:name])  
		return [theDrives objectAtIndex:t];
return nil;
}
// ******************************************************************************************
-(void)		doStart
{
[theDrives makeObjectsPerformSelector:@selector(doStart)];
[theTimer  initialiseToNow];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
if(![theTimer checkUpdateWithIncrement:1.0])   return;
[theDrives makeObjectsPerformSelector:@selector(processDrive)];
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString  textAt:pos.x y:pos.y text:@"DRIVE MANAGER" color:[NSColor greenColor]];
int t;
for(t=0;t<[theDrives count];t++)
	[[theDrives objectAtIndex:t]showInfo:NSMakePoint(pos.x,pos.y+12+t*10)];
}
// ******************************************************************************************

@end
