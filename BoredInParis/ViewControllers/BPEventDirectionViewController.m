//
//  BPEventDirectionViewController.m
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import "BPEventDirectionViewController.h"
#import <MapKit/MapKit.h>

@interface BPEventDirectionViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *eventDirectionMap;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *directionSteps;


@end

@implementation BPEventDirectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    self.eventDirectionMap.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations lastObject];
    [manager stopUpdatingLocation];
    
    self.eventDirectionMap.showsUserLocation = YES;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 5000, 5000);
    [self.eventDirectionMap setRegion:[self.eventDirectionMap regionThatFits:region] animated:YES];
    
    
    float latitude = self.event.latitude.floatValue;
    float longitude = self.event.longitude.floatValue;
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    [self getDirection:destinationMapItem];
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Direction Helper

-(void)getDirection:(MKMapItem *)destination {
    
    //Function to get destination direction
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = destination;
    request.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"ERROR ::: %@", error);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showRoute:response];
        }
    }];
    
}

#pragma mark - Route Helper

-(void)showRoute:(MKDirectionsResponse *)response{
    
    for (MKRoute *route in response.routes) {
        //We add the overlay to our map
        [self.eventDirectionMap addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
    }
    
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    //We render the Overlay
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor greenColor];
    renderer.lineWidth = 2.0;
    
    return renderer;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
