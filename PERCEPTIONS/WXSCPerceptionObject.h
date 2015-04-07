// ******************************************************************************************
//  WXSCPerceptionObject
//  Created by Paul Webb on Tue Feb 07 2006.
// ******************************************************************************************
// A PERCEPTION OBJECT
//
//
//
//
//
//
//
// ******************************************************************************************

#import <Foundation/Foundation.h>

// ******************************************************************************************

@interface WXSCPerceptionObject : NSObject {

id  valueObject;
NSMutableString *perceptName;

float   perceptStrength;



}

-(float)	perceptStrength;
-(void)		setPerceptStrength:(float)strength;
-(void)		setPerceptionName:(NSString*)name;
-(void)		setValueObject:(id)vo;
-(id)		valueObject;
-(float)	floatValue;
-(float)	updateStrength;
-(NSString*)	perceptName;
// ******************************************************************************************

@end
