//
//  SelectWorkoutTVCViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/29/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "SelectWorkoutTVCViewController.h"
#import "FitwirrHelper.h"
#import "WorkoutCell.h"
#import <Parse/Parse.h>

@interface SelectWorkoutTVCViewController ()
{
    NSMutableArray *_absProducts, *_buttsProducts;          // [{"product":SKProduct, "object":PFObject},...]

    NSNumberFormatter * _priceFormatter;
}
@end

@implementation SelectWorkoutTVCViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    [self performSelectorInBackground:@selector(reload) withObject:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    
    for(int i = 0; i < _absProducts.count; i++)
    {
        NSDictionary *data = _absProducts[i];
        if([((SKProduct *)data[@"product"]).productIdentifier isEqualToString:productIdentifier])
        {
            if(_segmentedControl.selectedSegmentIndex == 0)
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i + 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            return;
        }
    }
    
    for(int i = 0; i < _buttsProducts.count; i++)
    {
        NSDictionary *data = _buttsProducts[i];
        if([((SKProduct *)data[@"product"]).productIdentifier isEqualToString:productIdentifier])
        {
            if(_segmentedControl.selectedSegmentIndex == 1)
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i + 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            return;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reload {
    _absProducts = nil;
    _buttsProducts = nil;
    
    PFQuery *query = [PFQuery queryWithClassName:@"WorkoutPlans"];
    NSArray *workouts = [query findObjects];
    
    [[FitwirrIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _absProducts = [NSMutableArray array];
            _buttsProducts = [NSMutableArray array];
            for(NSDictionary *v in kAbsProductsId)
                [_absProducts addObject:[NSMutableDictionary dictionary]];
            for(NSDictionary *v in kAbsProductsId)
                [_buttsProducts addObject:[NSMutableDictionary dictionary]];
            for(SKProduct *product in products)
            {
                if([kAbsProductsId indexOfObject:product.productIdentifier] != NSNotFound)
                {
                    NSMutableDictionary *data = [_absProducts objectAtIndex:[kAbsProductsId  indexOfObject:product.productIdentifier]];
                    [data setObject:product forKey:@"product"];
                } else {
                    NSMutableDictionary *data = [_buttsProducts objectAtIndex:[kButtsProductsId indexOfObject:product.productIdentifier]];
                    [data setObject:product forKey:@"product"];
                }
            }
            
            for(PFObject *obj in workouts)
            {
                if([obj.objectId isEqualToString:kFreeAbsWorkoutId] || [obj.objectId isEqualToString:kFreeButtsWorkoutId])
                    continue;
                if([kAbsObjectsId indexOfObject:obj.objectId] != NSNotFound)
                {
                    NSMutableDictionary *data = [_absProducts objectAtIndex:[kAbsObjectsId indexOfObject:obj.objectId]];
                    [data setObject:obj forKey:@"object"];
                } else {
                    NSMutableDictionary *data = [_buttsProducts objectAtIndex:[kButtsObjectsId indexOfObject:obj.objectId]];
                    [data setObject:obj forKey:@"object"];
                }
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            });
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *products = nil;
    if(_segmentedControl.selectedSegmentIndex == 0)
        products = _absProducts;
    else
        products = _buttsProducts;
    if(products == nil)
        return 1;
    NSInteger numRows = [products count];
    
    numRows++; // Free Workout
    
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    WorkoutCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[WorkoutCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.priceLabel.text = @"";
    NSArray *products = nil;
    if(_segmentedControl.selectedSegmentIndex == 0)
        products = _absProducts;
    else
        products = _buttsProducts;
    
    if(products == nil) // Refreshing
    {
        cell.mainLabel.text = @"";
        cell.detailLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryNone;
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicator startAnimating];
        activityIndicator.center = CGPointMake(cell.bounds.size.width / 2, cell.bounds.size.height / 2);
//        activityIndicator.hidesWhenStopped = YES;
        [cell addSubview:activityIndicator];
        return cell;
    }
    
    if(indexPath.row == 0)
    {
        if(_segmentedControl.selectedSegmentIndex == 0) // Abs
        {
            cell.mainLabel.text = @"Free Workout Plan for Perfect Abs";
            cell.detailLabel.text = @"Dumbbells and Box (Elevated Surface)";
        } else {
            cell.mainLabel.text = @"Free Workout for Sexy Butts";
            cell.detailLabel.text = @"Dumbbells and Jump Rope";
        }
    } else {
    
        NSDictionary *data = [products objectAtIndex:indexPath.row - 1];
        if([[FitwirrIAPHelper sharedInstance] productPurchased:[data[@"product"] productIdentifier]])
        {
            cell.mainLabel.text = [data[@"product"] localizedTitle];
            cell.detailLabel.text = [data[@"product"] localizedDescription];
        } else {
            cell.mainLabel.text = [data[@"product"] localizedTitle];
            cell.detailLabel    .text = [data[@"product"] localizedDescription];
            [_priceFormatter setLocale:[data[@"product"] priceLocale]];
            cell.priceLabel.text = [_priceFormatter stringFromNumber:[data[@"product"] price]];
        }
    }
    
    [cell setNeedsLayout];
    
    if(indexPath.row == _selectedRow && _segmentedControl.selectedSegmentIndex == _selectedSegment)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!_absProducts || !_buttsProducts)
        return NO;
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkoutCell *cell = (WorkoutCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSArray *products = nil;
    if(_segmentedControl.selectedSegmentIndex == 0)
        products = _absProducts;
    else
        products = _buttsProducts;
    if(![cell.priceLabel.text isEqualToString:@""])
    {
        SKProduct *productToBuy = products[indexPath.row - 1][@"product"];
        [[FitwirrIAPHelper sharedInstance] buyProduct:productToBuy];
    } else {
        if(_delegate != nil && [_delegate respondsToSelector:@selector(workoutSelected:)])
        {
            NSString *segment;
            if(_segmentedControl.selectedSegmentIndex == 0)
                segment = @"Abs";
            else
                segment = @"Butts";
            
            [_delegate setWorkoutIndexPath:@{@"row": [NSNumber numberWithInteger:indexPath.row], @"segment":[NSNumber numberWithInteger:_segmentedControl.selectedSegmentIndex]}];
            if(indexPath.row == 0)
            {
                if(_segmentedControl.selectedSegmentIndex == 0)
                    [_delegate workoutSelected:kFreeAbsWorkoutId];
                else
                    [_delegate workoutSelected:kFreeButtsWorkoutId];
            } else {
                PFObject *object = products[indexPath.row - 1][@"object"];
                NSString *workoutID = object.objectId;
                [_delegate workoutSelected:workoutID];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
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

- (IBAction)selectSegment:(id)sender {
    [self.tableView reloadData];
}
@end
