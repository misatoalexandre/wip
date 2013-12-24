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
    
    self.workoutPlantoBeginId=@"Tpugk5X6AZ";
    NSLog(@"Test%@", self.workoutPlantoBeginId);
    self.selectedSets=@"2";
    self.selectedCell=1;
    self.selectedSetsLabel.text=[NSString stringWithFormat:@"%@ sets", self.selectedSets];

}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.selectedSets=nil;
    self.selectedSetsLabel=nil;
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
    }
     else
     {
        BeginWorkoutViewController *bgVC=(BeginWorkoutViewController *)[segue destinationViewController];
        bgVC.workoutId=self.workoutPlantoBeginId;
         NSLog(@"current workoutPlantoBeginID? %@", self.workoutPlantoBeginId);
    }
}

#pragma mark-SetsTVC Delegate Method
-(void)setsSelected:(SetsTVC *)controller{
    self.selectedSets=controller.selectedSets;
    self.selectedCell=controller.selectedCell;
    if ([self.selectedSets isEqualToString:@"1"]) {
        self.selectedSetsLabel.text=[NSString stringWithFormat:@"%@ set", self.selectedSets];
    } else{
         self.selectedSetsLabel.text=[NSString stringWithFormat:@"%@ sets", self.selectedSets];
    }
    [controller.navigationController popViewControllerAnimated:YES];
   
}


@end
