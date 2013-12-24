//
//  ExerciseViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/21/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "ExerciseViewController.h"

@interface ExerciseViewController ()

@end

@implementation ExerciseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(query:)
                                                name:@"workoutObjectCameThroug"
                                              object:nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)query:(NSNotification*)note{
    NSDictionary *workoutObject=[note userInfo];
    if (workoutObject!=nil) {
        
    }
    
    
}
- (IBAction)timerPausePlay:(id)sender {
}

- (IBAction)nextPressed:(id)sender {
}

- (IBAction)previousPressed:(id)sender {
}
@end
