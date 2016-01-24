//
//  BPDetailDirectionTableViewCell.m
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import "BPDetailDirectionTableViewCell.h"

@implementation BPDetailDirectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)directionButtonTouched:(UIButton *)sender {
    
    //button delegate
    [self.delegate cell:self didTouchedDirectionButton:sender];
    
}

@end
