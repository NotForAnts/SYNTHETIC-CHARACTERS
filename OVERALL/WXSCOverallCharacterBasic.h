// ******************************************************************************************
//  WXSCOverallCharacterBasic
//  Created by Paul Webb on Tue Jan 10 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCMotivationSystemBasic.h"
#import "WXSCBehaviourSystemBasic.h"
#import "WXSCPerceptionSystemBasic.h"
#import "WXSCCentreForCharacter.h"

// ******************************************************************************************

@interface WXSCOverallCharacterBasic : NSObject {

WXSCPerceptionSystemBasic		*perceptionSystem;
WXSCMotivationSystemBasic		*motivationSystem;
WXSCBehaviourSystemBasic		*behaviourSystem;

WXSCCentreForCharacter			*characterCentres;

//
id  expressiveFaceView;
id  plotterView;
id  characterView;
}

-(void)		doStart;
-(void)		doAllLoopUpdate:(long)time;

-(void)		setFaceView:(id)view;
-(void)		setPlotterView:(id)view;
-(void)		setCharacterView:(id)view;
-(void)		setMachineListenView:(id)view;

-(void)		drawInfo;
// ******************************************************************************************


@end
