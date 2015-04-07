// ******************************************************************************************
//  WXSCAnimBodyWhole
//  Created by Paul Webb on Tue Jan 17 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXSCAnimBodyPartBasic.h"
#import "WXUsefullCode.h"
#import "WXUsefullFileReadWrite.h"
#import "WXSCAnimImageCollection.h"
#import "WXSCAnimDocument.h"

@class WXSCAnimSequenceBank;
// ******************************************************************************************

@interface WXSCAnimBodyWhole : NSObject {

NSMutableArray				*theBody;
WXSCAnimImageCollection		*imageCollection;
WXSCAnimSequenceBank		*theBank;
WXSCAnimBodyPartBasic		*newElement;
WXSCAnimDocument			*saveDocument;

int		lastIndex;
}


-(void)		drawBlockWithScale:(float)scale xd:(float)xd yd:(float)yd;
-(void)		draw;
-(void)		drawWithOpacity:(float)op red:(float)red;
-(void)		updatePositions;
-(void)		drawInfo;
-(void)		setSequenceBank:(id)b;


// accessors
-(WXSCAnimBodyPartBasic*)   elementAtIndex:(int)index;
-(int)  getSelectedIndex;
-(WXSCAnimBodyPartBasic*)   newElement;
-(id)		getImageCollection;
-(int)		lastIndex;
-(int)		count;

// definition
-(void)		removeAllImagesFromCollection;
-(void)		removeAllBody;
-(void)		removeBodyPartAtIndex:(int)index;
-(void)		prepareNewElement;
-(void)		setPointJoin:(int)pindex index:(int)index;
-(void)		setPoint1:(NSPoint)p;
-(void)		setDegreeAngle:(float)a;
-(void)		setFreedomDegree:(float)d1 d2:(float)d2;
-(void)		setSize:(float)x y:(float)y;
-(void)		setRelative:(BOOL)r;
-(void)		setShift:(float)xs index:(int)index;
-(void)		setPivotShift:(float)xs ys:(float)ys;
-(void)		setJoinShift:(float)xs ys:(float)ys;
-(void)		setImage:(NSString*)imageName;
-(void)		setImageToIndex:(int)index element:(int)element;
-(void)		setUseBlocks:(BOOL)state;
-(void)		setOnDisplay:(BOOL)state;
-(void)		setCanDragWhole:(BOOL)state;
-(void)		addNewElement:(NSString*)name;
-(void)		setShowPivot:(BOOL)v;
-(void)		loadImage:(NSString*)name;
-(void)		adjustImagesAsRemoved:(int)index;


// other
-(void)		updatePopUpForImage:(id)popMenu;
-(void)		makeBodyPartPopUpInto:(id)popMenu;

// mouse handling
-(void) selectNextPart;
-(void) findNearToSelect:(NSPoint)loc;
-(void) doMouseUp:(NSPoint)loc;
-(void) doMouseDown:(NSPoint)loc;
-(void) doMouseDragged:(NSPoint)loc flag:(unsigned int)flag;

// LOAD SAVE
-(IBAction) doLoadCharacter:(id)sender;
-(IBAction) doSaveAsCharacterAction:(id)sender;
-(void) writeDataUsing:(WXUsefullFileReadWrite*)reader;
-(void) loadDataUsing:(WXUsefullFileReadWrite*)reader;

// ******************************************************************************************

@end
