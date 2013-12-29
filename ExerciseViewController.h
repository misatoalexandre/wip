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
#import "RestViewController.h"

@interface ExerciseViewController : UIViewController<RestVCDelegate>

@property (nonatomic, strong) PFObject *currentWorkout;
@property (nonatomic, strong) Exercise *exercise;
@property (nonatomic, strong) NSMutableArray *exerciseArray;
@property NSUInteger index;
@property  int setsCount;
@property  int currentSet;

//Timer related
@property (nonatomic, strong) NSTimer *timer;
@property BOOL timerPaused;

//interface elements
@property (weak, nonatomic) IBOutlet UILabel *timerDisplay;
@property (weak, nonatomic) IBOutlet UILabel *nextTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextLabel;
@property (weak, nonatomic) IBOutlet PFImageView *exerciseImage;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
//@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *lastExerciseButton;

//- (IBAction)timerPausePlay:(id)sender;
- (IBAction)nextPressed:(id)sender;
//- (IBAction)previousPressed:(id)sender;
- (IBAction)PausePressed:(id)sender;
- (IBAction)lastExercisePressed:(id)sender;


@end
