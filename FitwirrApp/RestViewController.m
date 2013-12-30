//
//  RestViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/16/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.4]
#import "RestViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RestCell.h"
#import "Exercise.h"


@interface RestViewController ()
{
    NSDate *pauseStart;
    NSDate *previousFireDate;
    int seconds;
}

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
    [self beginTimer];
    [self displayNextExerciseInLarge:self.index];
    self.setsLabel.text=[NSString stringWithFormat:@"%d / %d sets", self.currentSet, self.setsCount];
    self.nextExerciseTitleLabel.text=[NSString stringWithFormat:@"NEXT: %@",[[self.exerciseArray objectAtIndex:self.index]objectForKey:@"name"]];
    
    
    [self.collectionView reloadData];
    NSLog(@"array check. Current Index  %lu, %@ count %lu",(unsigned long)self.index, self.exerciseArray, self.exerciseArray.count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)displayNextExerciseInLarge:(NSInteger)index{
   
    self.nextExerciseImage.file=[[self.exerciseArray objectAtIndex:index]objectForKey:@"image"];
    [self.nextExerciseImage loadInBackground];
}
- (IBAction)timerPressed:(id)sender {
    [self.delegate restIsUp:self];
}


#pragma mark-Timer
- (IBAction)pausePressed:(id)sender {
    
    if (self.timerPaused==NO) {
        self.timerPaused=YES;
        [self.pauseButton setImage:[UIImage imageNamed:@"play button blue.png"] forState:UIControlStateNormal];
       // [self.timerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
       // [self.timerButton setTitle:@"Paused" forState:UIControlStateNormal];
        
        pauseStart=[NSDate dateWithTimeIntervalSinceNow:0];
        previousFireDate=[self.timer fireDate];
        [self.timer setFireDate:[NSDate distantFuture]];
                
    }else{
        self.timerPaused=NO;
        [self.pauseButton setImage:[UIImage imageNamed:@"Pause button blue.png"] forState:UIControlStateNormal];
        
        float pauseTime=-1*[pauseStart timeIntervalSinceNow];
        [self.timer setFireDate:[NSDate dateWithTimeInterval:pauseTime sinceDate:previousFireDate]];
        
    }
    
}
-(void)timerFireMethods:(NSTimer *)theTimer{
    
    
    if (seconds>=10) {
        self.timeDisplay.text=[NSString stringWithFormat:@"00:%d",seconds];
        seconds--;
    } else if (seconds>=0){
        self.timeDisplay.text=[NSString
                                          stringWithFormat:@"00:0%d",seconds];
        seconds--;
    }else{
        [self.timer invalidate];
        [self.delegate restIsUp:self];
    }
}
-(void)beginTimer{
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(timerFireMethods:)
                                              userInfo:nil
                                               repeats:YES];
    seconds=20;
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
    RestCell *cell=(RestCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //Configure the cell
   
    cell.imageView.layer.cornerRadius=25.0;
    cell.imageView.layer.masksToBounds=YES;
    
    cell.imageView.file=[[self.exerciseArray objectAtIndex:indexPath.row]objectForKey:@"image"];
    [cell.imageView loadInBackground];

   
    if (indexPath.row<self.index) {
        cell.label.backgroundColor=UIColorFromRGB(0xffcc66);
        cell.label.text=@"1";
        cell.label.layer.cornerRadius=25.0;
        cell.label.layer.masksToBounds=YES;
        
    } else if (indexPath.row==self.index){
         cell.label.backgroundColor=[UIColor clearColor];
        cell.checkmarkImage.image=nil;
    }
    else{
        cell.label.layer.cornerRadius=25.0;
        cell.label.layer.masksToBounds=YES;
        cell.label.backgroundColor=UIColorFromRGB(0x000000);
        cell.checkmarkImage.image=nil;
    }
   
    return cell;
}
@end
