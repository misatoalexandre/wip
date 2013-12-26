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
-(void)viewWillAppear:(BOOL)animated{
    [self query];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayofExerciseModel=[[NSMutableArray alloc]initWithCapacity:4];
    
    self.index=0;
    self.previousButton.hidden=YES;
    self.previousButton.enabled=NO;
    self.nextButton.hidden=YES;
    self.nextButton.enabled=NO;
    
    self.exercise=[[Exercise alloc]initWithClassName:@"PFObject"];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(updateInterface:)
                                                name:@"ExerciseArrayFetched"
                                              object:nil];
    NSLog(@"Exercise VC view Did load self.currentWorkout %@", self.currentWorkout);
    
    // Do any additional setup after loading the view.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.arrayofExerciseModel=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)query{
    //Fetch all the objects in the relations and load them into an array
    PFRelation *relation=[self.currentWorkout relationforKey:@"exercise"];
    PFQuery *query=[relation query];
    query.cachePolicy=kPFCachePolicyCacheOnly;
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
        
        NSLog(@"Exercise VC Inside UpdateInterface %lu %@", self.exerciseArray.count, self.exerciseArray);
        
        for (PFObject *singleObject in self.exerciseArray) {
            self.exercise.name=[singleObject objectForKey:@"name"];
            self.exercise.time=(unsigned)[singleObject objectForKey:@"time"];
            self.exercise.imageFile=[singleObject objectForKey:@"image"];
            [self.arrayofExerciseModel addObject:self.exercise];
            NSLog(@"Exercise VC. Update interface: Single Exercise Model \n %@:%lu: %@", self.exercise.name, self.exercise.time,
                  self.exercise.image);
        }
        [self displayUI];
        
        
    }
    
}
-(void)displayUI{
    
    
    self.timerButton.titleLabel.text=[NSString
                                      stringWithFormat:@"%lu",
                                      [[self.arrayofExerciseModel objectAtIndex:self.index]time]];
    
    self.exerciseImage.file=[[self.arrayofExerciseModel objectAtIndex:self.index]imageFile];
    [self.exerciseImage loadInBackground];
    
}

- (IBAction)timerPausePlay:(id)sender {
    self.nextButton.hidden=NO;
    self.nextButton.enabled=YES;
    
    if (self.index!=0) {
        self.previousButton.hidden=NO;
        self.previousButton.enabled=YES;
    }
    
    
}

- (IBAction)nextPressed:(id)sender {
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"rest"]) {
        RestViewController *restVC=(RestViewController *)[segue destinationViewController];
        restVC.exerciseArray=self.arrayofExerciseModel;
        restVC.index=self.index;
    }
}

- (IBAction)previousPressed:(id)sender {
}
@end
