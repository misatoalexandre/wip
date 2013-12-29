//
//  WorkoutSelectionTVC.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/20/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Workout.h"
@protocol WorkoutSelectionDelegate;

@interface WorkoutSelectionTVC : PFQueryTableViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *workoutList;
@property (nonatomic, strong)Workout *currentWorkout;
@property (weak, nonatomic) id<WorkoutSelectionDelegate>delegate;

//Abs Workout Plans
@property (nonatomic, strong)NSArray *absFree;

//Butts Workout Plans
@property (nonatomic, strong)NSArray *buttsFree;

-(void)onSegmentedControlChanged;
@end
@protocol WorkoutSelectionDelegate
-(void)workoutWasSelectedOnWorkoutSelectionTVC:(WorkoutSelectionTVC *)controller;

@end
