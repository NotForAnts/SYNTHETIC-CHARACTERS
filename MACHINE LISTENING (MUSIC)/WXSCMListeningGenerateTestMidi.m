// ******************************************************************************************
//  WXSCMListeningGenerateTestMidi
//  Created by Paul Webb on Tue Jun 13 2006.
// ******************************************************************************************

#import "WXSCMListeningGenerateTestMidi.h"


@implementation WXSCMListeningGenerateTestMidi
// ******************************************************************************************



// ******************************************************************************************
-(void)		setMidiRouter:(id)root
{
midiRouter=root;
}
// ******************************************************************************************
-(void)		doReset
{
cpitch=60;
volume=110;
cduration=100;
counter=0;
mod1=150;
mod2=600;

p1=WXURandomInteger(30,40);
p2=WXURandomInteger(33,44);
p3=WXURandomInteger(30,40);
p4=WXURandomInteger(20,40);
}
// ******************************************************************************************
-(void)		doGenerate
{
[midiRouter doNoteOffQueue];


if(counter % 60==0)	
	{
	[midiRouter midiCC:2 type:kControl_PAN value:WXURandomInteger(20,80)];
	[midiRouter midiCC:2 type:kControl_HARMONIC_CONTENT value:WXURandomInteger(20,80)];
	}


if(counter % (hatMod*4)==0)				[midiRouter midiNote:9 pitch:kRideCymbolCup volume:127 duration:100];
if(counter % hatMod==0)					[midiRouter midiNote:9 pitch:kRideCymbol1 volume:127 duration:100];
if((counter+300) % 300==0)				[midiRouter midiNote:9 pitch:kKick volume:120 duration:100];
if((counter+300) % 600==0)				[midiRouter midiNote:9 pitch:kOpenRimShot volume:120 duration:100];

if(counter % mod1==0)			
	{
	[midiRouter midiNote:2 pitch:cpitch volume:volume duration:cduration];
	if(WXURandomInteger(0,100)<4) [midiRouter midiNote:2 pitch:cpitch+3 volume:volume duration:cduration];
	if(WXURandomInteger(0,100)<4) [midiRouter midiNote:2 pitch:cpitch+5 volume:volume duration:cduration];
	
	if(WXURandomInteger(0,100)<8) mod1=150;
	if(WXURandomInteger(0,100)<8) mod1=300;
	if(WXURandomInteger(0,100)<8) mod1=75;
	if(WXURandomInteger(0,100)<4) mod1=6000;
	
	
	if(WXURandomInteger(0,1000)<500)		cpitch=WXURandomInteger(30,80);
	}

if(counter % mod2==0)	
	{
	if(WXURandomInteger(0,1000)<40)		cpitch=WXURandomInteger(20,50);
	if(WXURandomInteger(0,1000)<40)		volume=WXURandomInteger(30,120);
	if(WXURandomInteger(0,1000)<30) 	cduration=WXURandomInteger(5,700);
	if(WXURandomInteger(0,1000)<30)		mod1=WXURandomInteger(20,700);
	
	if(WXURandomInteger(0,100)<8) mod2=300;
	if(WXURandomInteger(0,100)<8) mod2=600;
	if(WXURandomInteger(0,100)<8) mod2=1200;
	if(WXURandomInteger(0,100)<4) mod2=1500;
	
	if(WXURandomInteger(0,500)<8) hatMod=300;
	if(WXURandomInteger(0,500)<8) hatMod=600;
	if(WXURandomInteger(0,500)<8) hatMod=1200;
	if(WXURandomInteger(0,500)<4) hatMod=1500;		
	}


if(counter % mod2==0)			
	{
	// PLAY CHORD
	[midiRouter midiNote:0 pitch:p1 volume:126 duration:WXURandomInteger(25,8500)];
	[midiRouter midiNote:0 pitch:p2 volume:126 duration:WXURandomInteger(25,8500)];
	[midiRouter midiNote:0 pitch:p3 volume:126 duration:WXURandomInteger(25,8500)];
	[midiRouter midiNote:0 pitch:p4 volume:126 duration:WXURandomInteger(25,8500)];
	
	
	if(WXURandomInteger(0,1000)<80)		p1=WXURandomInteger(30,40);
	if(WXURandomInteger(0,1000)<80)		p2=WXURandomInteger(33,44);
	if(WXURandomInteger(0,1000)<80)		p3=WXURandomInteger(30,40);
	if(WXURandomInteger(0,1000)<80)		p4=WXURandomInteger(20,40);
	}


counter++;
}
// ******************************************************************************************

@end
