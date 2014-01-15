//
//  WorkoutCell.h
//  FitwirrApp
//
//  Created by Harry on 1/14/14.
//  Copyright (c) 2014 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
