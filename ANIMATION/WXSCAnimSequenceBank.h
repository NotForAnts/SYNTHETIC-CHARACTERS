// ******************************************************************************************
//  WXSCAnimSequenceBank
//  Created by Paul Webb on Thu Jan 19 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullCode.h"
#import "WXSCAnimSequence.h"
#import "WXSCAnimBodyWhole.h"
#import "WXDisplayStrings.h"
#import "WXSCAnimDocument.h"
#import "WXUsefullFileReadWrite.h"
// ******************************************************************************************

@interface WXSCAnimSequenceBank : NSObject {

WXSCAnimDocument		*bankDocument;
WXDisplayStrings		*displayString;
NSMutableArray			*theBank;
WXSCAnimBodyWhole		*theBody;
WXSCAnimBodyWhole		*theBodyGhost;

float   screeny;
int		currentIndex;
id		totalGui;
id		sliderGui;
id		currentGui;
}


-(void) setBody:(WXSCAnimBodyWhole*)body;
-(void) removeAllSequenceFrames;
-(void) makeNewSequenceWith;
-(void) makeLotsNewSequenceWith:(int)number;
-(void) setSequenceNameInto:(NSPopUpButton*)pop;
-(void) adjustImagesAsRemoved:(int)index;
-(void)adjustJoinsAsDeletePartAtIndex:(int)index;
-(void) renderCurrentSequence;
-(void) playCurrentSequence;
-(int)  numberSequences;

-(void) drawRect:(NSRect)rect;
-(void) doSelectSequence:(int)seq;
-(WXSCAnimSequence*)	current;
-(void) doDrawBody;
-(void) updateCurrent;

-(void) setGuiTotal:(id)g;
-(void) setGuiCurrent:(id)g;
-(void) setGuiSlider:(id)g;

// MOUSE
- (void)doMouseDown:(NSPoint)loc;
- (void)doMouseDrag:(NSPoint)loc;
- (void)doMouseUp:(NSPoint)loc;

// SAVE / LOAD
-(void)					doReadFileData:(NSMutableData*)data;
-(NSMutableData*)		doWriteFileData;

-(IBAction) doLoadApplication:(id)sender;
-(IBAction) doSaveAsApplicationAction:(id)sender;
-(IBAction) doSaveApplicationAction:(id)sender;
// ******************************************************************************************

@end
