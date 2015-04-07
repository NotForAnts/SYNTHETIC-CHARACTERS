// ******************************************************************************************
//  WXSCAnimSequenceBank
//  Created by Paul Webb on Thu Jan 19 2006.
// ******************************************************************************************

#import "WXSCAnimSequenceBank.h"


@implementation WXSCAnimSequenceBank

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	currentIndex=0;
	
	theBodyGhost=[[WXSCAnimBodyWhole alloc]init];
	theBank=[[NSMutableArray alloc]init];
	displayString=[[WXDisplayStrings alloc]init];
	
	bankDocument=[[WXSCAnimDocument alloc]init];
	[bankDocument setSaveData:self];
	}
return self;
}
// ******************************************************************************************
-(void) setSequenceNameInto:(NSPopUpButton*)pop
{
int t,ci=[pop indexOfSelectedItem];

[pop removeAllItems];
for(t=0;t<[theBank count];t++)
	[pop addItemWithTitle:[[theBank objectAtIndex:t]sequenceName]];
	
if(ci<0) ci=0;	
[pop selectItemAtIndex:ci];	
}
// ******************************************************************************************
-(void) renderCurrentSequence
{
[[self current]renderSequence];
}
// ******************************************************************************************
-(int)  numberSequences {   return [theBank count]; } 
// ******************************************************************************************
-(void) playCurrentSequence
{
if([theBank count]==0)  return;
[[self current]playSequence];
}
// ******************************************************************************************
-(void) doDrawBody
{
int currentFrame;

if([theBank count]==0)  return;

if([[self current]inPlay] && [[self current]isRendered])
	{
	[[self current] showRendered];
	return;
	}



[self updateCurrent];

if(![[self current]inPlay])
	{
	currentFrame=[[self current]currentFrame];
	if(currentFrame>=0)
		{
		if(currentFrame==[[self current] numberFrames]-1)
			[[self current]putIntoPosition:currentFrame];
		else
			[[self current]putIntoPosition:currentFrame-1];
		[theBody updatePositions];
		[theBody drawWithOpacity:0.3 red:0.0];
		}
	
	if(currentFrame>0)	
	if(currentFrame<[[self current] numberFrames]-1)
		{
		[[self current]putIntoPosition:currentFrame+1];
		[theBody updatePositions];
		[theBody drawWithOpacity:0.2 red:1.0];
		}		
	}

[[self current] putIntoCurrent];
[theBody updatePositions];
[theBody draw];	
}
// ******************************************************************************************
-(void) updateCurrent
{
[[self current] updateCurrent];
}
// ******************************************************************************************
-(void)		setBody:(WXSCAnimBodyWhole*)body
{
theBody=body;
}
// ******************************************************************************************
-(WXSCAnimSequence*)	current
{
return [theBank objectAtIndex:currentIndex];
}
// ******************************************************************************************
-(void) setGuiTotal:(id)g			{		totalGui=g;				}
-(void) setGuiCurrent:(id)g			{		currentGui=g;			}
-(void) setGuiSlider:(id)g			{		sliderGui=g;			}
// ******************************************************************************************
-(void) adjustImagesAsRemoved:(int)index
{
int t;
for(t=0;t<[theBank count];t++)
	[[theBank objectAtIndex:t] adjustImagesAsRemoved:index];
}
// ******************************************************************************************
-(void)adjustJoinsAsDeletePartAtIndex:(int)index
{
int t;
for(t=0;t<[theBank count];t++)
	[[theBank objectAtIndex:t] adjustJoinsAsDeletePartAtIndex:index];
}
// ******************************************************************************************
-(void) removeAllSequenceFrames
{
[theBank makeObjectsPerformSelector:@selector(removeAllFrames)];
}
// ******************************************************************************************
-(void)		makeLotsNewSequenceWith:(int)number
{
int t;
for(t=0;t<number;t++)
	[self makeNewSequenceWith];

}
// ******************************************************************************************
-(void)		makeNewSequenceWith
{
WXSCAnimSequence*   newSequence=[[WXSCAnimSequence alloc]init];
[newSequence setBody:theBody];
[newSequence setGuiTotal:totalGui];
[newSequence setGuiCurrent:currentGui];
[newSequence setGuiSlider:sliderGui];
//[newSequence addFrame];
[newSequence setSequenceName:[NSString stringWithFormat:@"sequence %d",[theBank count]+1]];

[theBank addObject:newSequence];
[newSequence release];



return [theBank lastObject];
}
// ******************************************************************************************
- (void)drawRect:(NSRect)rect
{
NSRect  zone=NSMakeRect(0,0,rect.size.width,rect.size.height-11);
screeny=rect.size.height;

[[NSColor whiteColor]set];		
NSRectFill(zone);
zone=NSMakeRect(-2,0,rect.size.width+4,rect.size.height-11);
[[NSColor blackColor]set];		
NSFrameRect(zone);

[[self current]drawMiniImages];
}
// ******************************************************************************************
- (void)doMouseDown:(NSPoint)loc
{
[[self current]doMouseDown:loc];
}
// ******************************************************************************************
- (void)doMouseDrag:(NSPoint)loc
{
[[self current]doMouseDrag:loc];
}
// ******************************************************************************************
- (void)doMouseUp:(NSPoint)loc
{
[[self current]doMouseUp:loc];
}
// ******************************************************************************************
- (void)doSelectSequence:(int)seq
{
currentIndex=seq;
	
[[self current]doStop];	
[[self current]goStartIfPlaying];	
[[self current]gotoEnd];
[[self current]showInfo];
}
// ******************************************************************************************
// SAVE AND LOAD STUFF
// ******************************************************************************************
-(void) doReadFileData:(NSMutableData*)data
{
int t;

WXSCAnimSequence		*sequence;
int numberBanks;

WXUsefullFileReadWrite  *reader=[[WXUsefullFileReadWrite alloc]init];
[reader setData:data];
[reader prepareToRead];


[theBody loadDataUsing:reader];

[theBank removeAllObjects];
[reader readInteger:&numberBanks];
for(t=0;t<numberBanks;t++)
	{
	sequence=[self makeNewSequenceWith];
	[sequence loadDataUsing:reader];
	}

[reader release];

currentIndex=0;	
[[self current]doStop];	
[[self current]goStartIfPlaying];	
[[self current]gotoEnd];
[[self current]showInfo];
}
// ******************************************************************************************
-(NSMutableData*)		doWriteFileData
{
int t;
WXSCAnimSequence		*sequence;
NSMutableData			*data=[[NSMutableData alloc]init];
WXUsefullFileReadWrite  *reader=[[WXUsefullFileReadWrite alloc]init];
[reader setData:data];

[theBody writeDataUsing:reader];

[reader writeInteger:[theBank count]];
for(t=0;t<[theBank count];t++)
	{
	//printf("BANK %d\n",t);
	//printf("-----------\n");
	sequence=[theBank objectAtIndex:t];
	[sequence writeDataUsing:reader];
	}
			
		
[reader release];				


return data;
}
// ******************************************************************************************
-(IBAction) doLoadApplication:(id)sender
{
NSOpenPanel *panal=[[NSOpenPanel alloc]init];
NSArray *fileNames;
[panal setAllowsMultipleSelection:NO];
if([panal runModalForTypes:nil]==NSOKButton)
	{
	fileNames=[panal filenames];
	[bankDocument readFromFile:[fileNames objectAtIndex:0] ofType:@"am1"];
	}
}
// ******************************************************************************************
-(IBAction) doSaveAsApplicationAction:(id)sender
{
[bankDocument saveDocumentAs:sender];
}
// ******************************************************************************************
-(IBAction) doSaveApplicationAction:(id)sender
{
[bankDocument saveDocument:sender];
}
// ******************************************************************************************


@end
