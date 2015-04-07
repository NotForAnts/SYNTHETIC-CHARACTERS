// ******************************************************************************************
//  WXSCAnimSequenceScripting
//  Created by Paul Webb on Sun Jan 22 2006.
// ******************************************************************************************

#import "WXSCAnimSequenceScripting.h"


@implementation WXSCAnimSequenceScripting
// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	
	}
return self;
}
// ******************************************************************************************
-(void)		setBank:(WXSCAnimSequenceBank*)p		{   theBank=p;		}
-(void)		setBody:(WXSCAnimSequenceBank*)p		{   theBody=p;		}
-(void)		setView:(id)p							{					}
// ******************************************************************************************

@end
