//
//  LaunchTVC.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/24/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "LaunchTVC.h"
#import "BeginWorkoutViewController.h"

@interface LaunchTVC ()
{
    int _selectedSection, _selectedRow; // Selected Workout
}
@end

@implementation LaunchTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.selectedSets=@"2";
    
    self.selectedCell=1;
    
    _selectedSection = 0;
    _selectedRow = 0;
    
    self.selectedSetsLabel.text=[NSString stringWithFormat:@"%@ sets", self.selectedSets];

    self.workoutPlantoBeginId=@"Tpugk5X6AZ";
    
    //Notification sending out
    NSMutableDictionary *workoutIdDictionary=[[NSMutableDictionary alloc]init];
    [workoutIdDictionary setObject:self.workoutPlantoBeginId forKey:@"workoutId"];
    [workoutIdDictionary setObject:self.selectedSets forKey:@"setsCount"];
    
    //dictionaryWithObject:self.workoutPlantoBeginId forKey:@"workoutId"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Passing selected workout ID" object:self userInfo:workoutIdDictionary];
}
- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)viewDidDisappear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"sets"]) {
        SetsTVC *setsTV=(SetsTVC *)[segue destinationViewController];
        setsTV.delegate=self;
        setsTV.selectedCell=self.selectedCell;
    } else if([segue.identifier isEqualToString:@"workout"])
    {
        SelectWorkoutTVCViewController *selectVC = (SelectWorkoutTVCViewController *)[segue destinationViewController];
        selectVC.delegate = self;
        selectVC.selectedRow = _selectedRow;
        selectVC.selectedSection = _selectedSection;
    }
}

#pragma mark-SetsTVC Delegate Method
-(void)setsSelected:(NSDictionary *)sets{
    self.selectedSets = sets[@"SelectedSets"];
    self.selectedCell = [sets[@"SelectedCell"] intValue];
    
    if ([self.selectedSets isEqualToString:@"1"]) {
        self.selectedSetsLabel.text=[NSString stringWithFormat:@"%@ set", self.selectedSets];
    } else{
        self.selectedSetsLabel.text=[NSString stringWithFormat:@"%@ sets", self.selectedSets];
    }
    
}

#pragma mark - WorkoutTVCDelegate methods
- (void)workoutSelected:(NSString *)workout
{
    self.workoutPlantoBeginId = workout;
    //Notification sending out
    NSMutableDictionary *workoutIdDictionary=[[NSMutableDictionary alloc]init];
    [workoutIdDictionary setObject:self.workoutPlantoBeginId forKey:@"workoutId"];
    [workoutIdDictionary setObject:self.selectedSets forKey:@"setsCount"];
    
    //dictionaryWithObject:self.workoutPlantoBeginId forKey:@"workoutId"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Passing selected workout ID" object:self userInfo:workoutIdDictionary];
}

- (void)setWorkoutIndexPath:(NSIndexPath *)indexPath
{
    _selectedRow = (int)indexPath.row;
    _selectedSection = (int)indexPath.section;
}

@end
