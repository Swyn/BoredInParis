//
//  BPEventsViewController.m
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 23/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import "BPEventsViewController.h"

#import "BPEventDetailsTableViewCell.h"
#import "BPEventSectionTableViewCell.h"

#import "BPEventDetailsViewController.h"

#import "BPCidManager.h"
#import "BPEvents.h"

#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MapKit/MapKit.h>

@interface BPEventsViewController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *eventArray;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UIRefreshControl *refreshController;

@property (nonatomic) CLLocationCoordinate2D userCoordinate;
@property (strong, nonatomic) BPEvents *selectedEvent;

@end

@implementation BPEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
  
    //Laction Manager Initialization
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined|| ![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10.0;
    
    [self.locationManager startUpdatingLocation];
    
    // Init refresher and get Datas
    [self initRefreshController];
    [self getDatas];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //We return the number of events
    return [self.eventArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    BPEventDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    BPEvents *event = [self.eventArray objectAtIndex:indexPath.row];
    
    cell.cellTitle.text = event.name;
    cell.cellDetails.text = event.eventDescription;
    
    //Web Image Setup
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBPaseFileURL, event.picture]];
    [cell.cellPicture sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"image.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"Image OK");
        }];
    
    //Display of the distance between User and Event
    CLLocationCoordinate2D eventCoord = CLLocationCoordinate2DMake(event.latitude.floatValue, event.longitude.floatValue);
    double distance = [self kilometersfromPlace:self.userCoordinate andToPlace:eventCoord];
    cell.cellDistance.text = [NSString stringWithFormat:@"Distance : %.2f Km", distance];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Get back the event selected and perfom segue
    self.selectedEvent = [self.eventArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ToDetailsSegue" sender:self];
    
    
}

#pragma mark - API Call

-(void)getDatas {
    
    self.eventArray = [[NSMutableArray alloc] init];
    
    
    /*
      Api ask for two timestamps to filter events by dates.
      It send back weird results sometime...
      Here I generate timstamps of now and next month
    */
    NSString *start = [NSString stringWithFormat:@"%d", @([[NSDate date] timeIntervalSince1970]).intValue];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextMonth = [calendar dateByAddingUnit:NSCalendarUnitDay value:30 toDate:date options:NSCalendarMatchLast];
    NSString *end = [NSString stringWithFormat:@"%d", @([nextMonth timeIntervalSince1970]).intValue];
    
    //Get back my param for Cid (envent Types)
    NSString *cidString = [self cidManager];
    
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:cidString, @"cid",
                                                                            kBPtag, @"tag",
                                                                            kBPcreated, @"created",
                                                                            start, @"start",
                                                                            end, @"end",
                                                                            kBPoffset, @"offset",
                                                                            kBPlimit, @"limit",
                                                                            kBPAuthToken , @"token",
                                                                            nil];
    
    NSString *string = kBPBaseURL;
    NSURL *url = [NSURL URLWithString:string];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    [manager GET:@"get_activities" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictionary = [(NSDictionary *) responseObject objectForKey:@"data"];
        
        for (NSDictionary *dict in dictionary) {
            /*
             We only want events closer than the limit selected by our User
             The method isInRange return a boolean
             If YES then we init our event object, else we check the next one.
            */
            if ([self isInrangeWithLong:[[dict objectForKey:@"lon"] floatValue] andLat:[[dict objectForKey:@"lat"] floatValue]]) {
                BPEvents *event = [[BPEvents alloc] initWithJSONDictionary:dict];
                [self.eventArray addObject:event];
            }
            
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"NOPE !");
    }];
    
   
    
}

#pragma mark - CLLocationManager

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //Fuction to update our user's location
    CLLocation *location = [locations lastObject];
    self.userCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    [self.locationManager stopUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    //Function to update location after authorization granting.
    [self.locationManager startUpdatingLocation];
}



#pragma mark - Refresher Helper

-(void)initRefreshController{
    
    //Refresher initialisation
    self.refreshController = [[UIRefreshControl alloc] init];
    self.refreshController.backgroundColor = [UIColor colorWithRed:92 green:164 blue:169 alpha:1];
    self.refreshController.tintColor = [UIColor blueColor];
    
    [self.tableView addSubview:self.refreshController];
    
    [self.refreshController addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
}

-(void)refreshTable{
    
    [self getDatas];
    [self.refreshController endRefreshing];
    
}

#pragma mark - Helper

-(double)kilometersfromPlace:(CLLocationCoordinate2D)from andToPlace:(CLLocationCoordinate2D)to  {
    
    //init user's and event locations
    CLLocation *userloc = [[CLLocation alloc]initWithLatitude:from.latitude longitude:from.longitude];
    CLLocation *dest = [[CLLocation alloc]initWithLatitude:to.latitude longitude:to.longitude];
    
    //we divide the result by 1000 to get kilometers
    CLLocationDistance dist = [userloc distanceFromLocation:dest]/1000;
    
    NSString *distance = [NSString stringWithFormat:@"%f",dist];
    
    return [distance doubleValue];
    
}

-(BOOL)isInrangeWithLong:(float)longitude andLat:(float)latitude{
    
    //We get back info from json response send it here to check if the distance is OK.
    CLLocationCoordinate2D eventCoord = CLLocationCoordinate2DMake(latitude, longitude);
    
    double distance = [self kilometersfromPlace:self.userCoordinate andToPlace:eventCoord];
    
    if (distance > [[NSUserDefaults standardUserDefaults] doubleForKey:kBPdistanceMaxKey]) return NO;
    else return YES;
    
    
}

#pragma mark - Cid Helper

-(NSString *)cidManager{
    
    //This should be somewhere else. Did it very fast.
    //We check if our user selected different values in the options then the BPCidManager class return id values for ech topic.
    //We finaly join the array in one final string and send it back to our api call parameter.
    
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    NSString *cidString;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBPexpoEnabled]) {
        cidString = [NSString stringWithString:[BPCidManager idForCid:BPCidExpo]];
        [stringArray addObject:cidString];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBPspectacleEnabled]){
        cidString = [NSString stringWithString:[BPCidManager idForCid:BPCidScpectacle]];
        [stringArray addObject:cidString];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBPactivityEnabled]){
        cidString = [NSString stringWithString:[BPCidManager idForCid:BPCidActivity]];
        [stringArray addObject:cidString];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBPeventEnabled]){
        cidString = [NSString stringWithString:[BPCidManager idForCid:BPCidEvent]];
        [stringArray addObject:cidString];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBPphotoEnabled]){
        cidString = [NSString stringWithString:[BPCidManager idForCid:BPCidPhoto]];
        [stringArray addObject:cidString];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBPpaintEnabled]){
        cidString = [NSString stringWithString:[BPCidManager idForCid:BPCidPaint]];
        [stringArray addObject:cidString];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBPconcertEnabled]){
        cidString = [NSString stringWithString:[BPCidManager idForCid:BPCidConcert]];
        [stringArray addObject:cidString];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBPtheatreEnabled]){
        cidString = [NSString stringWithString:[BPCidManager idForCid:BPCidTheatre]];
        [stringArray addObject:cidString];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBPcoursesEnabled]){
        cidString = [NSString stringWithString:[BPCidManager idForCid:BPCidCourse]];
        [stringArray addObject:cidString];
    }
    
    
    NSString *finalString = [stringArray componentsJoinedByString:@","];
    return finalString;
    
}


#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"ToDetailsSegue"]) {
        //Init of nextVC and pass selected event
        BPEventDetailsViewController *vc = [segue destinationViewController];
        vc.event = self.selectedEvent;
    }
    
}

@end
