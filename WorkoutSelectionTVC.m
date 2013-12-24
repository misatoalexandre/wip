//
//  WorkoutSelectionTVC.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/20/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "WorkoutSelectionTVC.h"

@interface WorkoutSelectionTVC ()

@end

@implementation WorkoutSelectionTVC


-(id)initWithCoder:(NSCoder *)aCoder{
    
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Workout";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"title";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = NO;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        //self.objectsPerPage = 11;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self query];
    [self.segmentedControl addTarget:self action:@selector(onSegmentedControlChanged) forControlEvents:UIControlEventValueChanged];
  }
-(void)query{
    
    //Abs Query for the Free Abs Plan
     PFQuery *queryAbs=[PFQuery queryWithClassName:self.parseClassName];
    if ([self.objects count] == 0) {
        queryAbs.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [queryAbs getObjectInBackgroundWithId:@"Tpugk5X6AZ" block:^(PFObject *object, NSError *erro){
        self.absFree =[NSArray arrayWithObjects:object, nil];
    }
     ];
    
    
    //Butt Query
    PFQuery *queryButts=[PFQuery queryWithClassName:self.parseClassName];
    if ([self.objects count] == 0) {
        queryButts.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }

    //Butts Query for the Free Butts Plan
    [queryButts getObjectInBackgroundWithId:@"HoTjkEu6e0" block:^(PFObject *object, NSError *erro){
        self.buttsFree =[NSArray arrayWithObjects:object, nil];
    }
     ];
    
     
}
-(void)onSegmentedControlChanged{
    [self.tableView reloadData];
    NSLog(@"Selected segment is %lu", self.segmentedControl.selectedSegmentIndex);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*#pragma mark-
 #pragma mark Query from Parse
 -(PFQuery *)queryForTable{
 
 PFQuery *query=[PFQuery queryWithClassName:self.parseClassName];
 if (self.segmentedControl.selectedSegmentIndex==0)
 {
 // [query whereKey:@"objectId" equalTo:@"Tpugk5X6AZ"];
 [query whereKey:@"segment" equalTo:@"Abs"];
 NSLog(@"number of abs workout %lu", self.objects.count);
 }
 else if(self.segmentedControl.selectedSegmentIndex==1)
 {
 [query whereKey:@"bodyPart" equalTo:@"Butts" ];
 NSLog(@"number of butts workout %lu", self.objects.count);
 }
 
 return query;
 
 }
 */


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentedControl.selectedSegmentIndex==0) {
      /*  if (section==0) {
            return 1;
        }
        if (section==1) {
            return 1;
        }
        if (section==2) {
            return 1;
        }
        if (section==3) {
            return 1;
        }
        if (section==4) {
            return 1;
        }
        if (section==5) {
            return 1;
        }
        if (section==6) {
            return 1;
        }*/
        return self.absFree.count;
        // return objects.count;
       // return abWorkoutArrayPostPurchase.count;
        
    }else if(self.segmentedControl.selectedSegmentIndex==1){
      /*  if (section==0) {
            return 1;
        }
        if (section==1) {
            return 1;
        }
        if (section==2) {
            return 1;
        }
        if (section==3) {
            return 1;
        }
        if (section==4) {
            return 1;
        }
        if (section==5) {
            return 1;
        }
        if (section==6) {
            return 1;
        }*/
        return self.buttsFree.count;
    }
    return 1;
  }

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
object:(PFObject *)object

{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (self.segmentedControl.selectedSegmentIndex==0) {
        if (indexPath.section==0) {
            PFObject *object=[self.absFree objectAtIndex:indexPath.row];
            cell.textLabel.text=[object objectForKey:@"title"];
            cell.detailTextLabel.text=[object objectForKey:@"location"];
        }
        else {
            cell.textLabel.text=@"Unlock to upgrade";
            cell.detailTextLabel.text=@"$1.99";
            }
    }
    else if (self.segmentedControl.selectedSegmentIndex==1){
        if (indexPath.section==0) {
            PFObject *object=[self.buttsFree objectAtIndex:indexPath.row];
            NSLog(@"title butts? %@", [object objectForKey:@"title"]);
            cell.textLabel.text=[object objectForKey:@"title"];
            cell.detailTextLabel.text=[object objectForKey:@"location"];
        } else {
            cell.textLabel.text=@"Unlock to upgrade";
            cell.detailTextLabel.text=@"$1.99";
               }
    }
    
    return cell;
}
    
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.segmentedControl.selectedSegmentIndex==0) {
        if (section==0) {
            return @"Free Lean Abs Workout";
        }
        if (section==1) {
            return @"Level 1 Home";
        }
        if (section==2) {
            return @"Level 1 Gym";
        }
        if (section==3) {
            return @"Level 2 Home";
        }
        if (section==4) {
            return @"Level 2 Gym";
        } if (section==5) {
            return @"Level 3 Home";
        }
        if (section==6) {
            return @"Level 3 Gym";
        }
        
    }
    
    else if (self.segmentedControl.selectedSegmentIndex==1){
        if (section==0) {
            return @"Free Lean Butts Workout";
        }
        if (section==1) {
            return @"Level 1 Home ";
        }
        if (section==2) {
            return @"Level 1 Gym";
        }
        if (section==3) {
            return @"Level 2 Home";
        }
        if (section==4) {
            return @"Level 2 Gym";
        }
        if (section==5) {
            return @"Level 3 Home";
        }
        if (section==6) {
            return @"Level 3 Gym";
        }
    }
    
 return @"title";
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentWorkout=[self.absFree objectAtIndex:indexPath.row];
    NSLog(@"Test%@", self.currentWorkout);
    [self.delegate workoutWasSelectedOnWorkoutSelectionTVC:self];
    
}



/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
