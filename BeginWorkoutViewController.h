//
//  BeginWorkoutViewController.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/24/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import <Parse/Parse.h>
@interface BeginWorkoutViewController : UIViewController

@property (nonatomic, strong) NSString *workoutId;
@property (nonatomic, strong) PFObject *currentWorkout;
@property int setCount;

//Interface views
@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *firstEpmtImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondEmptImageView;
@property (weak, nonatomic) IBOutlet UILabel *equipmentLabel;


- (IBAction)beginWorkout:(id)sender;
@end
