//
//  LaunchTVC.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/24/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetsTVC.h"

@interface LaunchTVC : UITableViewController<SetsTVCDelegate>
@property (nonatomic, strong)NSString *selectedSets;
@property (weak, nonatomic) IBOutlet UILabel *selectedSetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedWorkoutLabel;
@property(nonatomic,readwrite)int selectedCell;

@end
