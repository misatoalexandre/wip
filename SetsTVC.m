//
//  SetsTVC.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/24/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "SetsTVC.h"

@interface SetsTVC ()

@end

@implementation SetsTVC{
    
    NSMutableArray *setsArray;
    NSMutableArray *minsbySet;
    
}

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
    
    //Initiate and load setsArray
    setsArray=[[NSMutableArray alloc]init];
    minsbySet=[[NSMutableArray alloc]init];
   
    for (int x=1; x<=4; x++) {
        
        NSString *string=[NSString stringWithFormat:@"%d", 15 *x];
        NSString *set=[NSString stringWithFormat:@"%d",x];
        
        [setsArray addObject:set];
        [minsbySet addObject:string];
       
       
    }
    
    [self.tableView reloadData];
    
       // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    // Return the number of rows in the section.
    return setsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.row==self.selectedCell) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        cell.selected=YES;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selected=NO;
    }
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@ mins",[minsbySet objectAtIndex:indexPath.row]];
    
    if (indexPath.row==0) {
        cell.textLabel.text=[NSString stringWithFormat:@"%@ set",[setsArray objectAtIndex:indexPath.row]];
    }else
    cell.textLabel.text=[NSString stringWithFormat:@"%@ sets",[setsArray objectAtIndex:indexPath.row]];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"SETS                                           APPX. TIME";
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCell=indexPath.row;
    self.selectedSets=[setsArray objectAtIndex:indexPath.row];
    
    
    [self.tableView reloadData];
    [self.delegate setsSelected:self];
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
