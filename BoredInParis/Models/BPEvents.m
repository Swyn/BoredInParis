//
//  BPEvents.m
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 23/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import "BPEvents.h"
#import <GTMNSStringHTMLAdditions/GTMNSString+HTML.h>

@implementation BPEvents

-(id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    
    //Init of my Event object
    
    if(self = [self init]){
        
        self.accessType         = [jsonDictionary objectForKey:@"accessType"];
        self.adress             = [jsonDictionary objectForKey:@"adresse"];
        self.city               = [jsonDictionary objectForKey:@"city"];
        self.discipline         = [jsonDictionary objectForKey:@"discipline"];
        self.latitude           = [jsonDictionary objectForKey:@"lat"];
        self.longitude          = [jsonDictionary objectForKey:@"lon"];
        self.lieu               = [jsonDictionary objectForKey:@"lieu"];
        self.name               = [jsonDictionary objectForKey:@"nom"];
        self.zipCode            = [jsonDictionary objectForKey:@"zipcode"];
        
        //I got weird time results making the app crash from time to time
        //I just take the first one for now
        //The idea could have been to create an array of event dates
        //We use a method to reformat the date in a good way
        NSArray *timeArray      = [[jsonDictionary objectForKey:@"occurrences"] firstObject];
        self.eventday           = [self formatedDateFromString:[(NSDictionary *) timeArray objectForKey:@"jour"]];
        self.eventStart         = [(NSDictionary *) timeArray objectForKey:@"hour_start"];
        self.eventEnd           = [(NSDictionary *) timeArray objectForKey:@"hour_end"];
        
        //I tried several ways to format the description...
        //Even web browser can't format it well it's aint plain HTML...
        self.eventDescription   = [[jsonDictionary objectForKey:@"small_description"] gtm_stringByEscapingForHTML];
        
        //The picture Url is nested in a dictionary nested in an array.
        for (NSArray *array in [jsonDictionary objectForKey:@"files"]) {
            self.picture = [(NSDictionary *) array objectForKey:@"file"];
        }
        
        
        
    }
    
    return self;
    
}


-(NSString *)formatedDateFromString:(NSString *)date{
    
    /*
     We first format our string in an NSDate
     The we reformat it in a nice string
    */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *formatedDate = [dateFormatter dateFromString:date];
    
    NSDateFormatter *secondDateFormatter = [[NSDateFormatter alloc] init];
    [secondDateFormatter setDateFormat:@"E d MMM"];

    NSString *finalString = [secondDateFormatter stringFromDate:formatedDate];
    
    return finalString;
    
    
}

@end
