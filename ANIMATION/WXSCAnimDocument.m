// ******************************************************************************************
//  WXSCAnimDocument
//  Created by Paul Webb on Thu Jan 19 2006.
// ******************************************************************************************

#import "WXSCAnimDocument.h"


@implementation WXSCAnimDocument

// ******************************************************************************************
-(void)		setSaveData:(id)sd
{
theSaveData=sd;
}
// ******************************************************************************************
- (NSString *)fileType
{
return @"sm1";
}
// ******************************************************************************************
- (BOOL)loadDataRepresentation:(NSData *)docData ofType:(NSString *)docType
{
[theSaveData doReadFileData:docData];
return YES;
}
// ******************************************************************************************

- (NSData *)dataRepresentationOfType:(NSString *)aType
{
return [theSaveData doWriteFileData];
}
// ******************************************************************************************


@end
