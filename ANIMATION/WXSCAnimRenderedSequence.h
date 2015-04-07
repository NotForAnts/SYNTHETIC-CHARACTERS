// ******************************************************************************************
//  WXSCAnimRenderedSequence
//  Created by Paul Webb on Fri Feb 03 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
// ******************************************************************************************

@interface WXSCAnimRenderedSequence : NSObject {

float   stageX,stageY;
NSImage *newImage;

NSMutableArray   *theRenderedPositions;
}

// ******************************************************************************************

-(void) reset;
-(void) makeNewImage;
-(void) setStageSize:(float)x y:(float)y;
-(void) addImage;
-(void) lock;
-(void) unlock;

// ******************************************************************************************

@end
