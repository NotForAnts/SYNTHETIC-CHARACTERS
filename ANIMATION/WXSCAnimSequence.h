// ******************************************************************************************
//  WXSCAnimSequence
//  Created by Paul Webb on Thu Jan 19 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCAnimBodyWhole.h"
#import "WXSCAnimBodyPartBasic.h"
#import "WXUsefullCode.h"
#import "WXUsefullFileReadWrite.h"
#import "WXDisplayStrings.h"
#import "WXSCAnimRenderedSequence.h"
// ******************************************************************************************

@interface WXSCAnimSequence : NSObject {

NSMutableArray				*newPosition;
WXSCAnimBodyWhole			*theBody;
NSMutableArray				*theSequence;
NSMutableArray				*currentPosition;
WXDisplayStrings			*displayString;
NSMutableString				*sequenceName;
WXSCAnimRenderedSequence	*renderedSequence;

int currentIndex,direction,select1,select2,selectType;
BOOL	doPlay;
BOOL	isRendered;

id		totalGui;
id		sliderGui;
id		currentGui;

}

-(NSMutableArray*)  theSequence;
-(void) updateCurrent;
-(void) putIntoCurrent;
-(BOOL) inPlay;
-(BOOL) isRendered;
-(int)  select1;
-(int)  select2;
-(void) setSelect1:(int)v;
-(void) setSelect2:(int)v;	

-(void) renderSequence;
-(void) drawMiniImages;
-(void) setBody:(id)body;
-(void) addFrame;
-(void) replaceCurrent;
-(void) insertAfterCurrent;
-(void) deleteCurrentFrame;
-(void) adjustImagesAsRemoved:(int)index;
-(void) adjustJoinsAsDeletePartAtIndex:(int)index;
-(void) inbetweenSelection:(int)numberBetweens;
-(float)quickestAngleNormalise:(float)v v1:(float)v1 v2:(float)v2 a1:(float)a1 a2:(float)a2;
-(void) makePartSettingTillEndSelection;
-(void) reverseSelection;
-(void) deleteSelection;
-(void) removeAllFrames;
-(void) copySelectionInto:(NSMutableArray*)dest;
-(void) cutSelection:(NSMutableArray*)dest;
-(void) pasteSelection:(NSMutableArray*)source;
-(void) createPosition;
-(void) putPositionInto:(NSMutableArray*)thePosition;
-(void) putIntoPositionUsingPosition:(NSMutableArray*)position;
-(void) gotoSliderValue:(float)value;
-(void) nextFrame;
-(void) previousFrame;

-(void) initForPlay;
-(void) goStartIfPlaying;
-(void) playSequence;
-(void) putIntoPosition:(int)index;
-(void) gotoCurrent;
-(void) gotoEnd;
-(int)  numberFrames;
-(NSMutableString*)  sequenceName;
-(void) setSequenceName:(NSString*)n;

-(void) showInformation;
-(void) showInfo;
-(void) setGuiTotal:(id)g;
-(void) setGuiCurrent:(id)g;
-(void) setGuiSlider:(id)g;


-(void) doStart;
-(void) doStop;

// USEFULL
-(void) getValuesForPart:(NSMutableDictionary*)source
	angle:(float*)angle px:(float*)px py:(float*)py sx:(float*)sx sy:(float*)sy xp:(float*)xp yp:(float*)yp
	ji:(int*)ji im:(int*)im join:(BOOL*)join abs:(BOOL*)abs piv:(int*)piv;
	
-(void) setValuesForPart:(NSMutableDictionary*)source
	angle:(float)angle px:(float)px py:(float)py sx:(float)sx sy:(float)sy xp:(float)xp yp:(float)yp
	ji:(int)ji im:(int)im join:(BOOL)join abs:(BOOL)abs piv:(int)piv;	

// MOUSE
- (void)doMouseDown:(NSPoint)loc;
- (void)doMouseDrag:(NSPoint)loc;
- (void)doMouseUp:(NSPoint)loc;

// LOAD SAVE
-(void)		writeDataUsing:(WXUsefullFileReadWrite*)reader;
-(void)		loadDataUsing:(WXUsefullFileReadWrite*)reader;
// ******************************************************************************************


@end
