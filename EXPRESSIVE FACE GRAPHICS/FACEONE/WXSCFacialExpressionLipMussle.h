// ******************************************************************************************
//  WXSCFacialExpressionLipMussle
//  Created by Paul Webb on Thu Feb 16 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXNSPointWrapper.h"
// ******************************************************************************************

@interface WXSCFacialExpressionLipMussle : NSObject {

NSPoint			position;

NSMutableArray  *originalPosition;
NSMutableArray  *pullObjects;
NSMutableArray  *pullWeights;
}

-(id)   initAtPoint:(NSPoint)pos;
-(void) addPull:(id)object weight:(float)weight;
-(void) doPull:(float)level;
// ******************************************************************************************

@end
