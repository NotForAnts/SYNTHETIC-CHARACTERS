// ******************************************************************************************
//  WXSCAnimBankView
//  Created by Paul Webb on Thu Jan 19 2006.
// ******************************************************************************************

#import <Cocoa/Cocoa.h>
#import "WXSCAnimSequenceBank.h"

// *****************************************************************************************


@interface WXSCAnimBankView : NSView
{
float   viewWidth,viewHeight;

WXSCAnimSequenceBank	*theBank;
NSPopUpButton			*sequencePopUp;
NSScroller				*hScrollBar;
//NSTextField				*sequenceName;

NSMutableArray  *clipBoard;

IBOutlet id sequenceName;
IBOutlet id selectOne;
IBOutlet id selectTwo;
IBOutlet id inbetweenFrames;

id  stageView;
}


-(void)		setBank:(id)bank;
-(void)		setStage:(id)v;

-(IBAction) copyAction:(id)sender;
-(IBAction) cutAction:(id)sender;
-(IBAction) pasteAction:(id)sender;
-(IBAction) selectAllAction:(id)sender;
-(IBAction) deleteAllAction:(id)sender;
-(IBAction) reverseAction:(id)sender;
-(IBAction) inbetweenAction:(id)sender;
-(IBAction) makePartSettingTillEndSelectionAction:(id)sender;

-(IBAction) addSequenceAction:(id)sender;
-(IBAction) select1Action:(id)sender;
-(IBAction) select2Action:(id)sender;
-(IBAction) nameAction:(id)sender;
-(IBAction) sequencePopAction:(id)sender;
-(IBAction) scrollBarAction:(id)sender;
-(id)		getScrollBar;

// ******************************************************************************************

@end
