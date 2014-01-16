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
#import <Parse/Parse.h>

@interface LaunchTVC : UITableViewController<SetsTVCDelegate,WorkoutTVCDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

//sets selection 
@property (nonatomic, strong)NSString *selectedSets;
@property(nonatomic, assign)int selectedCell;
@property (nonatomic, strong) PFObject *currentWorkout;
@property (nonatomic, strong) NSArray *exerciseList;

// data to pass to begin workout
@property (nonatomic, strong)NSString *workoutPlantoBeginId;

@property (weak, nonatomic) IBOutlet UILabel *selectedSetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedWorkoutLabel;

//Top Section View Elements.
@property (weak, nonatomic) IBOutlet UILabel *workoutTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *equipmentLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//@property (weak, nonatomic) IBOutlet UIView *containerView;

- (IBAction)startPressed:(id)sender;
//-(void)query:(NSDictionary *)workoutDictionary;
-(void)UpdateUserInterface:(PFObject *)pfObject;
@end
