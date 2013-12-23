//
//  RestViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/16/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.5]
#import "RestViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RestCell.h"

@interface RestViewController ()

@end

@implementation RestViewController

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
	// Do any additional setup after loading the view.
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UICollectionView Data Source
-(NSInteger) numberofSelectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"Cell";
    
    //Add Custom Cell here
    RestCell *cell=(RestCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //Configure the cell
    /*PFObject *exercise=[self.workout.exerciseList objectAtIndex:indexPath.row];
     PFFile *imageFile=[exercise objectForKey:@"image"];
     UIImage *image=[UIImage imageWithData:[imageFile getData]];*/
    
    cell.imageView.layer.cornerRadius=25.0;
    cell.imageView.layer.masksToBounds=YES;
    cell.imageView.image=[UIImage imageNamed:@"OverheadDumbbellSquat.jpg"];

    if (indexPath.row==0) {
        cell.label.backgroundColor=UIColorFromRGB(0xffcc66);
        cell.label.text=@"1";
        cell.label.layer.cornerRadius=25.0;
        cell.label.layer.masksToBounds=YES;
        
    } else if (indexPath.row==1){
         cell.label.backgroundColor=[UIColor clearColor];
        cell.checkmarkImage.image=nil;
    }
    else{
        cell.label.layer.cornerRadius=25.0;
        cell.label.layer.masksToBounds=YES;
        cell.label.backgroundColor=UIColorFromRGB(0x000000);
        cell.checkmarkImage.image=nil;
    }
   
    
        //cell.imageView.image=[UIImage imageWithData:[imageFile getData]];
    
    return cell;
}




@end
