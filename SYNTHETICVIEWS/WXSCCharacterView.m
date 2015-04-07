// ******************************************************************************************
//  WXSCBehaviourTaskRequest
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************

#import "WXSCCharacterView.h"

@implementation WXSCCharacterView
static  WXSCCharacterView*   myWXSCCharacterViewSharedInstance=nil;

// ******************************************************************************************
-(id)   initWithFrame:(NSRect)frameRect
{
if ((self = [super initWithFrame:frameRect]) != nil) 
	{
	myWXSCCharacterViewSharedInstance=self;
	}
return self;
}
// ******************************************************************************************
+(id)		sharedInstance
{
if(myWXSCCharacterViewSharedInstance==nil)
	myWXSCCharacterViewSharedInstance=[[WXSCCharacterView alloc]init];

return myWXSCCharacterViewSharedInstance;
}
// ******************************************************************************************
-(BOOL) isFlipped		{   return YES;		}
// ******************************************************************************************
-(void) drawRect:(NSRect)rect
{
[mainController drawInfo];
}
// ******************************************************************************************

@end
