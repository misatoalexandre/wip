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

@interface ExerciseViewController (){
    NSDate *pauseStart;
    NSDate *previousFireDate;
    int seconds;
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
    [self query];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self beginTimer];
    
    self.index=0;
    //self.timerPaused=NO;
 
    self.exercise=[[Exercise alloc]initWithClassName:@"PFObject"];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(updateInterface:)
                                                name:@"ExerciseArrayFetched"
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(beginTimer:)
                                                name:@"secondsValue"
                                              object:nil];
      NSLog(@"Exercise VC view Did load self.currentWorkout %@", self.currentWorkout);
    
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.timer=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)restIsUp:(RestViewController *)controller {
    [controller.navigationController popViewControllerAnimated:YES];
    if (self.index<=4) {
        self.index=self.index+1;
    }
        

    
}
-(void)timerFireMethods:(NSTimer *)theTimer{
    
        if (seconds>=10) {
            self.timerDisplay.text=[NSString
                                              stringWithFormat:@"00:%d",seconds];
            seconds--;
        } else if (seconds>=0){
            self.timerDisplay.text=[NSString
                                             stringWithFormat:@"00:0%d",seconds];
            seconds--;
        }else{
            [self.timer invalidate];
            [self performSegueWithIdentifier:@"rest" sender:self];
        }
   }
-(void)beginTimer:(NSNotification *)note{
    NSDictionary *secondsNSNumber=[note userInfo];
    if (secondsNSNumber!=nil) {
        seconds=[[secondsNSNumber objectForKey:@"secondsNSNumber"]intValue];
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(timerFireMethods:)
                    
                                                  userInfo:nil
                                                   repeats:YES];
        
    }else{
        NSLog(@"Begin Tiemr Error");
    }
}
-(void)query{
    //Fetch all the objects in the relations and load them into an array
    PFRelation *relation=[self.currentWorkout relationforKey:@"exercise"];
    PFQuery *query=[relation query];
    query.cachePolicy=kPFCachePolicyCacheElseNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error){
        NSLog(@"Exercise cout Inside query %lu: %@", results.count, results);
        if (!error) {
            NSDictionary *resultsArrayDictionary=[NSDictionary dictionaryWithObject:results
                                                                             forKey:@"results"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ExerciseArrayFetched"
                                                                object:self
                                                              userInfo:resultsArrayDictionary];
            
        }else
        {
            UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Query Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
            [view show];
        }
        
    }];
}
-(void)updateInterface:(NSNotification*)note{
    NSDictionary *theExerciseArray=[note userInfo];
    if (theExerciseArray!=nil) {
        self.exerciseArray=[theExerciseArray objectForKey:@"results"];
        [self presentUI];
    }
}
-(void)presentUI{
    NSLog(@"present UI %lu %@", self.exerciseArray.count, self.exerciseArray);
    self.exercise.name=[[self.exerciseArray objectAtIndex:self.index]objectForKey:@"name"];
    self.exercise.imageFile=[[self.exerciseArray objectAtIndex:self.index]objectForKey:@"image"];
    self.exercise.time=[[self.exerciseArray objectAtIndex:self.index]objectForKey:@"time"];
    self.title=self.exercise.name;
    //self.seconds=[self.exercise.time intValue];
    
    NSDictionary *sec=[NSDictionary dictionaryWithObject:self.exercise.time
                                                                     forKey:@"secondsNSNumber"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"secondsValue"
                                                        object:self
                                                      userInfo:sec];
    //self.timerButton.titleLabel.text=[NSString stringWithFormat:@"00:%d",timerSetFor];
    self.exerciseImage.file=self.exercise.imageFile;
    [self.exerciseImage loadInBackground];
  
}
#pragma mark-IBActions
- (IBAction)nextPressed:(id)sender {
    //prepareForSegue gets called.
    [self.timer invalidate];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"rest"]) {
        RestViewController *restVC=(RestViewController *)[segue destinationViewController];
        NSLog(@"prepare for segue %@", self.exerciseArray);
        restVC.exerciseArray=self.exerciseArray;
        restVC.index=self.index+1;
        restVC.delegate=self;
    }
}

- (IBAction)PausePressed:(id)sender {
    if (self.timerPaused==NO) {
        self.timerPaused=YES;
        [self.pauseButton setImage:[UIImage imageNamed:@"playII.png"] forState:UIControlStateNormal];
       // [self.timerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //[self.timerButton setTitle:@"Paused" forState:UIControlStateNormal];
       
        pauseStart=[NSDate dateWithTimeIntervalSinceNow:0];
        previousFireDate=[self.timer fireDate];
        [self.timer setFireDate:[NSDate distantFuture]];

    }else{
        self.timerPaused=NO;
        [self.pauseButton setImage:[UIImage imageNamed:@"pauseThick (1).png"] forState:UIControlStateNormal];
        
        float pauseTime=-1*[pauseStart timeIntervalSinceNow];
        [self.timer setFireDate:[NSDate dateWithTimeInterval:pauseTime sinceDate:previousFireDate]];
    }
}

/*- (IBAction)stopPressed:(id)sender {
}*/
/*- (IBAction)previousPressed:(id)sender {
 }*/
/*- (IBAction)timerPausePlay:(id)sender {
 self.nextButton.hidden=NO;
 self.nextButton.enabled=YES;
 
 if (self.index!=0) {
 self.previousButton.hidden=NO;
 self.previousButton.enabled=YES;
 }
 
 }*/

@end






















