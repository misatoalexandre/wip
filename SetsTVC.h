//
//  SetsTVC.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/24/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetsTVCDelegate;

@interface SetsTVC : UITableViewController
@property (nonatomic, strong) NSString *selectedSets;
@property (nonatomic, weak) id<SetsTVCDelegate>delegate;
@property(nonatomic,readwrite)int selectedCell;

@end

@protocol SetsTVCDelegate

-(void)setsSelected:(SetsTVC *)controller;

@end