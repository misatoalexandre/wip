//
//  ViewController.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import "WorkoutSelectionTVC.h"

@interface ViewController : UIViewController <WorkoutSelectionDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) Workout *currentWorkout;
@property (weak, nonatomic) IBOutlet PFImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *firstEquipmentView;
@property (weak, nonatomic) IBOutlet UIImageView *secondEquipmentView;
@property (weak, nonatomic) IBOutlet UILabel *equipmentLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;






@end
