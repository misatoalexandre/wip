//
//  ViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
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
	// Do any additional setup after loading the view.
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)query{
    
    PFQuery *queryAbs=[PFQuery queryWithClassName:@"Workout"];
    queryAbs.cachePolicy=kPFCachePolicyCacheThenNetwork;
    [queryAbs getObjectInBackgroundWithId:@"Tpugk5X6AZ"
     
                                    block:^(PFObject *object, NSError *error){
        if (!error) {
            //succesfully got the object
          
            self.currentWorkout.title=[object objectForKey:@"title"];
            /*self.currentWorkout.level=[NSString stringWithFormat:@"%@", [object objectForKey:@"level"]];
            self.currentWorkout.segment=[NSString stringWithFormat:@"%@", [object objectForKey:@"segment"]];
            self.currentWorkout.objectId=[NSString stringWithFormat:@"%@", [object objectForKey:@"objectId"]];
            self.currentWorkout.location=[NSString stringWithFormat:@"%@",[object objectForKey:@"location"]];
            self.currentWorkout.displayImage=[object objectForKey:@"displayImage"];
            self.currentWorkout.exerciseList=[object objectForKey:@"exerciseList"];*/
            
            NSLog(@"Object is %@ \n %@", [object objectForKey:@"title"], self.currentWorkout.title);
            
            PFFile *imageFile=[object objectForKey:@"displayImage"];
           NSData *data= [imageFile getData];
           
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateMyUIWithResult:object:data];
            });
            
           
           /* PFFile *file=[object objectForKey:@"displayImage"];
            
            NSLog(@"imageFile Test %@", file);
            self.mainImageView.file=file;
            [self.mainImageView loadInBackground];*/
            
        
        }
        else{
            //Error during query process.
            NSLog(@"Error in query: %@", [error localizedDescription]);
        }
           }];
    
}
-(void)updateMyUIWithResult:(PFObject *)object :(NSData*)data{
    
    NSLog(@"updating interface");
   // self.equipmentLabel.text=[object objectForKey:@"title"];
    //self.mainImageView.image=[UIImage imageWithData:data];
    
    //equipment images add here.
    
}



#pragma mark
#pragma mark UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.row==0) {
         cell.textLabel.text=@"WORKOUTS";
    }if (indexPath.row==1) {
        cell.textLabel.text=@"SETS";
    }
    
       return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    //return [NSString stringWithFormat:@"%@", self.currentWorkout.title];
    return @"MENU";
}
#pragma mark
#pragma mark UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [self performSegueWithIdentifier:@"selection" sender:self];
    }else
        [self performSegueWithIdentifier:@"" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"selection"])
    {
        WorkoutSelectionTVC *selectionTVC=(WorkoutSelectionTVC*)[segue destinationViewController];
        selectionTVC.delegate=self;
    }
}
-(void)workoutWasSelectedOnWorkoutSelectionTVC:(WorkoutSelectionTVC *)controller{
    self.currentWorkout=controller.currentWorkout;
    NSLog(@"test %@", self.currentWorkout.title);
    [self.navigationController popViewControllerAnimated:YES];
}





@end
