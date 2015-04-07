// ******************************************************************************************
//  WXSCAnimBodyWhole
//  Created by Paul Webb on Tue Jan 17 2006.
// ******************************************************************************************
#import "WXSCAnimBodyWhole.h"


@implementation WXSCAnimBodyWhole

// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	saveDocument=[[WXSCAnimDocument alloc]init];
	[saveDocument setSaveData:self];
	
	theBody=[[NSMutableArray alloc]init];
	imageCollection=[[WXSCAnimImageCollection alloc]init];
	[imageCollection setBody:self];
	theBank=nil;
	}
return self;
}
// ******************************************************************************************
-(void)		setSequenceBank:(id)b
{
theBank=b;
}
// ******************************************************************************************
-(void)		makeBodyPartPopUpInto:(id)popMenu
{
int t;
[popMenu removeAllItems];
for(t=0;t<[theBody count];t++)
	[popMenu addItemWithTitle:[[theBody objectAtIndex:t]name]];
}
// ******************************************************************************************
-(void)		updatePopUpForImage:(id)popMenu
{
[imageCollection updatePopUpForImage:popMenu];
}
// ******************************************************************************************
-(void)		loadImage:(NSString*)name
{
[imageCollection loadImage:name];
}
// ******************************************************************************************
-(int)  getSelectedIndex
{
int t;
for(t=0;t<[theBody count];t++)
	{
	if([[theBody objectAtIndex:t]isSelected])   return t;
	}
return -1;
}
// ******************************************************************************************
-(id)   getImageCollection		{   return imageCollection;				}
-(int)		lastIndex			{   return lastIndex;					}
-(int)		count				{   return  [theBody count];			}
// ******************************************************************************************
-(WXSCAnimBodyPartBasic*)   elementAtIndex:(int)index
{
return [theBody objectAtIndex:index];
}
// ******************************************************************************************
-(void)		removeAllImagesFromCollection
{
[imageCollection removeAllImages];
}
// ******************************************************************************************
-(void)		removeBodyPartAtIndex:(int)index
{
[theBody removeObjectAtIndex:index];
int t;
for(t=0;t<[theBody count];t++)
	[[theBody objectAtIndex:t] adjustJoinsAsDeletePartAtIndex:index];
}
// ******************************************************************************************
-(void)		removeAllBody
{
[theBody removeAllObjects];
}
// ******************************************************************************************
-(void)		setPointJoin:(int)pindex index:(int)index;
{
[newElement setRefElement:pindex index:index];
}
// ******************************************************************************************
-(WXSCAnimBodyPartBasic*)   newElement  
{   
return newElement;  
}
// ******************************************************************************************
-(void)		prepareNewElement
{
newElement=[[WXSCAnimBodyPartBasic alloc]init];
}
// ******************************************************************************************
-(void)		setPoint1:(NSPoint)p
{
[newElement setPoint1:p];
}
// ******************************************************************************************
-(void)		setDegreeAngle:(float)a
{
[newElement setDegreeAngle:a];
}
// ******************************************************************************************
-(void)		setFreedomDegree:(float)d1 d2:(float)d2
{
[newElement setFreedomDegree:d1 d2:d2];
}
// ******************************************************************************************
-(void)		setSize:(float)x y:(float)y
{
[newElement setSize:x y:y];
}
// ******************************************************************************************
-(void)		setRelative:(BOOL)r
{
[newElement setRelative:r];
}
// ******************************************************************************************
-(void)		setShift:(float)xs index:(int)index
{
[newElement setShift:xs index:index];
}
// ******************************************************************************************
-(void)		setJoinShift:(float)xs ys:(float)ys
{
[newElement setJoinShift:xs ys:ys];
}
// ******************************************************************************************
-(void)		setPivotShift:(float)xs ys:(float)ys
{
[newElement setPivotShift:xs ys:ys];
}
// ******************************************************************************************
-(void)		setShowPivot:(BOOL)v
{
int t;
for(t=0;t<[theBody count];t++)
	[[theBody objectAtIndex:t] setShowPivot:v];
}
// ******************************************************************************************
-(void)		setUseBlocks:(BOOL)state
{
int t;
for(t=0;t<[theBody count];t++)
	[[theBody objectAtIndex:t] setUseBlocks:state];
}
// ******************************************************************************************
-(void)		setOnDisplay:(BOOL)state
{
[newElement setOnDisplay:state];
}
// ******************************************************************************************
-(void)		setCanDragWhole:(BOOL)state
{
[newElement setCanDragWhole:state];
}
// ******************************************************************************************
-(void)		setImageToIndex:(int)index element:(int)element
{
[imageCollection setImageByIndex:(int)index element:[theBody objectAtIndex:element]];
}
// ******************************************************************************************
-(void)		setImage:(NSString*)imageName
{
[imageCollection setImageByName:(NSString*)imageName element:newElement];
}
// ******************************************************************************************
-(void)		adjustImagesAsRemoved:(int)index
{
int t;
for(t=0;t<[theBody count];t++)
	[[theBody objectAtIndex:t] adjustImagesAsRemoved:index];
	
if(theBank!=nil) [theBank adjustImagesAsRemoved:index];
}
// ******************************************************************************************
-(void)		addNewElement:(NSString*)name
{
[newElement setName:name];
[newElement setBody:self];
[newElement setImageCollection:imageCollection];
[newElement setPartNumberIndex:[theBody count]];
[theBody addObject:newElement];
[newElement release];
lastIndex=[theBody count]-1;
}
// ******************************************************************************************
-(void)		drawInfo
{
int t;
for(t=0;t<[theBody count];t++)
	[[theBody objectAtIndex:t] drawInfoAt:40+t*30];
	
}
// ******************************************************************************************
-(void)		drawBlockWithScale:(float)scale xd:(float)xd yd:(float)yd
{
int t;
for(t=[theBody count]-1;t>=0;t--)
	[[theBody objectAtIndex:t]drawBlockWithScale:scale xd:xd yd:yd];
}
// ******************************************************************************************
-(void)		draw
{
[self drawWithOpacity:1.0 red:0.0];
}
// ******************************************************************************************
-(void)		drawWithOpacity:(float)op red:(float)red
{
int t;
for(t=[theBody count]-1;t>=0;t--)
	[[theBody objectAtIndex:t]drawWithOpacity:op red:red];
	
	
//[theBody makeObjectsPerformSelector:@selector(draw)];
[theBody makeObjectsPerformSelector:@selector(drawPivot)];
}
// ******************************************************************************************

// ******************************************************************************************
-(void)		updatePositions
{
WXSCAnimBodyPartBasic   *part;

[theBody makeObjectsPerformSelector:@selector(prepareUpdate)];
[theBody makeObjectsPerformSelector:@selector(updatePositionsSelfCall)];

return;
int t,size=[theBody count];
for(t=0;t<size;t++)
	{
	part=[theBody objectAtIndex:t];
	if(![part isJoined]) [part updatePositions];
	}
	
for(t=0;t<size;t++)
	{
	part=[theBody objectAtIndex:t];
	if([part isJoined]) [part updatePositions];
	}	
}
// ******************************************************************************************
//
//
// ******************************************************************************************
// MOUSE HANDLING
// ******************************************************************************************
-(void) findNearToSelect:(NSPoint)loc
{
int t,index=0;
float   minDist=1000000,dist;
for(t=0;t<[theBody count];t++)
	{
	dist=[[theBody objectAtIndex:t] getDistanceFrom:loc];
	if(dist<minDist)
		{
		minDist=dist;
		index=t;
		}
	}
	
[[theBody objectAtIndex:index]setSelected:YES];	
}
// ******************************************************************************************
-(void) doMouseUp:(NSPoint)loc
{
int t;
for(t=0;t<[theBody count];t++)
	[[theBody objectAtIndex:t] doMouseUp:loc];

}
// ******************************************************************************************
-(void) doMouseDown:(NSPoint)loc
{
int t;
for(t=0;t<[theBody count];t++)
	[[theBody objectAtIndex:t] deSelect];

for(t=0;t<[theBody count];t++)
	if([[theBody objectAtIndex:t] doMouseDown:loc]) return;
}
// ******************************************************************************************
-(void) doMouseDragged:(NSPoint)loc flag:(unsigned int)flag
{
int t;
for(t=0;t<[theBody count];t++)
	[[theBody objectAtIndex:t] doMouseDragged:loc flag:flag];
}
// ******************************************************************************************
-(void) selectNextPart
{
int index=[self getSelectedIndex];
if(index>=0) [[theBody objectAtIndex:index] setSelected:NO];
index++;
if(index>=[theBody count]) index=0;
[[theBody objectAtIndex:index] setSelected:YES];
}
// ******************************************************************************************
// LOAD SAVE
// ******************************************************************************************
-(IBAction) doLoadCharacter:(id)sender
{
NSOpenPanel *panal=[[NSOpenPanel alloc]init];
NSArray *fileNames;
[panal setAllowsMultipleSelection:NO];
if([panal runModalForTypes:nil]==NSOKButton)
	{
	fileNames=[panal filenames];
	[saveDocument readFromFile:[fileNames objectAtIndex:0] ofType:@"am1"];
	}
}
// ******************************************************************************************
-(IBAction) doSaveAsCharacterAction:(id)sender
{
[saveDocument saveDocumentAs:sender];
}
// ******************************************************************************************
// these are for saving only the character definition
// set up of position and image 
// ******************************************************************************************
-(NSMutableData*)		doWriteFileData
{
NSMutableData			*data=[[NSMutableData alloc]init];
WXUsefullFileReadWrite  *reader=[[WXUsefullFileReadWrite alloc]init];
[reader setData:data];
[self writeDataUsing:reader];
[reader release];				

return data;
}
// ******************************************************************************************
-(void) doReadFileData:(NSMutableData*)data
{
WXUsefullFileReadWrite  *reader=[[WXUsefullFileReadWrite alloc]init];
[reader setData:data];
[reader prepareToRead];
[self loadDataUsing:reader];
[reader release];
}
// ******************************************************************************************
// this saves / loads the information to the reader
// ******************************************************************************************
-(void) writeDataUsing:(WXUsefullFileReadWrite*)reader
{
int t,size=[theBody count];

[imageCollection writeDataUsing:reader];

[reader writeInteger:size];
for(t=0;t<size;t++)
	{
	[[theBody objectAtIndex:t]  writeDataUsing:reader];
	}
}
// ******************************************************************************************
-(void) loadDataUsing:(WXUsefullFileReadWrite*)reader
{
int t,size;
int		vint;
float   vflo;
BOOL	vblo;
NSMutableString *name=[[NSMutableString alloc]init];

[imageCollection loadDataUsing:reader];


[reader readInteger:&size];
[theBody removeAllObjects];

for(t=0;t<size;t++)
	{
	[self prepareNewElement];
	[reader readInteger:&vint];		[newElement setXPos:vint];
	[reader readInteger:&vint];		[newElement setYPos:vint];
	[reader readInteger:&vint];		[newElement setJoinPointIndex:vint];
	
	[reader readInteger:&vint];	
	[imageCollection setImageByIndex:vint element:newElement];
	
	[reader readInteger:&vint];		[newElement setJoinPartTo:vint];
	
	[reader readFloat:&vflo];		[newElement setRadianAngle:vflo];
	[reader readFloat:&vflo];		[newElement setXShift:vflo];
	[reader readFloat:&vflo];		[newElement setYShift:vflo];
	[reader readFloat:&vflo];		[newElement setXPivot:vflo];
	[reader readFloat:&vflo];		[newElement setYPivot:vflo];
	[reader readFloat:&vflo];		[newElement setXSize:vflo];
	[reader readFloat:&vflo];		[newElement setYSize:vflo];
	
	[reader readBool:&vblo];		[newElement setIsJoined:vblo];
	[reader readBool:&vblo];		[newElement setIsAbsoluteAngle:!vblo];
	[reader readBool:&vblo];		[newElement setOnDisplay:vblo];
	[reader readString:name];		
	
	[self addNewElement:name];   
	}
	
[self setUseBlocks:NO];	
[self setUseBlocks:YES];	

[name release];
[self updatePositions];
[self updatePositions];
[self updatePositions];
[self updatePositions];
}
// ******************************************************************************************

@end
