// ******************************************************************************************
//  WXSCAnimBankView
//  Created by Paul Webb on Thu Jan 19 2006.
// ******************************************************************************************

#import "WXSCAnimBankView.h"

// ******************************************************************************************

@implementation WXSCAnimBankView


// ******************************************************************************************
- (id)initWithFrame:(NSRect)frameRect
{
if ((self = [super initWithFrame:frameRect]) != nil)
	{
	clipBoard=[[NSMutableArray alloc]init];
	viewWidth=frameRect.size.width;
	viewHeight=frameRect.size.height;
	[self initGui];

	}
return self;
}
// ******************************************************************************************
-(id)		getScrollBar			{   return hScrollBar;  }
// ******************************************************************************************
-(void) makePopUp
{
[theBank setSequenceNameInto:sequencePopUp];
}
// ******************************************************************************************
-(void) initGui
{
sequencePopUp=[[NSPopUpButton alloc]initWithFrame:NSMakeRect(20,viewHeight-15,150,15)];
[[sequencePopUp cell]setControlSize:NSMiniControlSize];
[[sequencePopUp cell]setFont:[NSFont fontWithName: @"Helvetica" size:9]];
[sequencePopUp setTarget:self];
[sequencePopUp setAction:@selector(sequencePopAction:)];


//sequenceName=[[NSTextField alloc]initWithFrame:NSMakeRect(180,viewHeight-15,150,15)];
//[[sequenceName cell]setControlSize:NSMiniControlSize];
//[[sequenceName cell]setFont:[NSFont fontWithName: @"Helvetica" size:9]];
//[sequenceName setEditable:YES];
//[sequenceName setTarget:self];
//[sequenceName setAction:@selector(nameAction:)];

hScrollBar=[[NSScroller alloc]initWithFrame:NSMakeRect(0,0,viewWidth,15)];
[hScrollBar setFloatValue:0.0 knobProportion:0.02];
[hScrollBar setEnabled:YES];
[hScrollBar setTarget:self];
[hScrollBar setAction:@selector(scrollBarAction:)];

[self addSubview:sequencePopUp];
[self addSubview:hScrollBar];
//[self addSubview:sequenceName];
}
// ******************************************************************************************
-(IBAction) addSequenceAction:(id)sender
{
[theBank makeNewSequenceWith];
[self makePopUp];
}
// ******************************************************************************************
-(IBAction) makePartSettingTillEndSelectionAction:(id)sender
{
[[theBank current] makePartSettingTillEndSelection];
[self setNeedsDisplay:true];
[stageView setNeedsDisplay:YES];
[stageView updateSelected];
}
// ******************************************************************************************
-(IBAction) inbetweenAction:(id)sender 
{
[[theBank current] inbetweenSelection:[inbetweenFrames intValue]];
[self setNeedsDisplay:true];
[stageView setNeedsDisplay:YES];
[stageView updateSelected];
}
// ******************************************************************************************
-(IBAction) reverseAction:(id)sender
{
[[theBank current] reverseSelection];
[self setNeedsDisplay:true];
[stageView setNeedsDisplay:YES];
[stageView updateSelected];
}
// ******************************************************************************************
-(IBAction) copyAction:(id)sender
{
[[theBank current] copySelectionInto:clipBoard];
[self setNeedsDisplay:true];
}
// ******************************************************************************************
-(IBAction) cutAction:(id)sender
{
[[theBank current] cutSelection:clipBoard];
[self setNeedsDisplay:true];
}
// ******************************************************************************************
-(IBAction) pasteAction:(id)sender
{
[[theBank current] pasteSelection:clipBoard];
[self setNeedsDisplay:true];
}
// ******************************************************************************************
-(IBAction) selectAllAction:(id)sender
{
[[theBank current]setSelect1:0];
[[theBank current]setSelect2:[[theBank current]numberFrames]-1];
[self setNeedsDisplay:true];
}
// ******************************************************************************************
-(IBAction) deleteAllAction:(id)sender
{
[[theBank current] deleteSelection];
[self setNeedsDisplay:true];
}
// ******************************************************************************************
-(IBAction) select1Action:(id)sender
{
[[theBank current]setSelect1:[sender intValue]-1];
[self setNeedsDisplay:true];
}
// ******************************************************************************************
-(IBAction) select2Action:(id)sender
{
[[theBank current]setSelect2:[sender intValue]-1];
[self setNeedsDisplay:true];
}
// ******************************************************************************************
-(IBAction) nameAction:(id)sender
{
[[theBank current]setSequenceName:[sender stringValue]];
[self makePopUp];
}
// ******************************************************************************************
-(IBAction) sequencePopAction:(id)sender
{
int selected=[sender indexOfSelectedItem];
[theBank doSelectSequence:selected];
[self setNeedsDisplay:true];
}
// ******************************************************************************************
-(IBAction) scrollBarAction:(id)sender
{
[[theBank current] gotoSliderValue:[sender floatValue]];
[self setNeedsDisplay:YES];
[stageView setNeedsDisplay:YES];
[stageView updateSelected];
}
// ******************************************************************************************
-(void) setBank:(id)bank		{   theBank=bank;   }
-(void) setStage:(id)v			{   stageView=v;	}
// ******************************************************************************************
- (void)drawRect:(NSRect)rect
{
[theBank drawRect:rect];
[sequenceName setStringValue:[[theBank current] sequenceName]];
[selectOne setIntValue:[[theBank current] select1]+1];
[selectTwo setIntValue:[[theBank current] select2]+1];
}
// ******************************************************************************************
- (void)mouseDown:(NSEvent *)theEvent
{
NSPoint mouseLoc = [self convertPoint:[theEvent locationInWindow] fromView:nil];
[theBank doMouseDown:mouseLoc];
[self setNeedsDisplay:YES];
[stageView setNeedsDisplay:YES];
[stageView updateSelected];
}
// ******************************************************************************************
- (void)mouseDragged:(NSEvent *)theEvent
{
NSPoint mouseLoc = [self convertPoint:[theEvent locationInWindow] fromView:nil];

if(mouseLoc.x<0)
	{
	[[theBank current]  previousFrame];
	[self setNeedsDisplay:YES];
	[stageView setNeedsDisplay:YES];
	[stageView updateSelected];
	return;
	}
	
if(mouseLoc.x>viewWidth)
	{
	[[theBank current] nextFrame];
	[self setNeedsDisplay:YES];
	[stageView setNeedsDisplay:YES];
	[stageView updateSelected];
	return;
	}


[theBank doMouseDrag:mouseLoc];
[self setNeedsDisplay:YES];
[stageView setNeedsDisplay:YES];
[stageView updateSelected];
}
// ******************************************************************************************
- (void)mouseUp:(NSEvent *)theEvent
{
NSPoint mouseLoc = [self convertPoint:[theEvent locationInWindow] fromView:nil];
[theBank doMouseUp:mouseLoc];
[self setNeedsDisplay:YES];
[stageView setNeedsDisplay:YES];
[stageView updateSelected];
}
// ******************************************************************************************
- (BOOL)canBecomeKeyView		{   return YES; }
- (BOOL)acceptsFirstResponder   {   return YES; }
// ******************************************************************************************
- (void)keyDown:(NSEvent*)theEvent
{
[stageView keyDown:theEvent];
}
// ******************************************************************************************

@end
