//
//  BPEvents.h
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 23/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BPEventDetailsCells){
    
    BPEventDetailsCellImage,
    BPEventDetailsCellContent,
    BPEventDetailsCellAdress,
    BPEventDetailsCellDate,
    BPEventDetailsCellMap,
    BPEventDetailsCellDestination,
    BPEventDetailsCellCount
};

@interface BPEvents : NSObject

@property (strong, nonatomic) NSString *accessType;
@property (strong, nonatomic) NSString *adress;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *discipline;
@property (strong, nonatomic) NSString *picture;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *lieu;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *eventDescription;
@property (strong, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSString *eventday;
@property (strong, nonatomic) NSString *eventStart;
@property (strong, nonatomic) NSString *eventEnd;

@property (nonatomic) BOOL hasFee;

-(id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
