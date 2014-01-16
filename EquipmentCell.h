//
//  EquipmentCell.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 1/16/14.
//  Copyright (c) 2014 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EquipmentCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *equipmentNameLabel;

@end
