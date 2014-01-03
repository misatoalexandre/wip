//
//  SelectWorkoutTVCViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/29/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "SelectWorkoutTVCViewController.h"
#import "FitwirrHelper.h"

@interface SelectWorkoutTVCViewController ()
{
    NSMutableArray *_absProducts;
    NSMutableArray *_buttsProducts;
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
    
    [self reload];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)sectionFromString:(NSString *)identifier
{
    if([identifier rangeOfString:@"1"].location != NSNotFound)
        return 0;
    if([identifier rangeOfString:@"2"].location != NSNotFound)
        return 1;
//    if([identifier rangeOfString:@"3"].location != NSNotFound)
        return 2;
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    
    [_absProducts enumerateObjectsUsingBlock:^(SKProduct *product, NSUInteger idx, BOOL *stop) {
        if([product.productIdentifier isEqualToString:productIdentifier])
        {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[self sectionFromString:product.productIdentifier]] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
    [_buttsProducts enumerateObjectsUsingBlock:^(SKProduct *product, NSUInteger idx, BOOL *stop) {
        if([product.productIdentifier isEqualToString:productIdentifier])
        {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[self sectionFromString:product.productIdentifier]] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
    
//    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
//        if ([product.productIdentifier isEqualToString:productIdentifier]) {
//            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//            *stop = YES;
//        }
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reload {
    _absProducts = nil;
    _buttsProducts = nil;
    [self.tableView reloadData];
    [[FitwirrIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _absProducts = [NSMutableArray array];
            _buttsProducts = [NSMutableArray array];
            for(SKProduct *product in products)
            {
                if([product.productIdentifier rangeOfString:@"abs"].location != NSNotFound)
                {
                    [_absProducts addObject:product];
                } else {
                    [_buttsProducts addObject:product];
                }
            }
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_absProducts == nil)
        return 0;
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *products = nil;
    if(_segmentedControl.selectedSegmentIndex == 0)
        products = _absProducts;
    else
        products = _buttsProducts;
    if(products == nil)
        return 0;
    int numRows = 0;
    for(SKProduct *product in products)
    {
        if([[product productIdentifier] rangeOfString:[NSString stringWithFormat:@"%d", (int)(section + 1)]].location != NSNotFound)
        {
            if([[FitwirrIAPHelper sharedInstance] productPurchased:product.productIdentifier])
                numRows += 5;
            else
                numRows++;
        }
    }
    if(section == 0)
        numRows++; // Free Workout
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *products = nil;
    if(_segmentedControl.selectedSegmentIndex == 0)
        products = _absProducts;
    else
        products = _buttsProducts;
    
    SKProduct *homeProduct, *gymProduct;
    for(SKProduct *product in products)
    {
        if([product.productIdentifier rangeOfString:[NSString stringWithFormat:@"%d", (int)(indexPath.section + 1)]].location != NSNotFound)
        {
            if([product.productIdentifier rangeOfString:@"Home"].location != NSNotFound)
                homeProduct = product;
            else
                gymProduct = product;
        }
    }
    int freeRow = 1;
    if(indexPath.section == 0) // Have to include Free Row
        freeRow = 0;
//    [cell setValue:nil forKey:@"product"];
    if(freeRow == 0 && indexPath.row == 0)
    {
        cell.textLabel.text = @"Free Home Workout";
        cell.detailTextLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if([[FitwirrIAPHelper sharedInstance] productPurchased:homeProduct.productIdentifier])
    {
        if(indexPath.row < 6 - freeRow)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"Home Workout %d", (int)indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.detailTextLabel.text = @"";
        } else {
            if([[FitwirrIAPHelper sharedInstance] productPurchased:gymProduct.productIdentifier])
            {
                cell.textLabel.text = [NSString stringWithFormat:@"Gym Workout %d", (int)indexPath.row - (5 - freeRow)];
                cell.detailTextLabel.text = @"";
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                [_priceFormatter setLocale:gymProduct.priceLocale];
                cell.detailTextLabel.text = [_priceFormatter stringFromNumber:gymProduct.price];
                cell.textLabel.text = @"Gym Workouts";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    } else {
        if(indexPath.row == (1 - freeRow))
        {
            cell.textLabel.text = @"Home Workouts";
            [_priceFormatter setLocale:homeProduct.priceLocale];
            cell.detailTextLabel.text = [_priceFormatter stringFromNumber:homeProduct.price];
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            if([[FitwirrIAPHelper sharedInstance] productPurchased:gymProduct.productIdentifier])
            {
                cell.textLabel.text = [NSString stringWithFormat:@"Gym Workout %d", (int)indexPath.row - (1 - freeRow)];
                cell.detailTextLabel.text = @"";
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                [_priceFormatter setLocale:gymProduct.priceLocale];
                cell.detailTextLabel.text = [_priceFormatter stringFromNumber:gymProduct.price];
                cell.textLabel.text = @"Gym Workouts";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Level %d", (int)(section + 1)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType == UITableViewCellAccessoryNone)
    {
        NSArray *products = nil;
        if(_segmentedControl.selectedSegmentIndex == 0)
            products = _absProducts;
        else
            products = _buttsProducts;
        SKProduct *homeProduct, *gymProduct, *productToBuy;
        for(SKProduct *product in products)
        {
            if([product.productIdentifier rangeOfString:[NSString stringWithFormat:@"%d", (int)(indexPath.section + 1)]].location != NSNotFound)
            {
                if([product.productIdentifier rangeOfString:@"Home"].location != NSNotFound)
                    homeProduct = product;
                else
                    gymProduct = product;
            }
        }
        if([cell.textLabel.text rangeOfString:@"Home"].location != NSNotFound)
            productToBuy = homeProduct;
        else
            productToBuy = gymProduct;
        [[FitwirrIAPHelper sharedInstance] buyProduct:productToBuy];
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
