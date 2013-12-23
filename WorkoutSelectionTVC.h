//
//  WorkoutSelectionTVC.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/20/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface WorkoutSelectionTVC : PFQueryTableViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *workoutList;

//Abs Workout Plans
/*@property (nonatomic, strong)NSArray *absLevel1Home;
@property (nonatomic, strong)NSArray *absLevel1Gym;
@property (nonatomic, strong)NSArray *absLevel2Home;
@property (nonatomic, strong)NSArray *absLevel2Gym;
@property (nonatomic, strong)NSArray *absLevel3Home;
@property (nonatomic, strong)NSArray *absLevel3Gym;*/
@property (nonatomic, strong)NSArray *absFree;

//Butts Workout Plans
/*@property (nonatomic, strong)NSArray *buttsLevel1Home;
@property (nonatomic, strong)NSArray *buttsLevel1Gym;
@property (nonatomic, strong)NSArray *buttsLevel2Home;
@property (nonatomic, strong)NSArray *buttsLevel2Gym;
@property (nonatomic, strong)NSArray *buttsLevel3Home;
@property (nonatomic, strong)NSArray *buttsLevel3Gym;*/
@property (nonatomic, strong)NSArray *buttsFree;

-(void)onSegmentedControlChanged;
@end
