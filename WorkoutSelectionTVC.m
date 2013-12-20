//
//  WorkoutSelectionTVC.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/20/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "WorkoutSelectionTVC.h"

@interface WorkoutSelectionTVC (){
    NSArray *abWorkoutArrayPrePurchase;
    NSArray *abWorkoutArrayPostPurchase;
    NSArray *buttWorkoutArrayPrePurchase;
    NSArray *buttWorkoutArrayPostPurchase;
}

@end

@implementation WorkoutSelectionTVC

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
     abWorkoutArrayPostPurchase=[[NSArray alloc]initWithObjects:@"Free",@"Abs 1", @"Abs 2", @"Abs 3", nil];
    buttWorkoutArrayPrePurchase=[[NSArray alloc]initWithObjects:@"Free",@"Butts 1", nil];
    [self.segmentedControl addTarget:self action:@selector(onSegmentedControlChanged) forControlEvents:UIControlEventValueChanged];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentedControl.selectedSegmentIndex==0) {
        return abWorkoutArrayPostPurchase.count;
    }else
        return buttWorkoutArrayPrePurchase.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (self.segmentedControl.selectedSegmentIndex==0) {
        cell.textLabel.text=[abWorkoutArrayPostPurchase objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text=[buttWorkoutArrayPrePurchase objectAtIndex:indexPath.row];
    }
    
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.segmentedControl.selectedSegmentIndex==0) {
        return @"Lean Abs Workouts";
    }
    else if (self.segmentedControl.selectedSegmentIndex==1){
        return @"Firm Butts Workouts";
    }
    else{
        return @"Error";
    }

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
