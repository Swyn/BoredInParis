//
//  BPDetailAdressTableViewCell.h
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPDetailAdressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *detailStreet;
@property (weak, nonatomic) IBOutlet UILabel *detailZipCode;
@property (weak, nonatomic) IBOutlet UILabel *detailCity;

@end
