// ******************************************************************************************
//  WXSCBlackboard
//  Created by Paul Webb on Sun May 15 2005.
// ******************************************************************************************

#import "WXSCBlackboard.h"

static  WXSCBlackboard*   myWXSCBlackboardSharedInstance=nil;

@implementation WXSCBlackboard
// ***************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	myWXSCBlackboardSharedInstance=self;
	theContents=[[NSMutableDictionary alloc]init];
	}
return self;
}

// ***************************************************************************************
-(void) dealloc 
{
[super dealloc];
}
// *************************************************************************************************************
+(id)		sharedInstance
{
if(myWXSCBlackboardSharedInstance==nil)
	{
	myWXSCBlackboardSharedInstance=[[WXSCBlackboard alloc]init];
	}
	
return myWXSCBlackboardSharedInstance;
}
// *************************************************************************************************************
// other things
// *************************************************************************************************************
-(BOOL)		hasObjectNamed:(NSString*)name
{
if([theContents objectForKey:name]==nil)	return NO;
return YES;
}
// *************************************************************************************************************
-(BOOL)		boolValueForKey:(NSString*)name
{
id  object=[theContents objectForKey:name];
if(object!=nil) return [object boolValue];
return NO;
}
// *************************************************************************************************************
-(int)		intValueForKey:(NSString*)name
{
id  object=[theContents objectForKey:name];
if(object!=nil) return [object intValue];
return 0;
}
// *************************************************************************************************************
-(float)	floatValueForKey:(NSString*)name
{
id  object=[theContents objectForKey:name];
if(object!=nil) return [object floatValue];
return NO;
}
// *************************************************************************************************************
-(void)		setStateBool:(NSString*)name value:(BOOL)value;
{
[theContents setObject:[NSNumber numberWithBool:value] forKey:name];

printf("set %s %d\n",[name cString],value);
}
// *************************************************************************************************************
-(void)		setObject:(NSString*)name value:(id)value
{
[theContents setObject:value forKey:name];
}
// *************************************************************************************************************

@end
