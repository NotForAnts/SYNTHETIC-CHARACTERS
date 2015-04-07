// ******************************************************************************************
//  WXSCAnimImageCollection
//  Created by Paul Webb on Sat Jan 21 2006.
// ******************************************************************************************

#import "WXSCAnimImageCollection.h"

// ******************************************************************************************

@implementation WXSCAnimImageCollection

// ******************************************************************************************
-(id)		init
{
if(self=[super init])
	{
	thePopUpMenu=nil;
	theBody=nil;
	
	theImages=[[NSMutableArray alloc]init];
	imageNames=[[NSMutableArray alloc]init];
	imageFromFile=[[NSMutableArray alloc]init];
	}
return self;
}
// ******************************************************************************************
-(int)		count									{   return  [theImages count];						}
-(NSImage*) imageAtIndex:(int)index					{   return  [theImages objectAtIndex:index];		}
-(NSMutableString*) imageNameAtIndex:(int)index		{   return  [imageNames objectAtIndex:index];		} 
-(void)		setBody:(id)body						{   theBody=body;									}

// ******************************************************************************************
-(void)		removeAllImages
{
[theImages removeAllObjects];
[imageNames removeAllObjects];
[imageFromFile removeAllObjects];
if(thePopUpMenu!=nil) [self updatePopUpForImage:thePopUpMenu];
}
// ******************************************************************************************
-(void)		removeImageAtIndex:(int)index
{
[theImages removeObjectAtIndex:index];
[imageNames removeObjectAtIndex:index];
[imageFromFile removeObjectAtIndex:index];
if(thePopUpMenu!=nil) [self updatePopUpForImage:thePopUpMenu];

if(theBody!=nil)	[theBody adjustImagesAsRemoved:index];
}
// ******************************************************************************************
-(void)		removeImagesFromIndex:(int)index
{
int t,size=[theImages count];
for(t=index;t<size;t++)
	{
	[theImages removeObjectAtIndex:index];
	[imageNames removeObjectAtIndex:index];
	[imageFromFile removeObjectAtIndex:index];
	}
}
// ******************************************************************************************
-(void)		setImageByName:(NSString*)imageName element:(id)element
{
int t,size=[theImages count];
for(t=0;t<size;t++)
	{
	if([[imageNames objectAtIndex:t] isEqualToString:imageName])
		[element setImage:[theImages objectAtIndex:t] imageId:t];
	}
}
// ******************************************************************************************
-(void)		setImageByIndex:(int)index element:(id)element
{
if(index>=0 && index<[theImages count])
	[element setImage:[theImages objectAtIndex:index] imageId:index];
else
	[element setImage:nil imageId:-1];
}
// ******************************************************************************************
-(void)		replaceImageFromFile:(NSString*)name atIndex:(int)index
{
if(index>=[theImages count])
	{
	[self addImageFromFile:name];
	return;
	}
	
NSImage *newImage=nil;

newImage=[[NSImage alloc]initWithContentsOfFile:name];
if(newImage==nil)  
	{
	[self alert:name];
	return;
	}
	
[theImages replaceObjectAtIndex:index withObject:newImage];
[imageFromFile replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];	
[imageNames replaceObjectAtIndex:index withObject: [NSMutableString stringWithString:[name stringByAbbreviatingWithTildeInPath]]];

if(thePopUpMenu!=nil) [self updatePopUpForImage:thePopUpMenu];	
}
// ******************************************************************************************
-(void)		addImageFromFile:(NSString*)name
{
NSImage *newImage=nil;

newImage=[[NSImage alloc]initWithContentsOfFile:name];
if(newImage==nil)  
	{
	[self alert:name];
	return;
	}
	
[theImages addObject:newImage];
[imageFromFile addObject:[NSNumber numberWithBool:YES]];	
[imageNames addObject:[NSMutableString stringWithString:[name stringByAbbreviatingWithTildeInPath]]];

if(thePopUpMenu!=nil) [self updatePopUpForImage:thePopUpMenu];
}
// ******************************************************************************************
-(void)		alert:(NSString*)name
{
NSAlert *alert=[NSAlert alertWithMessageText:@"Image File Not Found" defaultButton:@"Okay" alternateButton:nil otherButton:nil informativeTextWithFormat:name];
[alert runModal];
}
// ******************************************************************************************
-(void)		loadImage:(NSString*)name
{
[theImages addObject:[self doLoadImage:name]];
[imageFromFile addObject:[NSNumber numberWithBool:NO]];	
[imageNames addObject:[NSMutableString stringWithString:name]];
}
// ******************************************************************************************
-(NSImage*) doLoadImage:(NSString*)imageName
{
NSImage* newimage;
newimage=[NSImage imageNamed:imageName];
[newimage	retain];
[newimage	lockFocus];
[newimage	unlockFocus];
return newimage;
}
// ******************************************************************************************
-(void)		updatePopUpForImage:(id)popMenu
{
int t;
[popMenu removeAllItems];
for(t=0;t<[imageNames count];t++)
	[popMenu addItemWithTitle:[imageNames objectAtIndex:t]];
	
thePopUpMenu=popMenu;	
}
// ******************************************************************************************
// LOAD SAVE
// ******************************************************************************************
-(void) writeDataUsing:(WXUsefullFileReadWrite*)reader
{
int t,size=[imageNames count];

[reader writeInteger:size];
for(t=0;t<size;t++)
	{
	[reader writeBool:[[imageFromFile objectAtIndex:t]boolValue]];
	[reader writeString:[imageNames objectAtIndex:t]];
	}
}
// ******************************************************************************************
-(void) loadDataUsing:(WXUsefullFileReadWrite*)reader
{
int t,number;
BOOL			fromFile;
NSMutableString *name=[[NSMutableString alloc]init];

[reader readInteger:&number];

if(number<[theImages count])
	{
	[self removeImagesFromIndex:number];
	}
	
for(t=0;t<number;t++)
	{
	[reader readBool:&fromFile];
	[reader readString:name];
	
	if(fromFile)	
		{
		[self replaceImageFromFile:[name stringByExpandingTildeInPath] atIndex:t];
		//printf("%s\n",[name cString]);
		//printf("%s\n",[[name stringByExpandingTildeInPath] cString]);
		}
	}
	
[name release];	
}
// ******************************************************************************************

@end
