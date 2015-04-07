// ******************************************************************************************
//  WXSCPerceptionBlackboard
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************
// A dictionary of WXSCPerceptionObject
//		
// WAS USING A SHARED INSTANCE BUT THIS DOES NOT WORK WELL FOR MULTIPLE
// CHARACTERS WITHIN A SYSTEM
//
//
// ******************************************************************************************

#import <Foundation/Foundation.h>
#import "WXSCPerceptionObject.h"
#import "WXSCSystemBasic.h"
// ******************************************************************************************

@interface WXSCPerceptionBlackboard : WXSCSystemBasic {

NSMutableDictionary *thePerceptions;

}


+(id)		sharedInstance;
-(void)		postPerception:(NSString*)name value:(id)value;
-(void)		doAllLoopUpdate:(long)time;
-(id)		getPerceptObjectOfName:(NSString*)name;
// ******************************************************************************************

@end
