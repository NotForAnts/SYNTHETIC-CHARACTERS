// ******************************************************************************************
//  WXSCAnimSequence
//  Created by Paul Webb on Thu Jan 19 2006.
// ******************************************************************************************

#import "WXSCAnimSequence.h"


@implementation WXSCAnimSequence


// ******************************************************************************************
-(id)   init
{
if(self=[super init])
	{
	doPlay=NO;
	select1=select2=-1;
	selectType=1;
	currentIndex=0;
	theSequence=[[NSMutableArray alloc]init];
	currentPosition=[[NSMutableArray alloc]init];
	displayString=[[WXDisplayStrings alloc]init];
	sequenceName=[[NSMutableString alloc]init];
	
	renderedSequence=[[WXSCAnimRenderedSequence alloc]init];
	}
return self;
}

// ******************************************************************************************
-(void) showRendered
{
[renderedSequence showImage:currentIndex];
}
// ******************************************************************************************
-(void) renderSequence
{
[renderedSequence reset];

int t;
currentIndex=0;
for(t=0;t<[theSequence count];t++)
	{
	[self putIntoPosition:t];
	[theBody updatePositions];

	[renderedSequence makeNewImage];
	[renderedSequence lock]; 
	[theBody draw];	
	[renderedSequence unlock]; 
	
	[renderedSequence addImage];
	}

isRendered=YES;
currentIndex=0;
}
// ******************************************************************************************
-(void) drawMiniImages
{
int t=0,diff=[theSequence count]-currentIndex;

diff=17;
int startIndex=currentIndex-diff;
if(startIndex<0) startIndex=0;

[self updateCurrent];
while(startIndex<[theSequence count])
	{
	[self putIntoPosition:startIndex];
	[theBody updatePositions];
	
	if(startIndex==currentIndex)[[NSColor grayColor]set];else[[NSColor whiteColor]set];
	NSRectFill(NSMakeRect(t*50,15,50,64));
	
	if(startIndex>=select1 && startIndex<=select2) 	
		{
		[[NSColor redColor]set];
		NSRectFill(NSMakeRect(t*50,65,50,14));
		}	
	
	[theBody drawBlockWithScale:0.1 xd:10+t*50 yd:20];
	[[NSColor blackColor]set];
	NSFrameRect(NSMakeRect(t*50,15,50,50));
	NSFrameRect(NSMakeRect(t*50,15,50,64));
	
	[displayString formatNumberAt:t*50+16 y:65 value:startIndex+1 zero:3 color:[NSColor blackColor]];
	
	startIndex++;
	t++;
	if(10+t*50>1100)	break;
	}
	
[self putIntoCurrent];
[theBody updatePositions];	
}

// ******************************************************************************************
-(void) setBody:(id)body				{		theBody=body;				}
-(void) setGuiTotal:(id)g				{		totalGui=g;					}
-(void) setGuiCurrent:(id)g				{		currentGui=g;				}
-(void) setGuiSlider:(id)g				{		sliderGui=g;				}
-(NSMutableArray*)  theSequence			{		return theSequence;			}
-(int)  numberFrames					{		return [theSequence count]; }
-(int)  currentFrame					{		return currentIndex;		}
-(BOOL) inPlay							{		return doPlay;				}
-(BOOL) isRendered						{		return isRendered;			}
-(int)  select1							{		return select1;				}
-(int)  select2							{		return select2;				}
-(void) setSelect1:(int)v				{		select1=WXUBetween(0,[theSequence count]-1,v);					}
-(void) setSelect2:(int)v				{		select2=WXUBetween(0,[theSequence count]-1,v);					}
-(NSMutableString*)sequenceName			{		return sequenceName;		}
-(void) setSequenceName:(NSString*)n	{		[sequenceName setString:n]; }
// ******************************************************************************************
-(void) showInfo
{
[totalGui setIntValue:[theSequence count]];
[currentGui setIntValue:currentIndex+1];
[sliderGui setFloatValue:WXUNormalise(currentIndex+1,1,[theSequence count],0.0,1.0)];
}
// ******************************************************************************************
-(void) addFrame
{
if(doPlay) return;
[self createPosition];
[theSequence addObject:newPosition];
[newPosition release];	
[totalGui setIntValue:[theSequence count]];

currentIndex=[theSequence count]-1;
[currentGui setIntValue:currentIndex+1];
[sliderGui setFloatValue:WXUNormalise(currentIndex+1,1,[theSequence count],0,1.0)];
}

// ******************************************************************************************
-(void) insertAfterCurrent
{
if(doPlay) return;
if(currentIndex==[theSequence count]-1)
	{
	[self addFrame];
	return;
	}
	
[self createPosition];
[theSequence insertObject:newPosition atIndex:currentIndex+1];
[newPosition release];	
[totalGui setIntValue:[theSequence count]];
	
currentIndex++;
if(currentIndex>=[theSequence count]-1) currentIndex=[theSequence count]-1;
	
[totalGui setIntValue:[theSequence count]];
[currentGui setIntValue:currentIndex+1];
[sliderGui setFloatValue:WXUNormalise(currentIndex+1,1,[theSequence count],0,1.0)];
[self putIntoPosition:currentIndex];
}
// ******************************************************************************************
-(void) replaceCurrent
{
if(doPlay) return;
if(currentIndex>=0 && currentIndex<[theSequence count])
	{
	[self createPosition];
	[theSequence replaceObjectAtIndex:currentIndex withObject:newPosition];
	[newPosition release];	
	[totalGui setIntValue:[theSequence count]];
	
	currentIndex++;
	if(currentIndex>=[theSequence count]-1) currentIndex=[theSequence count]-1;
	
	[totalGui setIntValue:[theSequence count]];
	[currentGui setIntValue:currentIndex+1];
	[sliderGui setFloatValue:WXUNormalise(currentIndex+1,1,[theSequence count],0,1.0)];
	[self putIntoPosition:currentIndex];
	}
}
// ******************************************************************************************
-(void) createPosition
{
newPosition=[[NSMutableArray alloc]init];
[self putPositionInto:newPosition];
}
// ******************************************************************************************
-(void) putPositionInto:(NSMutableArray*)thePosition
{
int t;
WXSCAnimBodyPartBasic   *part;
NSMutableDictionary		*newDictionary;

[thePosition removeAllObjects];

for(t=0;t<[theBody count];t++)
	{
	newDictionary=[[NSMutableDictionary alloc]init];
	
	part=[theBody elementAtIndex:t];

	[self setValuesForPart:newDictionary angle:[part getAngle] 
								px:[part pivotX] py:[part pivotY] 
								sx:[part shiftX] sy:[part shiftY] 
								xp:[part getPoint1].x yp:[part getPoint1].y
								ji:[part joinIndex] im:[part imageIndexId] 
								join:[part isJoined] abs:[part isAbsAngle]
								piv:[part joinPointIndex]];		

	
	[thePosition addObject:newDictionary];
	[newDictionary release];
	}
}
// ******************************************************************************************
-(void) copySelectionInto:(NSMutableArray*)dest
{
int t;

if(select1<0 || select1>=[theSequence count])   return;
if(select2<0 || select2>=[theSequence count])   return;
[dest removeAllObjects];

for(t=select1;t<=select2;t++)
	{
	[self putIntoPosition:t];
	[self createPosition];
	[dest addObject:newPosition];
	[newPosition release];
	}
}
// ******************************************************************************************
-(void) cutSelection:(NSMutableArray*)dest
{
[self copySelectionInto:dest];
[self deleteSelection];
}
// ******************************************************************************************
-(void) pasteSelection:(NSMutableArray*)source
{
int t;
for(t=0;t<[source count];t++)
	{
	[self putIntoPositionUsingPosition:[source objectAtIndex:t]];
	[self insertAfterCurrent];
	}
select1=select2=-1;	
}
// ******************************************************************************************
-(void) adjustImagesAsRemoved:(int)index
{
int t,p,imageIndex;
NSMutableArray		*pos;
NSMutableDictionary *dict;
for(t=0;t<[theSequence count];t++)
	{
	pos=[theSequence objectAtIndex:t];
	for(p=0;p<[pos count];p++)
		{
		dict=[pos objectAtIndex:p];
		imageIndex=[[dict objectForKey:@"image"]intValue];
		if(imageIndex>index)	imageIndex--; else
		if(imageIndex==index)   imageIndex=-1;
		
		[dict setObject:[NSNumber numberWithInt:imageIndex] forKey:@"image"];
		}
	}
}
// ******************************************************************************************
-(void)adjustJoinsAsDeletePartAtIndex:(int)index
{
int t,p,joinIndex;
NSMutableArray		*pos;
NSMutableDictionary *dict;

for(t=0;t<[theSequence count];t++)
	{
	pos=[theSequence objectAtIndex:t];
	[pos removeObjectAtIndex:index];
	for(p=0;p<[pos count];p++)
		{
		dict=[pos objectAtIndex:p];
		joinIndex=[[dict objectForKey:@"joinIndex"]intValue];
		if(joinIndex>index)	joinIndex--; else
		if(joinIndex==index)   
			{
			[dict setObject:[NSNumber numberWithBool:NO] forKey:@"join"];
			joinIndex=-1;
			}
		
		[dict setObject:[NSNumber numberWithInt:joinIndex] forKey:@"joinIndex"];
		}
	}
	
[self updateCurrent];	
}
// ******************************************************************************************
-(void) removeAllFrames
{
[theSequence removeAllObjects];
[self showInformation];
[self putIntoPosition:currentIndex];
select1=select2=-1;	
}
// ******************************************************************************************
-(void) deleteSelection
{
if(select1<0 || select1>=[theSequence count])   return;
if(select2<0 || select2>=[theSequence count])   return;
[theSequence removeObjectsInRange:NSMakeRange(select1,select2-select1+1)];
if(currentIndex>=[theSequence count]) currentIndex=[theSequence count]-1;
select1=select2=-1;
[self showInformation];
[self putIntoPosition:currentIndex];
}
// ******************************************************************************************
-(void) makePartSettingTillEndSelection
{
if(select1<0 || select1>=[theSequence count])   return;
if(select2<0 || select2>=[theSequence count])   return;

int t,selectedPart=[theBody getSelectedIndex];
if(selectedPart<0)  return;

float   angle,px,py,sx,sy,xp,yp;
int		joinIndex,image,pivot;
BOOL	join,absolute;

NSMutableArray		*position1=[theSequence objectAtIndex:select1];
NSMutableDictionary *part1=[position1 objectAtIndex:selectedPart];

[self getValuesForPart:part1 angle:&angle px:&px py:&py sx:&sx sy:&sy xp:&xp yp:&yp
								ji:&joinIndex im:&image join:&join abs:&absolute piv:&pivot];


for(t=select1+1;t<=select2;t++)
	{
	position1=[theSequence objectAtIndex:t];
	part1=[position1 objectAtIndex:selectedPart];
	[self setValuesForPart:part1 angle:angle px:px py:py sx:sx sy:sy xp:xp yp:yp
								ji:joinIndex im:image join:join abs:absolute piv:pivot];
	}


[self showInformation];
[self putIntoPosition:currentIndex];
}
		
// ******************************************************************************************
-(void) inbetweenSelection:(int)numberBetweens
{
if(select1<0 || select1>=[theSequence count])   return;
if(select2<0 || select2>=[theSequence count])   return;

NSMutableArray		*position1; 
NSMutableArray		*position2;
NSMutableArray		*thePosition;
NSMutableDictionary *part1;
NSMutableDictionary *part2;
NSMutableDictionary *newPart;

int t,f,p;
float   angle1,px1,py1,sx1,sy1,xp1,yp1;
float   angle2,px2,py2,sx2,sy2,xp2,yp2;
float   angle3,px3,py3,sx3,sy3,xp3,yp3;
int		joinIndex,image,position,pivot;
BOOL	join,absolute;

position=select1;
for(p=select1;p<select2;p++)
	{

	position1=[theSequence objectAtIndex:position];
	position2=[theSequence objectAtIndex:position+1];



for(f=numberBetweens;f>0;f--)
	{
	thePosition=[[NSMutableArray alloc]init];
	for(t=0;t<[position1 count];t++)
		{
		
		part1=[position1 objectAtIndex:t];
		part2=[position2 objectAtIndex:t];
		
		[self getValuesForPart:part2 angle:&angle2 px:&px2 py:&py2 sx:&sx2 sy:&sy2 xp:&xp2 yp:&yp2
								ji:&joinIndex im:&image join:&join abs:&absolute piv:&pivot];	
		
		[self getValuesForPart:part1 angle:&angle1 px:&px1 py:&py1 sx:&sx1 sy:&sy1 xp:&xp1 yp:&yp1
								ji:&joinIndex im:&image join:&join abs:&absolute piv:&pivot];	
		
		
		angle3=[self quickestAngleNormalise:f v1:0 v2:numberBetweens+1 a1:angle1 a2:angle2];
		
		
		px3=WXUNormalise(f,0,numberBetweens+1,px1,px2);
		py3=WXUNormalise(f,0,numberBetweens+1,py1,py2);
		sx3=WXUNormalise(f,0,numberBetweens+1,sx1,sx2);
		sy3=WXUNormalise(f,0,numberBetweens+1,sy1,sy2);
		xp3=WXUNormalise(f,0,numberBetweens+1,xp1,xp2);
		yp3=WXUNormalise(f,0,numberBetweens+1,yp1,yp2);
		
		newPart=[[NSMutableDictionary alloc]init];
		[self setValuesForPart:newPart angle:angle3 px:px3 py:py3 sx:sx3 sy:sy3 xp:xp3 yp:yp3
								ji:joinIndex im:image join:join abs:absolute piv:pivot];		
		

		[thePosition addObject:newPart];
		[newPart release];	
		}
	


	[theSequence insertObject:thePosition atIndex:position+1];
	[thePosition release];
	}
	
	position=position+numberBetweens+1;
	}

[self showInformation];
[self putIntoPosition:currentIndex];
}
// ******************************************************************************************
-(float)	quickestAngleNormalise:(float)v v1:(float)v1 v2:(float)v2 a1:(float)a1 a2:(float)a2
{
float   clock,anti;
float   twoPi=WXUPIE()*2.0;

if(a1==a2)  return a1;

if(a2>a1)
	{
	anti=a2-a1;
	clock=(twoPi-a2)+a1;
	if(anti<clock)
		return WXUNormalise(v,v1,v2,a1,a2);
	else
		return WXUNormalise(v,v1,v2,a1+twoPi,a2);
	}
else
	{
	clock=a1-a2;
	anti=(twoPi-a1)+a2;
	if(anti<clock)  
		return WXUNormalise(v,v1,v2,a1-twoPi,a2);
	else
		return WXUNormalise(v,v1,v2,a1,a2);
	}	
	
return 0;	
}
// ******************************************************************************************
-(void) reverseSelection
{
if(select1<0 || select1>=[theSequence count])   return;
if(select2<0 || select2>=[theSequence count])   return;
int t,pos1=select1,pos2=select2;

while(pos1<pos2)
	{
	[theSequence exchangeObjectAtIndex:pos1 withObjectAtIndex:pos2];
	pos1++;
	pos2--;
	}

[self showInformation];
[self putIntoPosition:currentIndex];
}

// ******************************************************************************************
-(void) deleteCurrentFrame
{
[theSequence removeObjectAtIndex:currentIndex];
if(currentIndex>=[theSequence count]) currentIndex=[theSequence count]-1;
[self showInformation];
[self putIntoPosition:currentIndex];
}
// ******************************************************************************************
-(void) updateCurrent
{
[self putPositionInto:currentPosition];
}
// ******************************************************************************************
-(void) nextFrame
{
currentIndex++;
if(currentIndex>=[theSequence count]) currentIndex=[theSequence count]-1;

[self showInformation];
[self putIntoPosition:currentIndex];
}
// ******************************************************************************************
-(void) previousFrame
{
currentIndex--;
if(currentIndex<0) currentIndex=0;
[self showInformation];
[self putIntoPosition:currentIndex];
}
// ******************************************************************************************
-(void) gotoSliderValue:(float)value
{
currentIndex=WXUNormalise(value,0,1,0,[theSequence count]-1);
[self showInformation];
[self putIntoPosition:currentIndex];
}
// ******************************************************************************************
-(void) doStart
{
direction=1;
doPlay=YES;
currentIndex=0;
isRendered=NO;
}
// ******************************************************************************************
-(void) goStartIfPlaying
{
if(doPlay)  [self doStart];
}
// ******************************************************************************************
-(void) doStop;
{
doPlay=NO;
[renderedSequence reset];
isRendered=NO;
}
// ******************************************************************************************
-(void) initForPlay
{
direction=1;
doPlay=!doPlay;
currentIndex=0;
if(!doPlay) [self putIntoPosition:[theSequence count]-1];
}
// ******************************************************************************************
-(void) gotoEnd
{
currentIndex=[theSequence count]-1;
[self putIntoPosition:currentIndex];
[currentGui setIntValue:currentIndex+1];
[sliderGui setFloatValue:WXUNormalise(currentIndex+1,1,[theSequence count],0,1.0)];
}
// ******************************************************************************************
-(void) gotoCurrent
{
[self putIntoPosition:currentIndex];
[currentGui setIntValue:currentIndex+1];
[sliderGui setFloatValue:WXUNormalise(currentIndex+1,1,[theSequence count],0,1.0)];
}
// ******************************************************************************************
-(void) showInformation
{
[totalGui setIntValue:[theSequence count]];
[currentGui setIntValue:currentIndex+1];
[sliderGui setFloatValue:WXUNormalise(currentIndex+1,1,[theSequence count],0,1.0)];
}
// ******************************************************************************************
-(void) putIntoCurrent
{
int t;
float   angle;
WXSCAnimBodyPartBasic   *part;

if(doPlay) 
	[self putIntoPosition:currentIndex];
else
	{
	[self putIntoPositionUsingPosition:currentPosition];
	}
}
// ******************************************************************************************
-(void) putIntoPositionUsingPosition:(NSMutableArray*)position
{
int t,image;
float   angle,px,py,sx,sy,xp,yp;
int		joinIndex,pivot;
BOOL	join,absolute;

WXSCAnimBodyPartBasic   *part;
NSMutableDictionary		*theDictionary;
for(t=0;t<[position count];t++)
	{
	part=[theBody elementAtIndex:t];
	theDictionary=[position objectAtIndex:t];
	
	[self getValuesForPart:theDictionary angle:&angle px:&px py:&py sx:&sx sy:&sy xp:&xp yp:&yp
								ji:&joinIndex im:&image join:&join abs:&absolute piv:&pivot];
	

	[part setRadianAngle:angle];
	[part setXPivot:px];
	[part setYPivot:py];
	[part setXShift:sx];
	[part setYShift:sy];
	[part setJoinPartTo:joinIndex];
	[part setJoinPointIndex:pivot];
	[part setIsJoined:join];
	[part setIsAbsoluteAngle:absolute];
	[part setXPos:xp]; 
	[part setYPos:yp];
	
	[part setImageType:image];
	}
}
// ******************************************************************************************
-(void) putIntoPosition:(int)index
{
if(index>=[theSequence count])  
	{
	doPlay=NO;
	return;
	}
	
[self putIntoPositionUsingPosition:[theSequence objectAtIndex:index]];
}
// ******************************************************************************************
-(void) playSequence
{
if(!doPlay) return;

[self putIntoPosition:currentIndex];
	
[currentGui setIntValue:currentIndex+1];
[sliderGui setFloatValue:WXUNormalise(currentIndex+1,1,[theSequence count],0,1.0)];

currentIndex+=direction;
if(currentIndex>=[theSequence count]) 
	{
	currentIndex=[theSequence count]-1;
	direction=-1;
	}
	
if(currentIndex<=0) 
	{
	direction=1;
	currentIndex=0;
	}
}
// ******************************************************************************************
// OTHER USEFULL BITS
// ******************************************************************************************
-(void) getValuesForPart:(NSMutableDictionary*)source
	angle:(float*)angle px:(float*)px py:(float*)py sx:(float*)sx sy:(float*)sy xp:(float*)xp yp:(float*)yp
	ji:(int*)ji im:(int*)im join:(BOOL*)join abs:(BOOL*)abs piv:(int*)piv
{
*angle=[[source objectForKey:@"angle"]floatValue];   
*px=[[source objectForKey:@"pivotx"]floatValue];	
*py=[[source objectForKey:@"pivoty"]floatValue];	
*sx=[[source objectForKey:@"shiftx"]floatValue];		
*sy=[[source objectForKey:@"shifty"]floatValue];	
*xp=[[source objectForKey:@"pointx"]floatValue];	
*yp=[[source objectForKey:@"pointy"]floatValue];	


*im=[[source objectForKey:@"image"]intValue];
*join=[[source objectForKey:@"join"]intValue];
*abs=[[source objectForKey:@"absolute"]intValue];
*ji=[[source objectForKey:@"joinIndex"]intValue];
*piv=[[source objectForKey:@"pivot"]intValue];
}	
// ******************************************************************************************
-(void) setValuesForPart:(NSMutableDictionary*)source
	angle:(float)angle px:(float)px py:(float)py sx:(float)sx sy:(float)sy xp:(float)xp yp:(float)yp
	ji:(int)ji im:(int)im join:(BOOL)join abs:(BOOL)abs piv:(int)piv
{
[source setObject:[NSNumber numberWithFloat:angle] forKey:@"angle"];
[source setObject:[NSNumber numberWithFloat:px] forKey:@"pivotx"];
[source setObject:[NSNumber numberWithFloat:py] forKey:@"pivoty"];
[source setObject:[NSNumber numberWithFloat:sx] forKey:@"shiftx"];
[source setObject:[NSNumber numberWithFloat:sy] forKey:@"shifty"];
[source setObject:[NSNumber numberWithFloat:xp] forKey:@"pointx"];
[source setObject:[NSNumber numberWithFloat:yp] forKey:@"pointy"];	
[source setObject:[NSNumber numberWithInt:im] forKey:@"image"];
[source setObject:[NSNumber numberWithBool:join] forKey:@"join"];
[source setObject:[NSNumber numberWithBool:abs] forKey:@"absolute"];
[source setObject:[NSNumber numberWithInt:ji] forKey:@"joinIndex"];
[source setObject:[NSNumber numberWithInt:piv] forKey:@"pivot"];
}
// ******************************************************************************************
// MOUSE DOWN
// ******************************************************************************************
- (void)doMouseDown:(NSPoint)loc
{
int diff=17;
int startIndex=currentIndex-diff,selected;
if(startIndex<0) startIndex=0;

selected=startIndex+(loc.x)/50;
if(selected>=0 && selected<[theSequence count])
	if(loc.y<64)
		{
		currentIndex=selected;
		[self gotoCurrent];
		}
	else
		{
		if(selectType==1)  
			{
			select1=select2=selected;
			selectType=2;
			}
		}
}
// ******************************************************************************************
- (void)doMouseDrag:(NSPoint)loc
{
int diff=17;
int startIndex=currentIndex-diff,selected;
if(startIndex<0) startIndex=0;

	

selected=startIndex+(loc.x)/50;
if(selectType==2 && selected>=0 && selected<[theSequence count]) 
	{
	select2=selected;
	WXUSwapIntegersToOrder(&select1,&select2);
	}
}
// ******************************************************************************************
- (void)doMouseUp:(NSPoint)loc
{
selectType=1;
}
// ******************************************************************************************
// LOAD SAVE
// ******************************************************************************************
-(void)		writeDataUsing:(WXUsefullFileReadWrite*)reader
{
float   angle,px,py,sx,sy,xp,yp;
int		joinIndex,pivot;
BOOL	join,absolute;

int size=[theSequence count],t,p,numberParts,image;
NSMutableArray		*position;
NSMutableDictionary *theDictionary;

[reader writeInteger:size];
for(p=0;p<size;p++)
	{
	//printf("write %d\n",p);
	position=[theSequence objectAtIndex:p];
	numberParts=[position count];
	[reader writeInteger:numberParts];
	
	for(t=0;t<numberParts;t++)
		{
		theDictionary=[position objectAtIndex:t];
		
		[self getValuesForPart:theDictionary angle:&angle px:&px py:&py sx:&sx sy:&sy xp:&xp yp:&yp
								ji:&joinIndex im:&image join:&join abs:&absolute piv:&pivot];		
		
		
		[reader writeFloat:angle];
		[reader writeFloat:px];
		[reader writeFloat:py];
		[reader writeFloat:sx];
		[reader writeFloat:sy];
		[reader writeFloat:xp];
		[reader writeFloat:yp];
		[reader writeInteger:image];
		[reader writeBool:join];
		[reader writeBool:absolute];
		[reader writeInteger:joinIndex];
		[reader writeInteger:pivot];
		}
	}
}
// ******************************************************************************************
-(void)		loadDataUsing:(WXUsefullFileReadWrite*)reader
{
float   angle,px,py,sx,sy,xp,yp;
int		joinIndex,pivot;
BOOL	join,absolute;

int size,t,p,numberParts,image;
NSMutableArray  *position;
NSMutableDictionary  *newDictionary;

[theSequence removeAllObjects];
[reader readInteger:&size];
for(p=0;p<size;p++)
	{
	//printf("read %d\n",p);
	position=[[NSMutableArray alloc]init];
	[reader readInteger:&numberParts];
	for(t=0;t<numberParts;t++)
		{
		[reader readFloat:&angle];
		[reader readFloat:&px];
		[reader readFloat:&py];
		[reader readFloat:&sx];
		[reader readFloat:&sy];
		[reader readFloat:&xp];
		[reader readFloat:&yp];
		
		[reader readInteger:&image];
		[reader readBool:&join];
		[reader readBool:&absolute];
		[reader readInteger:&joinIndex];
		[reader readInteger:&pivot];
	
		newDictionary=[[NSMutableDictionary alloc]init];
		
		[self setValuesForPart:newDictionary angle:angle px:px py:py sx:sx sy:sy xp:xp yp:yp
								ji:joinIndex im:image join:join abs:absolute piv:pivot];	
		
		[position addObject:newDictionary];
		[newDictionary release];
		
		}
	[theSequence addObject:position];
	[position release];
	}
}
// ******************************************************************************************


@end
