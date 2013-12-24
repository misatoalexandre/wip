//
//  ExerciseViewController.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/21/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImage;
@property (weak, nonatomic) IBOutlet UIButton *timerButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

- (IBAction)timerPausePlay:(id)sender;
- (IBAction)nextPressed:(id)sender;
- (IBAction)previousPressed:(id)sender;


@end
