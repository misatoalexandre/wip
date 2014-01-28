//
//  LaunchTVC.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/24/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "LaunchTVC.h"
#import "EquipmentCell.h"
#import "ExerciseViewController.h"
#import <Parse/Parse.h>

@interface LaunchTVC ()
{
    int _selectedSegment, _selectedRow; // Selected Workout
    NSArray *equipmentArray;
    NSString *workoutTitle;
}
@end

@implementation LaunchTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    self.selectedCell = 1;
    _selectedSegment = 0;
    _selectedRow = 0;
    

    self.selectedSets = @"2";
    self.selectedSetsLabel.text = [NSString stringWithFormat:@"%@ sets", self.selectedSets];
    self.workoutPlantoBeginId = @"PIp9N5a5Zk";
    [self query:self.workoutPlantoBeginId];
    
    //Collection View Related
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
   //[self.collectionView reloadData];
    
    
}
- (void)viewDidAppear:(BOOL)animated{
   
}

- (void)viewDidDisappear:(BOOL)animated{
 //self.collectionView=nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    //    _containerView.frame = CGRectMake(0, 0, 320, 300);
}

-(void)query:(NSString*)workoutId{
    if (workoutId!=nil) {
      
       self.workoutPlantoBeginId=workoutId;
        NSLog(@"Query: %@", self.workoutPlantoBeginId);
        
        PFQuery *query=[PFQuery queryWithClassName:@"WorkoutPlans"];
        [query includeKey:@"exerciseList"];
        [query includeKey:@"equipmentList"];
        query.cachePolicy=kPFCachePolicyCacheElseNetwork;
        
        [query getObjectInBackgroundWithId:self.workoutPlantoBeginId block:^(PFObject *object, NSError *error){
            if (!error) {
                self.currentWorkout=object;
                [self UpdateUserInterface:self.currentWorkout];
            }else if (error){
                NSLog(@"error in query Launch TVC: %@", [error localizedDescription]);
            }
        }];
    }
    
}
-(void)UpdateUserInterface:(PFObject * ) pfObject{
    if (pfObject!=nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.workoutTitleLabel.text=[pfObject objectForKey:@"title"];
            self.selectedWorkoutLabel.text=[pfObject objectForKey:@"title"];
            
            equipmentArray=[pfObject objectForKey:@"equipmentList"];
            [self.collectionView reloadData];
            if (equipmentArray) {
                NSLog(@"AA: %@", equipmentArray);
                //[self.collectionView reloadData];
                self.equipmentLabel.text=@"You'll need";
            }
            else if (!equipmentArray) {
                if ([[pfObject objectForKey:@"Location"] isEqualToString:@"Gym"]) {
                    self.equipmentLabel.text=@"Gym Workout";
                    //self.collectionView.hidden=YES;
                }else if ([[pfObject objectForKey:@"Location"]isEqualToString:@"Home"]){
                    self.equipmentLabel.text=@"No Equipments Required";
                    //self.collectionView.hidden=YES;
                }
            }        }
                       );}
    
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"sets"]) {
        SetsTVC *setsTV=(SetsTVC *)[segue destinationViewController];
        setsTV.delegate=self;
        setsTV.selectedCell=self.selectedCell;
    } else if([segue.identifier isEqualToString:@"workout"])
    {
        SelectWorkoutTVCViewController *selectVC = (SelectWorkoutTVCViewController *)[segue destinationViewController];
        selectVC.delegate = self;
        selectVC.selectedRow = _selectedRow;
        selectVC.selectedSegment = _selectedSegment;
        selectVC.segmentedControl.selectedSegmentIndex=_selectedSegment;
        
    }else if ([segue.identifier isEqualToString:@"start"]){
        ExerciseViewController *exerciseVC=(ExerciseViewController*)[segue destinationViewController];
        exerciseVC.currentWorkout=self.currentWorkout;
        exerciseVC.setsCount=[self.selectedSets intValue];
        NSLog(@"SetsCount: %@",self.selectedSets);
        exerciseVC.firstExerciseInWorkoutPlan=YES;
    }
}
#pragma mark-UICollectionView Data Source
-(NSInteger) numberofSelectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%d", (unsigned)equipmentArray.count);
    if (!equipmentArray) {
       return 1;
    }else
    return equipmentArray.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"Cell";
    
    //Add Custom Cell here
   EquipmentCell *cell=(EquipmentCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //Configure the cell
    NSLog(@"CC");
    if (equipmentArray) {
        cell.equipmentNameLabel.text=[[equipmentArray objectAtIndex:indexPath.row]objectForKey:@"name"];
        cell.imageView.file=[[equipmentArray objectAtIndex:indexPath.row]objectForKey:@"equipmentImageFile"];
        [cell.imageView loadInBackground];
    }else if (!equipmentArray){
        cell.equipmentNameLabel.text=nil;
        cell.imageView.image=nil;
        }
   
    
    return cell;
    
    
}



#pragma mark-SetsTVC Delegate Method
-(void)setsSelected:(NSDictionary *)sets{
    self.selectedSets = sets[@"SelectedSets"];
    self.selectedCell = [sets[@"SelectedCell"] intValue];
    
    
    if ([self.selectedSets isEqualToString:@"1"]) {
        self.selectedSetsLabel.text=[NSString stringWithFormat:@"%@ set", self.selectedSets];
    } else{
        self.selectedSetsLabel.text=[NSString stringWithFormat:@"%@ sets", self.selectedSets];
    }
}

#pragma mark - WorkoutTVCDelegate methods
- (void)workoutSelected:(NSString *)workout
{
    self.workoutPlantoBeginId = workout;
    //Notification sending out
    NSMutableDictionary *workoutIdDictionary=[[NSMutableDictionary alloc]init];
    [workoutIdDictionary setObject:self.workoutPlantoBeginId forKey:@"workoutId"];
    [workoutIdDictionary setObject:self.selectedSets forKey:@"setsCount"];
    
    [self query:self.workoutPlantoBeginId];
    //[self query:workoutIdDictionary];
    //dictionaryWithObject:self.workoutPlantoBeginId forKey:@"workoutId"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Passing selected workout ID" object:self userInfo:workoutIdDictionary];
}

- (void)setWorkoutIndexPath:(NSDictionary *)data
{
    _selectedRow = [data[@"row"] intValue];
    _selectedSegment = [data[@"segment"] intValue];
}

- (IBAction)startPressed:(id)sender {
}
@end
