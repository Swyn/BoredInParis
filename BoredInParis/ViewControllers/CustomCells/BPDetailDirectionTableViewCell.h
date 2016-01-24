//
//  BPDetailDirectionTableViewCell.h
//  BoredInParis
//
//  Created by Alexandre ARRIGHI on 24/01/2016.
//  Copyright © 2016 Alexandre ARRIGHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPDetailDirectionTableViewCell;

//Exemple of delegate use
//The button is in a table view cell we need to know when the user touches it

@protocol BPDetailDirectionTableViewCellDelegate

-(void)cell:(BPDetailDirectionTableViewCell *)cell didTouchedDirectionButton:(UIButton *)sender;

@end

@interface BPDetailDirectionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *directionButton;

@property (weak) id <BPDetailDirectionTableViewCellDelegate> delegate;

@end
