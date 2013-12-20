//
//  WorkoutSelectionTVC.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/20/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutSelectionTVC : UITableViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
-(void)onSegmentedControlChanged;
@end
