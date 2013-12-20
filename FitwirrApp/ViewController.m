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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidUnload{
    [super viewDidUnload];
    self.tableView=nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return @"Menu";
}

#pragma mark
#pragma mark UITableView Delegate



- (IBAction)startWorkout:(id)sender {
}
@end
