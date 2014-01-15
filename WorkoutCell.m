//
//  WorkoutCell.m
//  FitwirrApp
//
//  Created by Harry on 1/14/14.
//  Copyright (c) 2014 Misato Tina Alexandre. All rights reserved.
//

#import "WorkoutCell.h"

@implementation WorkoutCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    if([_priceLabel.text isEqualToString:@""])
//    {
//        NSLog(@"SetFrame");
//        _mainLabel.frame = CGRectMake(_mainLabel.frame.origin.x, _mainLabel.frame.origin.y, 270, CGRectGetHeight(_mainLabel.frame));
//        _detailLabel.frame = CGRectMake(_detailLabel.frame.origin.x, _detailLabel.frame.origin.y, 270, CGRectGetHeight(_detailLabel.frame));
//    }
}

@end
