//
//  BPConstants.m
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 23/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import "BPConstants.h"

@implementation BPConstants



NSString *const kBPBaseURL      = @"https://api.paris.fr/api/data/1.4/quefaire/";
NSString *const kBPaseFileURL   = @"https://filer.paris.fr/";
NSString *const kBPAuthToken    = @"456e2e28b0d9c7e6b81b2cc3a75357584a80e06323106d1200748369a2187485";

//The tag is a value similar to the Cid
//1 - Children 2 - Family 4 - Outdoor 6 - Expo etc...
//I hardcoded them, the user can already select a categorie.

NSString *const kBPtag          = @"1,2,4,5,6,7,44,48";
NSString *const kBPcreated      = @"0";
NSString *const kBPoffset       = @"0";
NSString *const kBPlimit        = @"10";

NSString *const kBPdistanceMaxKey = @"distance";

//keys for my plist file (NSUserDefault defaults values)
NSString *const kBPexpoEnabled          = @"expo";
NSString *const kBPspectacleEnabled     = @"spectacle";
NSString *const kBPactivityEnabled      = @"activity";
NSString *const kBPeventEnabled         = @"event";
NSString *const kBPphotoEnabled         = @"photo";
NSString *const kBPpaintEnabled         = @"paint";
NSString *const kBPconcertEnabled       = @"concert";
NSString *const kBPtheatreEnabled       = @"theatre";
NSString *const kBPcoursesEnabled       = @"course";


@end

