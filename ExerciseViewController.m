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

/*
 Add repeat timer for exercises with two sides. 
 Memory management issues.
 */
//#define firstExerciseSetUpAudio  @"FirstExerciseinWorkout"
#define switchSidesAudio  @"switchSides"
#define ExerciseGoingRestAudio  @"rest-2"
#define clockAudio  @"clock"
#define SetUpAudio  @"EndofRest"


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
    if (self.firstExerciseInWorkoutPlan==NO) {
        NSLog(@"First Exercise %d", self.firstExerciseInWorkoutPlan);
        [self timerAndSoundBegins:clockAudio loopCount:-1 audioFileCount:1];
        [player play];
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
    
    
    self.exerciseImage.contentMode = UIViewContentModeScaleAspectFit;
    
    self.exercise = [Exercise object];
    self.exerciseArray=[self.currentWorkout objectForKey:@"exerciseList"];
    [self presentUI];
    
    
    NSLog(@"Exercise VC view Did load self.currentWorkout %@", self.currentWorkout);
    
    //End Workout Bar Button
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(endWorkout)];
    self.navigationItem.rightBarButtonItem = backButton;
    
    self.nextButton.enabled=NO;
}
-(void)dealloc{
    
    self.timer=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Nav Bar Button method
-(void)endWorkout{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark-Rest View Controller Delegate
-(void)restIsUp:(RestViewController *)controller {
    [controller.navigationController popViewControllerAnimated:YES];
    self.firstExerciseInWorkoutPlan=NO;
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
    
    //[player play];
    
    [self.pauseButton setImage:[UIImage imageNamed:@"Pause button blue.png"] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(timerFireMethods:)
                                              userInfo:nil
                                               repeats:YES];    
}
-(void)timerFireMethods:(NSTimer *)theTimer{
    
    if (seconds==9) {
        [player stop];
        [self timerAndSoundBegins:ExerciseGoingRestAudio loopCount:0 audioFileCount:2];
    }else if (seconds >= 0) {
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
#pragma mark-UI Related
-(void)presentUI{
//  NSLog(@"present UI %lu %@", (unsigned long)self.exerciseArray.count, self.exerciseArray);
    self.exercise.name = [self.exerciseArray objectAtIndex:self.index][@"name"];
    self.exercise.imageFile = [self.exerciseArray objectAtIndex:self.index][@"image"];
    self.exercise.time = [self.exerciseArray objectAtIndex:self.index][@"time"];
    self.exercise.goal = [self.exerciseArray objectAtIndex:self.index][@"goal"];
    self.title = self.exercise.name;
    self.goalLabel.text = [NSString stringWithFormat:@"GOAL   %@", self.exercise.goal];
    self.exercise.repeat=[self.exerciseArray objectAtIndex:self.index][@"repeat"];
    NSLog(@"repeat : %@", self.exercise.repeat);
   
    self.exerciseImage.file = self.exercise.imageFile;
    [self.exerciseImage loadInBackground];
  
}
#pragma mark-IBActions
- (IBAction)workoutTimerStartButtonPressed:(id)sender {
    [self timerAndSoundBegins:SetUpAudio loopCount:0 audioFileCount:0];
  
    self.workoutTimerStartButton.hidden=YES;
    self.firstExerciseInWorkoutPlan=NO;
    self.nextButton.enabled=YES;
}
#pragma mark- Audio
-(void)timerAndSoundBegins:(NSString*)audioFile loopCount:(int)loopCount audioFileCount:(int)audioFileCount{
    
    NSString *soundFilePath=[[NSBundle mainBundle]pathForResource:audioFile ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
   
    player.numberOfLoops=loopCount;
    [player play];
    
    if (audioFileCount==0) {
        player.delegate=self;
    }else if (audioFileCount==1){
        [self beginTimer:self.exercise.time];
    }else if  (audioFileCount==2){
        [self.timer invalidate];
        [self beginTimer:[NSNumber numberWithInt:8]];
    };
    
}
- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self timerAndSoundBegins:clockAudio loopCount:-1 audioFileCount:1];
}

- (IBAction)nextPressed:(id)sender {
//  Will be invalidated automatically by viewDidDisappear
//  [self.timer invalidate];
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



@end
