// ******************************************************************************************
//  WXSCCentreForCharacter
//  Created by Paul Webb on Mon Feb 13 2006.
// ******************************************************************************************
// I am thinking of using this so the objects in system can have access to the different centres
// by accessing this SharedInstance. If system has multiple characters each character can be named
// and the objects access centres for that character name....
// ... but not sure how to let objects know characterName... and they would all need to know
//
//
// ******************************************************************************************


#import <Foundation/Foundation.h>


#import "WXSCMotivationDriveManager.h"
#import "WXSCMotivationEmotionCentre.h"
#import "WXSCMotivationSystemBasic.h"
#import "WXSCBehaviourSystemBasic.h"
#import "WXSCPerceptionSystemBasic.h"
#import "WXSCPerceptionBlackboard.h"


// ******************************************************************************************
@interface WXSCCentreForCharacter : NSObject {

NSMutableArray		*characterName;
NSMutableArray		*motivationCentres;
NSMutableArray		*emotionCentres;
NSMutableArray		*driveCentres;
NSMutableArray		*bahaveCentres;
NSMutableArray		*perceptionCentres;
NSMutableArray		*perceptBlackBoardCentres;
}

+(id)		sharedInstance;

-(void)		addCharacterName:(NSString*)name;
-(void)		addMotivationCentre:(id)ob;		
-(void)		addEmotionCentre:(id)ob;		
-(void)		addDriveCentre:(id)ob;		
-(void)		addBehaveCentre:(id)ob;		
-(void)		addPerceptCentre:(id)ob;	
-(void)		addBlackboard:(id)ob;

-(id)		getMotivationCentre:(NSString*)name;	
-(id)		getEmotionCentre:(NSString*)name;	
-(id)		getDriveCentre:(NSString*)name;
-(id)		getBehaveCentre:(NSString*)name;	
-(id)		getPerceptCentre:(NSString*)name;
-(id)		getBlackboard:(NSString*)name;

-(int)		indexOfCharacterName:(NSString*)name;

// ******************************************************************************************

@end
