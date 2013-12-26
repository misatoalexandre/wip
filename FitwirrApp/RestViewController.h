//
//  RestViewController.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/16/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface RestViewController : UIViewController
@property (nonatomic, strong) NSArray *exerciseArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSUInteger index;
@property (weak, nonatomic) IBOutlet PFImageView *nextExerciseImage;
@property (weak, nonatomic) IBOutlet UIButton *nextExerciseTitlteLabel;
@end
