//
//  BPConstants.h
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 23/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPConstants : NSObject


//Constants declaration
//We could hve use #define but I prefer to set the type I want.

extern NSString *const kBPBaseURL;
extern NSString *const kBPaseFileURL;
extern NSString *const kBPAuthToken;

extern NSString *const kBPcid;
extern NSString *const kBPtag;
extern NSString *const kBPoffset;
extern NSString *const kBPlimit;

extern NSString *const kBPcreated;

extern NSString *const kBPdistanceMaxKey;
extern NSString *const kBPexpoEnabled;
extern NSString *const kBPspectacleEnabled;
extern NSString *const kBPactivityEnabled;
extern NSString *const kBPeventEnabled;
extern NSString *const kBPphotoEnabled;
extern NSString *const kBPpaintEnabled;
extern NSString *const kBPconcertEnabled;
extern NSString *const kBPtheatreEnabled;
extern NSString *const kBPcoursesEnabled;




@end
