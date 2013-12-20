//
//  ViewController.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)startWorkout:(id)sender;
@end
