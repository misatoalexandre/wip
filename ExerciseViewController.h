//
//  ExerciseViewController.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/21/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Exercise.h"

@interface ExerciseViewController : UIViewController

@property (nonatomic, strong) PFObject *currentWorkout;
@property (nonatomic, strong) Exercise *exercise;
@property (nonatomic, strong) NSMutableArray *exerciseArray;
@property NSUInteger index;


//Timer related
@property (nonatomic, strong) NSTimer *timer;
@property BOOL timerPaused;

//interface elements
@property (weak, nonatomic) IBOutlet PFImageView *exerciseImage;
@property (weak, nonatomic) IBOutlet UIButton *timerButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

//- (IBAction)timerPausePlay:(id)sender;
- (IBAction)nextPressed:(id)sender;
//- (IBAction)previousPressed:(id)sender;
- (IBAction)PausePressed:(id)sender;


@end
