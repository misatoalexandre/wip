//
//  WorkoutStepVC.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/16/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseCell.h"
#import <QuartzCore/QuartzCore.h>


@interface WorkoutStepVC : UIViewController
@property (strong, nonatomic) NSArray *exerciseArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
