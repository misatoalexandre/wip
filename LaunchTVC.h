//
//  LaunchTVC.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/24/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetsTVC.h"
#import "SelectWorkoutTVCViewController.h"

@interface LaunchTVC : UITableViewController<SetsTVCDelegate,WorkoutTVCDelegate>
//sets selection 
@property (nonatomic, strong)NSString *selectedSets;
@property(nonatomic, assign)int selectedCell;

// data to pass to begin workout
@property (nonatomic, strong)NSString *workoutPlantoBeginId;

@property (weak, nonatomic) IBOutlet UILabel *selectedSetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedWorkoutLabel;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
