//
//  BeginWorkoutViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/24/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "BeginWorkoutViewController.h"

@interface BeginWorkoutViewController ()

@end

@implementation BeginWorkoutViewController

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
    NSLog(@"%@ :Tpugk5X6AZ", self.workoutId);
    [self query];

	// Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.displayImageView setImage:nil];
    [self.firstEpmtImageView setImage:nil];
    [self.secondEmptImageView setImage:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)query{
    PFQuery *query = [PFQuery queryWithClassName:@"Workout"];
    query.cachePolicy=kPFCachePolicyCacheThenNetwork;
    [query getObjectInBackgroundWithId:@"Tpugk5X6AZ" block:^(PFObject *object, NSError *error) {
       
        NSLog(@"%@", object);
    }];
}
- (IBAction)beginWorkout:(id)sender {
}
@end
