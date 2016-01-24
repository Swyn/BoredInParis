//
//  BPCidManager.h
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BPCidEnum){
    
    BPCidExpo,
    BPCidScpectacle,
    BPCidActivity,
    BPCidEvent,
    BPCidPhoto,
    BPCidPaint,
    BPCidConcert,
    BPCidTheatre,
    BPCidCourse,
    BPCidCount
};

@interface BPCidManager : NSObject

+(NSString *)idForCid:(BPCidEnum)cidID;

@end
