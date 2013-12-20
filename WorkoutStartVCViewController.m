//
//  WorkoutStartVCViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/16/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//


#import "WorkoutStartVCViewController.h"
#import "ExerciseListCell.h"
#import <QuartzCore/QuartzCore.h>
#import "WorkoutStepVC.h"
@interface WorkoutStartVCViewController ()

@end

@implementation WorkoutStartVCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=YES;
    [self.collectionView reloadData];
    self.exerciseArray=[[NSArray alloc]initWithObjects:@"easelly_visual (8).jpg",@"easelly_visual (7).jpg",@"BoxJump.jpg",@"BENCHSIDEPLANK.jpg",@"CROSSEDARMCRUNCH.jpg",nil];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    WorkoutStepVC *workoutStepVC=(WorkoutStepVC *)segue.destinationViewController;
    workoutStepVC.exerciseArray=self.exerciseArray;
}
#pragma mark-UICollectionView Data Source
-(NSInteger) numberofSelectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.exerciseArray.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"Cell";
    
    //Add Custom Cell here
    ExerciseListCell *cell=(ExerciseListCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //Configure the cell
    /*PFObject *exercise=[self.workout.exerciseList objectAtIndex:indexPath.row];
    PFFile *imageFile=[exercise objectForKey:@"image"];
    UIImage *image=[UIImage imageWithData:[imageFile getData]];*/
    cell.imageView.layer.cornerRadius=25.0;
    cell.imageView.layer.masksToBounds=YES;
    cell.imageView.image=[UIImage imageNamed:[self.exerciseArray objectAtIndex:indexPath.row]];
    //cell.imageView.image=[UIImage imageWithData:[imageFile getData]];
    
    return cell;
}

@end
