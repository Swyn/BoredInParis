//
//  BPEventDetailsViewController.m
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import "BPEventDetailsViewController.h"

#import "BPEvents.h"

#import "BPDetailAdressTableViewCell.h"
#import "BPDetailContentTableViewCell.h"
#import "BPDetailDateTableViewCell.h"
#import "BPDetailImageTableViewCell.h"
#import "BPEventDetailMapTableViewCell.h"
#import "BPDetailDirectionTableViewCell.h"

#import "BPEventDirectionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BPEventDetailsViewController () <UITableViewDelegate, UITableViewDataSource, BPDetailDirectionTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BPEventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //We use an NSEnum in order to know how many rows we need (if we need to add or remove some we can do it very easily :))
    return BPEventDetailsCellCount;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *imageIdentifier        = @"ImageCell";
    static NSString *dateIdentifier         = @"dateCell";
    static NSString *contentIdentifier      = @"contentCell";
    static NSString *adressIdentifier       = @"adressCell";
    static NSString *mapIdentifier          = @"mapCell";
    static NSString *directionIdentifier    = @"directionCell";
    
    // We use the Enum to know which row we need to display
    if (indexPath.row == BPEventDetailsCellImage) {
        BPDetailImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageIdentifier];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBPaseFileURL, self.event.picture]];
        [cell.detailPicture sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"image.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"Image OK");
        }];
        return cell;
    }else if (indexPath.row == BPEventDetailsCellContent){
        
        BPDetailContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentIdentifier];
        cell.detailTitle.text = self.event.name;
        cell.detailContent.text = self.event.eventDescription;
        return cell;
        
    }else if (indexPath.row == BPEventDetailsCellDate){
        BPDetailDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dateIdentifier];
        cell.detailDay.text = self.event.eventday;
        cell.detailTime.text = [NSString stringWithFormat:@"%@ - %@", self.event.eventStart, self.event.eventEnd];
        return cell;
        
    }else if (indexPath.row == BPEventDetailsCellAdress){
        BPDetailAdressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adressIdentifier];
        cell.detailCity.text = self.event.city;
        cell.detailStreet.text = self.event.adress;
        cell.detailZipCode.text = [NSString stringWithFormat:@"%@", self.event.zipCode];
        return cell;
        
    }else if (indexPath.row == BPEventDetailsCellMap) {
        BPEventDetailMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mapIdentifier];
        
        //Very little use of the mapkit in order to show a point
        //The data format is so bad I prefered not to add descriptions on the point...
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.event.latitude.floatValue, self.event.longitude.floatValue);
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
        
        [cell.map setRegion:[cell.map regionThatFits:region] animated:YES];
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinate;
        [cell.map addAnnotation:point];
        
        return cell;
        
    }else {
        BPDetailDirectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:directionIdentifier];
        [cell setDelegate:self];
        return cell;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Return the good row height for every rows
    //Again use of the Enum
    if (indexPath.row == BPEventDetailsCellImage) {
        return 120;
    }else if (indexPath.row == BPEventDetailsCellContent){
        return 150;
    }else if (indexPath.row == BPEventDetailsCellDate){
        return 35;
    }else if (indexPath.row == BPEventDetailsCellAdress){
        return 75;
    }else if (indexPath.row == BPEventDetailsCellMap)
        return 150;
    else
        return 50;
    
}

-(void)cell:(BPDetailDirectionTableViewCell *)cell didTouchedDirectionButton:(UIButton *)sender{
    //We get back the call from delegate to trigger Segue
    [self performSegueWithIdentifier:@"ToDirectionSegue" sender:self];
    
    
#pragma mark - Segue
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"ToDirectionSegue"]) {
        BPEventDirectionViewController *vc = [segue destinationViewController];
        //Here I pass the all object for further improvement ?
        vc.event = self.event;
    }
    
}




@end
