//
//  BPEventDetailsTableViewCell.m
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import "BPEventDetailsTableViewCell.h"

@implementation BPEventDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.cellPicture.frame = CGRectMake(8,8,83,83);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
