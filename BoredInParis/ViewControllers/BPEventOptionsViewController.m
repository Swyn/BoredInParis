//
//  BPEventOptionsViewController.m
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import "BPEventOptionsViewController.h"

@interface BPEventOptionsViewController ()

@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UISwitch *expoSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *spectacleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *activitySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *eventSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *photoSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *paintSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *concertSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *theatreSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *courseSwitch;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation BPEventOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     So this isn't very pretty
     A pretty table view could have done the job
     Here I use an event controller in order to update my constants
    */
    self.distanceSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:kBPdistanceMaxKey];
    self.expoSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kBPexpoEnabled];
    self.spectacleSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kBPspectacleEnabled];
    self.activitySwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kBPactivityEnabled];
    self.eventSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kBPeventEnabled];
    self.photoSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kBPphotoEnabled];
    self.paintSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kBPpaintEnabled];
    self.concertSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kBPconcertEnabled];
    self.theatreSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kBPtheatreEnabled];
    self.courseSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kBPcoursesEnabled];
    
    [self.distanceSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.expoSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.spectacleSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.activitySwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.eventSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.photoSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.paintSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.theatreSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.courseSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.concertSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%i Km", (int)self.distanceSlider.value];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Helper

-(void)valueChanged:(id)sender{
    
    //Constants updates
    
    if (sender == self.distanceSlider) {
        [[NSUserDefaults standardUserDefaults] setInteger:(int)self.distanceSlider.value forKey:kBPdistanceMaxKey];
        self.distanceLabel.text = [NSString stringWithFormat:@"%i Km", (int)self.distanceSlider.value];
    }else if (sender == self.expoSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.expoSwitch.isOn forKey:kBPexpoEnabled];
    }else if (sender == self.spectacleSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.spectacleSwitch.isOn forKey:kBPspectacleEnabled];
    }
    else if (sender == self.activitySwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.activitySwitch.isOn forKey:kBPactivityEnabled];
    }else if (sender == self.eventSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.eventSwitch.isOn forKey:kBPeventEnabled];
    }else if (sender == self.photoSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.photoSwitch.isOn forKey:kBPphotoEnabled];
    }else if (sender == self.paintSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.paintSwitch.isOn forKey:kBPpaintEnabled];
    }else if (sender == self.concertSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.concertSwitch.isOn forKey:kBPconcertEnabled];
    }else if (sender == self.theatreSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.theatreSwitch.isOn forKey:kBPtheatreEnabled];
    }else if (sender == self.courseSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.courseSwitch.isOn forKey:kBPcoursesEnabled];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
