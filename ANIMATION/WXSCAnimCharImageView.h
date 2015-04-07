// ******************************************************************************************
//  ANIMATIONview
//  Created by Paul Webb on Thu Feb 2 2006.
// ******************************************************************************************

#import <Cocoa/Cocoa.h>
#import "WXSCAnimImageCollection.h"
#import "WXDisplayStrings.h"
// ******************************************************************************************

@interface WXSCAnimCharImageView : NSView
{
float   screenX,screenY,scrollX;
float   validY;
float   bsize;

int		selected;
WXSCAnimImageCollection *imageCollection;
WXDisplayStrings		*displayString;

NSScroller			*hScrollBar;
NSButton			*button1;
NSButton			*button2;
}

-(void) initGui;
-(void) setImageCollection:(id)c;
-(void) setSelected:(int)v;

-(IBAction) addImageAction:(id)sender;
-(IBAction) removeImageAction:(id)sender;
-(IBAction) scrollBarAction:(id)sender;
// ******************************************************************************************

@end
