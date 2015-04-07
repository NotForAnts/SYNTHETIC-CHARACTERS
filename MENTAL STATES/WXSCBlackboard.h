// ******************************************************************************************
//  WXSCBlackboard
//  Created by Paul Webb on Sun May 15 2005.
// ******************************************************************************************
// The black board is a general purpose inter-communication board in which named objects
// are stored that other objects can check. 
//
// type of content will use
//
//		-internal system states
//		-releasers (perceptual values which (maybe) have some kind of affective meaning and state)
//		
//
//******************************************************************************************
#import <Foundation/Foundation.h>

//******************************************************************************************
@interface WXSCBlackboard : NSObject {

NSMutableDictionary		*theContents;

}

+(id)		sharedInstance;

-(void)		setObject:(NSString*)name value:(id)value;
-(void)		setStateBool:(NSString*)name value:(BOOL)value;

-(BOOL)		hasObjectNamed:(NSString*)name;
-(BOOL)		boolValueForKey:(NSString*)name;
-(int)		intValueForKey:(NSString*)name;
-(float)	floatValueForKey:(NSString*)name;



@end
