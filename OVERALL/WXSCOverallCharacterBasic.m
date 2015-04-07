// ******************************************************************************************
//  WXSCOverallCharacterBasic
//  Created by Paul Webb on Tue Jan 10 2006.
// ******************************************************************************************


#import "WXSCOverallCharacterBasic.h"


@implementation WXSCOverallCharacterBasic

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	perceptionSystem=[[WXSCPerceptionSystemBasic alloc]init];
	motivationSystem=[[WXSCMotivationSystemBasic alloc]init];
	behaviourSystem=[[WXSCBehaviourSystemBasic alloc]init];
	
	//machineListenCentre=[[WXSCMListeningCentre alloc]init];
	//musicCentre=[[WXSCMidiGenMusicGenerateCentre alloc]init];
	//musicController=[[WXSCBehaviourMusicControl alloc]init];
	
	//[machineListenCentre addToBeatTrack:musicCentre];
	//[machineListenCentre addDestinationToRouter:musicCentre];
	
	// this is used as a shared instance so if have multiple characters they are all stored in this Object
	// and other characters can access them via "character name"
	characterCentres=[WXSCCentreForCharacter sharedInstance];
	
	
	
	[characterCentres addCharacterName:@"CharacterOne"];
	[characterCentres addMotivationCentre:motivationSystem];	
	[characterCentres addEmotionCentre:[motivationSystem emotionCentre]];	
	[characterCentres addDriveCentre:[motivationSystem driveCentre]];		
	[characterCentres addBehaveCentre:behaviourSystem];
	[characterCentres addPerceptCentre:perceptionSystem];
	[characterCentres addBlackboard:[perceptionSystem perceptBlackboard]];
	
	
	[behaviourSystem setMotivationCentre:motivationSystem];
	[behaviourSystem maketopLevelBehaviours];
	

	}
return self;
}
// ******************************************************************************************
-(void) dealloc
{
[perceptionSystem release];
[motivationSystem release];
[behaviourSystem release];
//[machineListenCentre release];
//[musicCentre release];
//[musicController release];

[super dealloc];
}
// ******************************************************************************************
-(void)		setPlotterView:(id)view				{		plotterView=view;			}
-(void)		setCharacterView:(id)view			{		characterView=view;			}
// ******************************************************************************************
-(void)		setMachineListenView:(id)view		
{			
//[machineListenCentre setMachineListenView:view];
}
// ******************************************************************************************
-(void)		setFaceView:(id)view		
{		
expressiveFaceView=view;	
[expressiveFaceView setEmotionCentre:[motivationSystem emotionCentre]];
}
// ******************************************************************************************
-(void)		doStart
{
[perceptionSystem doStart];
[motivationSystem doStart];
[behaviourSystem doStart];
//[machineListenCentre doStart];
//[musicCentre doStart];
//[musicController doStart];
}
// ******************************************************************************************
-(void)		doAllLoopUpdate:(long)time
{
[perceptionSystem doAllLoopUpdate:time];
[motivationSystem doAllLoopUpdate:time];
[behaviourSystem doAllLoopUpdate:time];

//[machineListenCentre doAllLoopUpdate:time];
//[musicCentre  doAllLoopUpdate:time];
//[musicController  doAllLoopUpdate:time];

}
// ******************************************************************************************
-(void)		drawInfo
{
return;
[behaviourSystem showInfo:NSMakePoint(10,10)];
[motivationSystem showInfo:NSMakePoint(400,10)];
[perceptionSystem showInfo:NSMakePoint(400,200)];
}
// ******************************************************************************************

@end
