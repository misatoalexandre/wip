//
//  SelectWorkoutTVCViewController.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/29/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//
/* ***** create 
      two segments:     Abs
                        Butts

 3 sections/segment:    (segment name) Level 1
                        (segment name) Level 2
                        (segment name) Level 3
 
 Pre Purchase:
 
 (segment name) Level 1
 ----------------------------------------------
 IndexPath.row =0: (segment name) Free Home     <----Workout Program itself
 IndexPath.row =1: (segment name) Home Workouts
 IndexPath.row =2: (segment name) Gym Workouts

 (segment name) Level 2
 ----------------------------------------------
 IndexPath.row =0: (segment name) Home Workouts
 IndexPath.row =1: (segment name) Gym Workouts
 
 (segment name) Level 3
 ----------------------------------------------
 IndexPath.row =0: (segment name) Home Workouts
 IndexPath.row =1: (segment name) Gym Workouts
 
 
 Post Purchase: 
 Purchased Product is Level 1 Home Workouts
 
 (segment name) Level 1
 ----------------------------------------------
 IndexPath.row =0: (segment name) Free Home     <----Workout Program itself
 IndexPath.row =1: (segment name) Home Workout 1
 IndexPath.row =2: (segment name) Home Workout 2
 IndexPath.row =3: (segment name) Home Workout 3
 IndexPath.row =4: (segment name) Home Workout 4
 IndexPath.row =5: (segment name) Home Workout 5
 IndexPath.row =6: (segment name) Gym Workouts
 
 (segment name) Level 2
 ----------------------------------------------
 IndexPath.row =0: (segment name) Home Workouts
 IndexPath.row =1: (segment name) Gym Workouts
 
 (segment name) Level 3
 ----------------------------------------------
 IndexPath.row =0: (segment name) Home Workouts
 IndexPath.row =1: (segment name) Gym Workouts

 */


#import <UIKit/UIKit.h>

@protocol WorkoutTVCDelegate<NSObject>

- (void)workoutSelected:(NSString *)workout;
- (void)setWorkoutIndexPath:(NSDictionary *)data;

@end

@interface SelectWorkoutTVCViewController : UITableViewController
@property (nonatomic, assign)   id<WorkoutTVCDelegate> delegate;
@property (weak, nonatomic)     IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)selectSegment:(id)sender;
@property (nonatomic, assign)   int selectedSegment;
@property (nonatomic, assign)   int selectedRow;
@end
