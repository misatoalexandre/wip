//
//  RestViewController.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/16/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Exercise.h"


@protocol RestVCDelegate;

@interface RestViewController : UIViewController
@property (nonatomic, strong) NSArray *exerciseArray;
@property (nonatomic, strong)Exercise *exercise;
@property NSUInteger index;

@property (weak, nonatomic) id<RestVCDelegate>delegate;
@property int currentSet;
@property int setsCount;

//UI Elements
@property (weak, nonatomic) IBOutlet UILabel *setsLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextExerciseTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDisplay;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet PFImageView *nextExerciseImage;
@property (weak, nonatomic) IBOutlet UIButton *nextExerciseTitlteLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;


//Timer related
@property (nonatomic, strong) NSTimer *timer;
@property BOOL timerPaused;


- (IBAction)timerPressed:(id)sender;
- (IBAction)pausePressed:(id)sender;

@end

@protocol RestVCDelegate

-(void)restIsUp:(RestViewController*)controller;

@end