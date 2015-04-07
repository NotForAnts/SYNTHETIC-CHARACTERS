// ******************************************************************************************
//  WXSCCentreForCharacter
//  Created by Paul Webb on Mon Feb 13 2006.
// ******************************************************************************************

#import "WXSCCentreForCharacter.h"


@implementation WXSCCentreForCharacter
static  WXSCCentreForCharacter*   myWXSCCentreForCharacterSharedInstance=nil;
// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	characterName=[[NSMutableArray alloc]init];
	motivationCentres=[[NSMutableArray alloc]init];
	emotionCentres=[[NSMutableArray alloc]init];
	driveCentres=[[NSMutableArray alloc]init];
	bahaveCentres=[[NSMutableArray alloc]init];
	perceptionCentres=[[NSMutableArray alloc]init];
	perceptBlackBoardCentres=[[NSMutableArray alloc]init];
	
	myWXSCCentreForCharacterSharedInstance=self;
	}
return self;
}
// ******************************************************************************************
+(id)		sharedInstance
{
if(myWXSCCentreForCharacterSharedInstance==nil)
	myWXSCCentreForCharacterSharedInstance=[[WXSCCentreForCharacter alloc]init];

return myWXSCCentreForCharacterSharedInstance;
}
// ******************************************************************************************
-(void) dealloc
{
[characterName release];
[motivationCentres release];
[emotionCentres release];
[driveCentres release];
[bahaveCentres release];
[perceptionCentres release];
[perceptBlackBoardCentres release];
[super dealloc];
}
// ******************************************************************************************
-(void)		addCharacterName:(NSString*)name	{	[characterName addObject:name];							}
-(void)		addMotivationCentre:(id)ob			{	if(ob!=nil)	[motivationCentres addObject:ob];			}
-(void)		addEmotionCentre:(id)ob				{	if(ob!=nil)	[emotionCentres addObject:ob];				}
-(void)		addDriveCentre:(id)ob				{	if(ob!=nil)	[driveCentres addObject:ob];				}
-(void)		addBehaveCentre:(id)ob				{	if(ob!=nil)	[bahaveCentres addObject:ob];				}
-(void)		addPerceptCentre:(id)ob				{	if(ob!=nil)	[perceptionCentres addObject:ob];			}
-(void)		addBlackboard:(id)ob				{	if(ob!=nil)	[perceptBlackBoardCentres addObject:ob];	}
// ******************************************************************************************
-(id)		getMotivationCentre:(NSString*)name
{
int index=[self indexOfCharacterName:name];
if(index<0) return nil;
return [motivationCentres objectAtIndex:index];
}
// ******************************************************************************************
-(id)		getEmotionCentre:(NSString*)name
{
int index=[self indexOfCharacterName:name];
if(index<0) return nil;
return [emotionCentres objectAtIndex:index];
}
// ******************************************************************************************	
-(id)		getDriveCentre:(NSString*)name
{
int index=[self indexOfCharacterName:name];
if(index<0) return nil;
return [driveCentres objectAtIndex:index];
}
// ******************************************************************************************
-(id)		getBehaveCentre:(NSString*)name
{
int index=[self indexOfCharacterName:name];
if(index<0) return nil;
return [bahaveCentres objectAtIndex:index];
}
// ******************************************************************************************	
-(id)		getPerceptCentre:(NSString*)name
{
int index=[self indexOfCharacterName:name];
if(index<0) return nil;
return [perceptBlackBoardCentres objectAtIndex:index];
}
// ******************************************************************************************
-(id)		getBlackboard:(NSString*)name
{
int index=[self indexOfCharacterName:name];
if(index<0) return nil;
return [motivationCentres objectAtIndex:index];
}
// ******************************************************************************************
-(int)		indexOfCharacterName:(NSString*)name
{
int t;
for(t=0;t<[characterName count];t++)
	if([[characterName objectAtIndex:t]isEqualToString:name])  
		return t;

return -1;
}
// ******************************************************************************************


@end
