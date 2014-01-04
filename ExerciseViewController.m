//
//  ExerciseViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/21/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "ExerciseViewController.h"
#import <Parse/Parse.h>
#import "Workout.h"
#import "RestViewController.h"
#import "EndPageVC.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
/*
 Check timer. when workout runs for the second time, timer gets messed up.
 Check set and exercise count
 Add repeat timer for exercises with two sides. 
 Memory management issues.
 */

@interface ExerciseViewController (){
    NSDate *pauseStart;
    NSDate *previousFireDate;
    int seconds;
    BOOL lastExercise;
    BOOL lastSet;
    AVAudioPlayer *player;
}

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
-(void)viewWillAppear:(BOOL)animated{
    self.timerDisplay.text = @"--:--";
    
    if ((lastExercise)&&(lastSet)) {
        self.nextButton.hidden=YES;
        self.nextButton.enabled=NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [player stop];
    [self.timer invalidate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.index = 0;
    self.currentSet = 1;
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"clock" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    player.numberOfLoops = -1;
    
    self.exerciseImage.contentMode = UIViewContentModeScaleAspectFit;
    
    self.exercise=[Exercise object];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(setsCount:)
                                                name:@"Passing SetsCount"
                                              object:nil];
    
    [self query];
    
    NSLog(@"Exercise VC view Did load self.currentWorkout %@", self.currentWorkout);
}

-(void)dealloc{
    NSLog(@"Dealloc");
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.timer=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setsCount:(NSNotification *)note{
    NSDictionary *theSetsData=[note userInfo];
    if (theSetsData!=nil) {
        self.setsCount=[[theSetsData objectForKey:@"setsCount"]intValue];
        NSLog(@"sets count %d notified", self.setsCount);
    }
    
}
#pragma mark-Rest View Controller Delegate
-(void)restIsUp:(RestViewController *)controller {
    [controller.navigationController popViewControllerAnimated:YES];
    if (controller.index<self.exerciseArray.count-1) {
         self.index=controller.index;
        lastExercise=NO;
        NSLog(@"case 1");
    }else if(controller.index==self.exerciseArray.count-1){
        self.index=controller.index;
        lastExercise=YES;
            if (controller.currentSet<self.setsCount) {
                lastSet=NO;
                self.currentSet++;
                NSLog(@"case 2 current set%d %d", self.currentSet, lastSet);
            }
            else if(controller.currentSet==self.setsCount){
                NSLog(@"case 3");
                lastSet=YES;
            }
    }else {
        NSLog(@"Index, set Error");
    }
    [self presentUI];
}

#pragma mark-Timer Methods
-(void)beginTimer:(NSNumber *)time{
    seconds = [time intValue];
    self.timerPaused = NO;
    
    [player play];
    
    [self.pauseButton setImage:[UIImage imageNamed:@"Pause button blue.png"] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(timerFireMethods:)
                                              userInfo:nil
                                               repeats:YES];    
}
-(void)timerFireMethods:(NSTimer *)theTimer{
    if (seconds >= 0) {
        self.timerDisplay.text=[NSString stringWithFormat:@"%02d:%02d", seconds / 60, seconds % 60];
        seconds--;
    }else{
        [player stop];
        [self.timer invalidate];
        if ((lastExercise)&&(lastSet)) {
            [self performSegueWithIdentifier:@"end" sender:self];
        }else{
             [self performSegueWithIdentifier:@"rest" sender:self];
        }
    }
}

#pragma mark-Query
-(void)query{
    //Fetch all the objects in the relations and load them into an array
    PFRelation *relation=[self.currentWorkout relationforKey:@"exercise"];
    PFQuery *query=[relation query];
    query.cachePolicy=kPFCachePolicyCacheElseNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error){
//        NSLog(@"Exercise cout Inside query %lu: %@", (unsigned long)results.count, results);
        if (!error) {
            self.exerciseArray = [NSMutableArray arrayWithArray:results];
            [self presentUI];
        } else {
            NSLog(@"Query error ExerciseVC %@", [error localizedDescription]);
        }
    }];
}

-(void)presentUI{
//    NSLog(@"present UI %lu %@", (unsigned long)self.exerciseArray.count, self.exerciseArray);
    self.exercise.name = [self.exerciseArray objectAtIndex:self.index][@"name"];
    self.exercise.imageFile = [self.exerciseArray objectAtIndex:self.index][@"image"];
    self.exercise.time = [self.exerciseArray objectAtIndex:self.index][@"time"];
    self.exercise.goal = [self.exerciseArray objectAtIndex:self.index][@"goal"];
    self.title = self.exercise.name;
    self.goalLabel.text = [NSString stringWithFormat:@"GOAL   %@", self.exercise.goal];
    
    [self beginTimer:self.exercise.time];
   
    self.exerciseImage.file = self.exercise.imageFile;
    [self.exerciseImage loadInBackground];
  
}
#pragma mark-IBActions

- (IBAction)nextPressed:(id)sender {
//  Will be invalidated automatically by viewDidDisappear
//  [self.timer invalidate];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"rest"])
        {
            RestViewController *restVC = (RestViewController *)[segue destinationViewController];
            NSLog(@"prepare for segue %@", self.exerciseArray);
            restVC.delegate = self;
            restVC.exerciseArray = self.exerciseArray;
            restVC.currentSet = self.currentSet;
            restVC.setsCount = self.setsCount;
            
            if ((lastExercise) && (!lastSet)) {
                restVC.index = 0;
            }else if (!lastExercise){
                restVC.index = self.index + 1;
            }
        }
    if ([segue.identifier isEqualToString:@"end"]) {
        EndPageVC *lastVC = (EndPageVC *)[segue destinationViewController];
        lastVC.title = @"YOU DID IT!";
    }
   
}

- (IBAction)PausePressed:(id)sender {
    if (self.timerPaused == NO) {
        [player pause];
        self.timerPaused = YES;
        [self.pauseButton setImage:[UIImage imageNamed:@"play button blue.png"] forState:UIControlStateNormal];
       
        pauseStart = [NSDate dateWithTimeIntervalSinceNow:0];
        previousFireDate = [self.timer fireDate];
        [self.timer setFireDate:[NSDate distantFuture]];
    }else{
        [player play];
        self.timerPaused = NO;
        [self.pauseButton setImage:[UIImage imageNamed:@"Pause button blue.png"] forState:UIControlStateNormal];
        
        float pauseTime = -1 * [pauseStart timeIntervalSinceNow];
        [self.timer setFireDate:[NSDate dateWithTimeInterval:pauseTime sinceDate:previousFireDate]];
    }
}

- (IBAction)lastExercisePressed:(id)sender {
    NSLog(@"share");
}

@end
