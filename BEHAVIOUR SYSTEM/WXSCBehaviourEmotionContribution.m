// ******************************************************************************************
//  WXSCBehaviourEmotionContribution
//  Created by Paul Webb on Thu Feb 09 2006.
// ******************************************************************************************

#import "WXSCBehaviourEmotionContribution.h"


@implementation WXSCBehaviourEmotionContribution

// ******************************************************************************************
-(void)		setContributionObject:(id)eo				{	contributionObject=eo;		}
// ******************************************************************************************
-(void)		setMapper:(NSString*)mapString
{
NSArray *map=[mapString componentsSeparatedByString:@" "];
map1=[[map objectAtIndex:0]floatValue];
map2=[[map objectAtIndex:1]floatValue];
range1=[[map objectAtIndex:2]floatValue];
range2=[[map objectAtIndex:3]floatValue];

printf("EMOTION CONTRIBUTION MAP = %f %f -> %f %f\n",map1,map2,range1,range2);
}
// ******************************************************************************************
-(float)	processContribution
{
//printf("get Emotion Contribution\n");
emotionLevel=[contributionObject emotionLevel];
currentLevel=0;
if(emotionLevel<map1)  return 0;
currentLevel=WXUNormalise(emotionLevel,map1,map2,range1,range2);
return currentLevel;
}
// ******************************************************************************************
-(void)		showInfo:(NSPoint)pos
{
[displayString  textAt:pos.x y:pos.y text:[contributionObject emotionName] color:[NSColor greenColor]];
[displayString floatNumberAt:pos.x+100 y:pos.y value:emotionLevel color:[NSColor greenColor]];
[displayString floatNumberAt:pos.x+150 y:pos.y value:currentLevel color:[NSColor greenColor]];
}
// ******************************************************************************************

@end
