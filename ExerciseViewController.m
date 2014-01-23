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
#define LastExerciseAudio @"Last5secs"


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
        [self timerAndSoundBegins:clockAudio loopCount:-1 audioFileCount:[NSNumber numberWithInt:1]];
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
    player=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)pausetimer{
    pauseStart = [NSDate dateWithTimeIntervalSinceNow:0];
    previousFireDate = [self.timer fireDate];
    [self.timer setFireDate:[NSDate distantFuture]];
}
-(void)timerFireMethods:(NSTimer *)theTimer{
    if (self.exercise.repeat==[NSNumber numberWithBool:YES]) {
        //NSLog(@"Repeat came through");
        if (seconds==([self.exercise.time intValue]/2)+10) {
            [player stop];
            [self timerAndSoundBegins:switchSidesAudio loopCount:0 audioFileCount:0];
            [self performSelector:@selector(pausetimer) withObject:nil afterDelay:10];
        }
    }
    if ((lastExercise)&&(lastSet)) {
        if (seconds==6) {
            [self timerAndSoundBegins:LastExerciseAudio loopCount:0 audioFileCount:nil];
        }
    } else{
        if (seconds==9) {
            [player stop];
            [self.timer invalidate];
            [self timerAndSoundBegins:ExerciseGoingRestAudio loopCount:0 audioFileCount:[NSNumber numberWithInt:2]];//2
        }
    }
    /*if ((seconds==9)&&(!lastExercise)&&(!lastSet)) {
        [player stop];
        [self.timer invalidate];
        [self timerAndSoundBegins:ExerciseGoingRestAudio loopCount:0 audioFileCount:[NSNumber numberWithInt:2]];
    }*/
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
#pragma mark-UI Related
-(void)presentUI{
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
#pragma mark- Audio
-(void)timerAndSoundBegins:(NSString*)audioFile loopCount:(int)loopCount audioFileCount:(NSNumber*)audioFileCount{
    
    NSString *soundFilePath=[[NSBundle mainBundle]pathForResource:audioFile ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
   
    player.numberOfLoops=loopCount;
    [player play];
    
    if (audioFileCount==0){//first exercise in the program. Going to play clock audio.
        player.delegate=self;
    }else if (audioFileCount==[NSNumber numberWithInt:1]){//Clock audio started. Starting the timer.
        [self beginTimer:self.exercise.time];
    }else if  (audioFileCount==[NSNumber numberWithInt:2]){//last 5 sec count to rest audio.
        [self beginTimer:[NSNumber numberWithInt:8]];
    }else if (audioFileCount==[NSNumber numberWithInt:3]){//switch sides. Pausing timer until the clock audio for new sides start.
        float pauseTime = -1 * [pauseStart timeIntervalSinceNow];
        [self.timer setFireDate:[ NSDate dateWithTimeInterval:pauseTime sinceDate:previousFireDate]];
    };
}
- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (self.firstExerciseInWorkoutPlan) {
        [self timerAndSoundBegins:clockAudio loopCount:-1 audioFileCount:[NSNumber numberWithInt:1]];
    }else if (self.exercise.repeat==[NSNumber numberWithBool:YES])   {
        [self timerAndSoundBegins:clockAudio loopCount:-1 audioFileCount:[NSNumber numberWithInt:3]];
    }
}
#pragma mark - Nav Bar Button method
-(void)endWorkout{
    [player stop];
    [self.timer invalidate];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark-IBActions
- (IBAction)workoutTimerStartButtonPressed:(id)sender {
    [self timerAndSoundBegins:SetUpAudio loopCount:0 audioFileCount:0];
    
    self.workoutTimerStartButton.hidden=YES;
    //self.firstExerciseInWorkoutPlan=NO;
    self.nextButton.enabled=YES;
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
        lastVC.title = @"Workout Complete!";
    }
    
}



@end
