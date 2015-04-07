// ******************************************************************************************
//  WXSCAnimImageCollection
//  Created by Paul Webb on Sat Jan 21 2006.
// ******************************************************************************************


#import <Foundation/Foundation.h>
#import "WXUsefullFileReadWrite.h"
// ******************************************************************************************

@interface WXSCAnimImageCollection : NSObject {

id  theBody;
NSMutableArray  *theImages;
NSMutableArray  *imageNames;
NSMutableArray  *imageFromFile;

id  thePopUpMenu;
}

-(int)		count;
-(NSImage*) imageAtIndex:(int)index;
-(NSMutableString*) imageNameAtIndex:(int)index;

-(void)		removeAllImages;
-(void)		removeImageAtIndex:(int)index;
-(void)		setImageByIndex:(int)index element:(id)element;
-(void)		setImageByName:(NSString*)imageName element:(id)element;
-(void)		addImageFromFile:(NSString*)name;
-(void)		replaceImageFromFile:(NSString*)name atIndex:(int)index;
-(void)		loadImage:(NSString*)name;
-(NSImage*) doLoadImage:(NSString*)imageName;
-(void)		updatePopUpForImage:(id)popMenu;
-(void)		setBody:(id)body;
-(void)		alert:(NSString*)name;

// LOAD SAVE
-(void) writeDataUsing:(WXUsefullFileReadWrite*)reader;
-(void) loadDataUsing:(WXUsefullFileReadWrite*)reader;

// ******************************************************************************************


@end
