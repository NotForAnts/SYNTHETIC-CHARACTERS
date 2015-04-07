// ******************************************************************************************
//  WXSCBehaviourEmotionContribution
//  Created by Paul Webb on Thu Feb 09 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCMotivationEmotionBasic.h"
#import "WXUsefullCode.h"
#import "WXSCSystemBasic.h"
// ******************************************************************************************

@interface WXSCBehaviourEmotionContribution : WXSCSystemBasic {

WXSCMotivationEmotionBasic   *contributionObject;

int		emotionIndex;
float   map1,map2,range1,range2;	
float   emotionLevel,currentLevel;

}

-(void)		setContributionObject:(id)eo;
-(void)		setMapper:(NSString*)mapString;
-(float)	processContribution;

// ******************************************************************************************

@end
