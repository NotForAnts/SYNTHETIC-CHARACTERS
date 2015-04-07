// ******************************************************************************************
//  ANIMATIONview
//  Created by Paul Webb on Thu Feb 2 2006.
// ******************************************************************************************

#import "WXSCAnimCharImageView.h"

// ******************************************************************************************

@implementation WXSCAnimCharImageView

// ******************************************************************************************

- (id)initWithFrame:(NSRect)frameRect
{
if ((self = [super initWithFrame:frameRect]) != nil) 
	{
	selected=-1;
	scrollX=0;
	screenX=frameRect.size.width;
	screenY=frameRect.size.height;
	validY=screenY-30;
	bsize=validY-15;
	
	displayString=[[WXDisplayStrings alloc]init];
	
	[self initGui];
	}
return self;
}
// ******************************************************************************************
-(void) setImageCollection:(id)c		{	imageCollection=c;		}
-(void) setSelected:(int)v				
{   
selected=v;			
[self setNeedsDisplay:YES];	
}
// ******************************************************************************************
-(void) initGui
{
hScrollBar=[[NSScroller alloc]initWithFrame:NSMakeRect(0,0,screenX-11,15)];
[hScrollBar setFloatValue:0.0 knobProportion:0.02];
[hScrollBar setEnabled:YES];
[hScrollBar setTarget:self];
[hScrollBar setAction:@selector(scrollBarAction:)];

button1=[[NSButton alloc]initWithFrame:NSMakeRect(10,screenY-22,100,18)]; 
[button1 setButtonType:NSMomentaryPushInButton];
[button1 setBezelStyle:NSTexturedSquareBezelStyle];
[button1 setTitle:@"Add Image"];
[[button1 cell]setControlSize:NSMiniControlSize];
[[button1 cell]setFont:[NSFont fontWithName: @"Helvetica" size:10]];
[button1 setEnabled:YES];
[button1 setTarget:self];
[button1 setAction:@selector(addImageAction:)];


button2=[[NSButton alloc]initWithFrame:NSMakeRect(130,screenY-22,100,18)]; 
[button2 setButtonType:NSMomentaryPushInButton];
[button2 setBezelStyle:NSTexturedSquareBezelStyle];
[button2 setTitle:@"Remove Image"];
[[button2 cell]setControlSize:NSMiniControlSize];
[[button2 cell]setFont:[NSFont fontWithName: @"Helvetica" size:10]];
[button2 setEnabled:YES];
[button2 setTarget:self];
[button2 setAction:@selector(removeImageAction:)];


[self addSubview:hScrollBar];
[self addSubview:button1];
[self addSubview:button2];
}
// ******************************************************************************************
- (void)drawRect:(NSRect)rect
{
int t,size=[imageCollection count],ypos=15,xpos,gap=25;
NSImage *anImage;
NSMutableString *imageName=[[NSMutableString alloc]init];
NSSize  newSize;
NSRect  brect;

[[NSColor blackColor]set]; 
[NSBezierPath strokeLineFromPoint:NSMakePoint(0,ypos+bsize) toPoint:NSMakePoint(screenX,ypos+bsize)];

xpos=-scrollX;
for(t=0;t<size;t++)
	{
	if(xpos+bsize>=0)
		{
		anImage=[imageCollection imageAtIndex:t];
		[imageName setString:[imageCollection imageNameAtIndex:t]];
		
		if([imageName length]>15)   
			{
			[imageName deleteCharactersInRange:NSMakeRange(0,[imageName length]-13)];
			[imageName insertString:@"..." atIndex:0];
			}
		
		newSize=[anImage size];
		
		brect=NSMakeRect(xpos,ypos,bsize,bsize);
		if(selected==t)
			{
			[[NSColor grayColor]set];  
			NSRectFill(brect);
			}
		[[NSColor blackColor]set];  NSFrameRect(brect);
		
		brect=NSMakeRect(xpos+gap,ypos+10,bsize-gap*2,bsize-gap*2);
		[anImage drawInRect:brect fromRect:NSMakeRect(0,0,newSize.width,newSize.height) operation:NSCompositeSourceOver fraction:1.0];

		[displayString formatNumberAt:xpos+20 y:validY-12 value:t+1 zero:3 color:[NSColor blackColor]];
		[displayString textAt:xpos+20 y:validY-22 text:imageName color:[NSColor blackColor]];
			}
	xpos=xpos+bsize;
	if(xpos>screenX)	break;
	}
[imageName release];	
}
// ******************************************************************************************
-(IBAction) removeImageAction:(id)sender
{
int size=[imageCollection count];

if(selected>=0 && selected<size)
	{
	[imageCollection removeImageAtIndex:selected];
	[self setNeedsDisplay:YES];
	}
}
// ******************************************************************************************
-(IBAction) addImageAction:(id)sender
{
NSString		*newFileName=[[NSString alloc]init];
NSOpenPanel		*openPanel=[[NSOpenPanel alloc]init];
 
FSSpec movieSpec;
                
if([openPanel runModalForDirectory:nil file:nil types:nil]==NSFileHandlingPanelCancelButton)	return;
newFileName=[openPanel filename];

[imageCollection addImageFromFile:newFileName];
[self setNeedsDisplay:YES];
}
// ******************************************************************************************
-(IBAction) scrollBarAction:(id)sender
{
int size=[imageCollection count];

scrollX=WXUNormalise([sender floatValue],0,1.0,0,size*bsize-screenX-2);

[self setNeedsDisplay:YES];
}
// ******************************************************************************************
- (void)mouseDown:(NSEvent *)theEvent
{
NSPoint mouseLoc = [self convertPoint:[theEvent locationInWindow] fromView:nil];

selected=(mouseLoc.x+scrollX)/bsize;
[self setNeedsDisplay:YES];

}

// ******************************************************************************************

@end
