//
//  BPCidManager.m
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import "BPCidManager.h"



@implementation BPCidManager

+(NSString *)idForCid:(BPCidEnum)cidID{
    
    //This method return ID's for the cid paramater
    //I've tested 22 diferents values, the API can't give me a list... (call fail).
    //Here are some of them.
    
    switch (cidID) {
        case BPCidExpo:
            return @"1";
            break;
        case BPCidScpectacle:
            return @"2";
            break;
        case BPCidActivity:
            return @"3";
            break;
        case BPCidEvent:
            return @"4";
            break;
        case BPCidPhoto:
            return @"6";
            break;
        case BPCidPaint:
            return @"8";
            break;
        case BPCidConcert:
            return @"13";
            break;
        case BPCidTheatre:
            return @"14";
            break;
        case BPCidCourse:
            return @"20";
            break;
        case BPCidCount:
            return @"";
        default:
            break;
    }
    
}



@end
