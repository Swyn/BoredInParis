//
//  BPEventDetailMapTableViewCell.h
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BPEventDetailMapTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MKMapView *map;

@end
