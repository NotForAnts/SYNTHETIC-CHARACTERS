// ******************************************************************************************
//  WXSCPerceptionBlackboard
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCPerceptionBlackboard.h"
static  WXSCPerceptionBlackboard*   myWXSCPerceptionBlackboardSharedInstance=nil;

@implementation WXSCPerceptionBlackboard
// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	thePerceptions=[[NSMutableDictionary alloc]init];
	myWXSCPerceptionBlackboardSharedInstance=self;
	}
return self;
}
// ******************************************************************************************
+(id)		sharedInstance
{
if(myWXSCPerceptionBlackboardSharedInstance==nil)
	myWXSCPerceptionBlackboardSharedInstance=[[WXSCPerceptionBlackboard alloc]init];

return myWXSCPerceptionBlackboardSharedInstance;
}
// ******************************************************************************************
-(void) dealloc
{
[super dealloc];
}
// ******************************************************************************************
-(void)		postPerception:(NSString*)name value:(id)value
{
[thePerceptions setValue:value forKey:name];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
NSArray					*theKeys=[thePerceptions allKeys];
WXSCPerceptionObject	*object;
id  aKey;
int t,size=[theKeys count];
float   strength;

for(t=0;t<size;t++)
	{
	aKey=[theKeys objectAtIndex:t];
	object=[thePerceptions objectForKey:aKey];
	strength=[object updateStrength];
	//printf("strength %d =  %f\n",t,strength);
	
	if(strength<=0)
		{
		[thePerceptions removeObjectForKey:aKey];
		//printf("removed %s\n",[aKey cString]);
		}
	}

}	
// ******************************************************************************************
-(id)		getPerceptObjectOfName:(NSString*)name
{
NSArray					*theKeys=[thePerceptions allKeys];
int t,size=[theKeys count];
id  aKey;

for(t=0;t<size;t++)
	{
	aKey=[theKeys objectAtIndex:t];
	if([aKey isEqualToString:name])  return [thePerceptions objectForKey:aKey];;
	}
	
return nil;
}

// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString  textAt:pos.x y:pos.y text:@"PERCEPTION BLACKBOARD" color:[NSColor yellowColor]];

NSArray					*theKeys=[thePerceptions allKeys];
WXSCPerceptionObject	*object;
id  aKey;
int t,size=[theKeys count];
float   strength,value;

for(t=0;t<size;t++)
	{
	aKey=[theKeys objectAtIndex:t];
	object=[thePerceptions objectForKey:aKey];
	strength=[object updateStrength];
	value=[object floatValue];
	//printf("strength %d =  %f\n",t,strength);
	
	[displayString  textAt:pos.x y:10+pos.y+t*12 text:aKey color:[NSColor yellowColor]];
	[displayString  floatNumberAt:pos.x+50 y:10+pos.y+t*12 value:value color:[NSColor yellowColor]];
	[displayString  floatNumberAt:pos.x+100 y:10+pos.y+t*12 value:strength color:[NSColor yellowColor]];
	}
}
// ******************************************************************************************

@end
