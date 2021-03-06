//
//  BeginWorkoutViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/24/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "BeginWorkoutViewController.h"
#import "ExerciseViewController.h"

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
     //*****This gets called first before Launch VC's view loads.*****//
    //[self query];
    
    //Receive notification for workoutID
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(query:)
                                                name:@"Passing selected workout ID"
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(interfaceUpdates:) name:@"workoutObjectCameThrough"
                                              object:nil];
   /* [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(updateDisplayImage:) name:@"displayMainImage"
                                              object:nil];*/


	// Do any additional setup after loading the view.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

-(void)query:(NSNotification *)note{
    NSDictionary *theWorkoutID = [note userInfo];
    if (theWorkoutID != nil) {
        self.workoutId = [theWorkoutID objectForKey:@"workoutId"];
        self.setCount = [[theWorkoutID objectForKey:@"setsCount"]intValue];
        NSLog(@"query: %@ setsCount :%d", self.workoutId, self.setCount);
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"WorkoutPlans"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query getObjectInBackgroundWithId:self.workoutId
                                 block:^(PFObject *object, NSError *error)
    {
        if (!error) {
            NSDictionary *pfObject = [NSDictionary dictionaryWithObject:object
                                                               forKey:@"workoutObject"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"workoutObjectCameThrough"
                                                               object:self
                                                             userInfo:pfObject];

        }else if (error){
            NSLog(@"error in query beginWorkoutVC %@", [error localizedDescription]);
        }
    }];
}
-(void)interfaceUpdates:(NSNotification*)note{
    NSDictionary *theWorkoutObject = [note userInfo];
    if (theWorkoutObject != nil)
    {
        self.currentWorkout=[theWorkoutObject objectForKey:@"workoutObject"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.equipmentLabel.text=[self.currentWorkout objectForKey:@"title"];
        });
        //PFFile *imageFile=[self.currentWorkout objectForKey:@"displayImage"];
       /* [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
           
            UIImage *image=[UIImage imageWithData:data];
            
            NSDictionary *displayImageDictionary=[NSDictionary dictionaryWithObject:image
                                                                            forKey:@"uiImage"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"displayMainImage"
                                                               object:self
                                                             userInfo:displayImageDictionary];
        }];*/
        NSLog(@"Workout Start Page:inside interfaceUpdates:%@", [self.currentWorkout objectForKey:@"title"]);
    }
}

- (IBAction)beginWorkout:(id)sender {
    //[self prepareForSegue:@"start" sender:sender];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ExerciseViewController *evc = (ExerciseViewController *)[segue destinationViewController];
    evc.currentWorkout = self.currentWorkout;
    evc.setsCount = self.setCount;
}
@end
