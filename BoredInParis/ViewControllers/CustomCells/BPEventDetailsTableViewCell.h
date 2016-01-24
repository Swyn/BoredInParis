//
//  BPEventDetailsTableViewCell.h
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPEventDetailsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellPicture;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellDetails;
@property (weak, nonatomic) IBOutlet UILabel *cellDistance;


@end
