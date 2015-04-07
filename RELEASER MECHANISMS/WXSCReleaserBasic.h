// ******************************************************************************************
//  WXSCReleaserBasic
//  Created by Paul Webb on Tue May 17 2005.
// ******************************************************************************************
//  Releasing Mechanisms identify significant objects or events from sensory input and output a value which represents the
//  strength of the stimulus. By varying the allowed maximum for a given Releasing Mechanism, a Behavior can be made more
//  or less sensitive to the presence of the relevant stimuli. A Releasing Mechanism has 4 phases (Find, Filter, Weight and Temporal
//  Filtering), as indicated above. Temporal Filtering is provided to deal with potentially noisy data.
//
// A RELEASER CAN DEPEND ON MULTIPLE OBJECTS OF INTEREST...???
//
//  FOUR PHASES
//  1.  find	- attempts to detect the RM’s object(s) of interest OOI (from posted perceptions)
//  2.  filter  - which filters the   attributes of the object(s) of interest for more specific criteria
//  3.  weight  - some function (eg proportional to loudness / to distance of objects(s))
//  4.  temporal filter - eg summing, averaging over time, latch (within time)
//
//  also 
//  5. Pronome [Minsky86]. Can become the object of interest.
//  specific RM can ignore it or use it as its OOI
//
//  An upper-level Behavior can set the Pronome (e.g. “the red apple”) that lower-level Behaviors then operate on.
//  Specifically, the Releasing Mechanism associated with the winning Behavior at any level makes its associated
//  Pronome be the current object of interest. The Releasing Mechanisms beneath it
//  in the hierarchy are free to use it as their object of interest as well, or ignore it.
//
// ******************************************************************************************
// for the filter this means that the perception objects need to be hierarchicle
//
//
//
//
// ******************************************************************************************

#import <Foundation/Foundation.h>


@interface WXSCReleaserBasic : NSObject {

}

@end
