//
//  RestViewController.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/16/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.6]
#import "RestViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RestCell.h"
#import "Exercise.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define SetUpAudio  @"EndofRest"

@interface RestViewController ()
{
    NSDate *pauseStart;
    NSDate *previousFireDate;
    int seconds;
    AVAudioPlayer *player;
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
    NSLog(@"array check. Current Index  %lu, %@ count %lu",(unsigned long)self.index, self.exerciseArray, (unsigned long)self.exerciseArray.count);
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(endWorkout)];
    self.navigationItem.rightBarButtonItem =backButton;
}
-(void)viewDidDisappear:(BOOL)animated{
    self.timer=nil;
    player=nil;
}
-(void)endWorkout{
    [player stop];
    [self.timer invalidate];
    [self.navigationController popToRootViewControllerAnimated:YES];
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


#pragma mark-Timer
- (IBAction)pausePressed:(id)sender {
    
    if (self.timerPaused == NO) {
        self.timerPaused = YES;
        [self.pauseButton setImage:[UIImage imageNamed:@"play button blue.png"] forState:UIControlStateNormal];
        
        pauseStart=[NSDate dateWithTimeIntervalSinceNow:0];
        previousFireDate=[self.timer fireDate];
        [self.timer setFireDate:[NSDate distantFuture]];
        if (player) {
            [player pause];
        }
        
    }else{
        self.timerPaused=NO;
        [self.pauseButton setImage:[UIImage imageNamed:@"Pause button blue.png"] forState:UIControlStateNormal];
        
        float pauseTime=-1*[pauseStart timeIntervalSinceNow];
        [self.timer setFireDate:[NSDate dateWithTimeInterval:pauseTime sinceDate:previousFireDate]];
        if (player) {
            [player play];
        }
        
    }
}
- (IBAction)timerPressed:(id)sender {
    [self.timer invalidate];
    [player stop];
    [self.delegate restIsUp:self];
}

-(void)timerFireMethods:(NSTimer *)theTimer{
   
    if (seconds >= 0) {
        self.timeDisplay.text = [NSString stringWithFormat:@"%02d:%02d", seconds / 60, seconds % 60];
        seconds--;
    } if (seconds==10) {
        [self timerAndSoundBegins:SetUpAudio loopCount:0];
    }else {
        [self.timer invalidate];
        [self.delegate restIsUp:self];
        [player stop];
    }
}
-(void)beginTimer{
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(timerFireMethods:)
                                              userInfo:nil
                                               repeats:YES];
    seconds = 20;
}
-(void)timerAndSoundBegins:(NSString*)audioFile loopCount:(int)loopCount {
        
        NSString *soundFilePath=[[NSBundle mainBundle]pathForResource:audioFile ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        
        player.numberOfLoops=loopCount;
        [player play];
        
    
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
        cell.label.backgroundColor=UIColorFromRGB(0xa2a2a2);
        cell.checkmarkImage.image=nil;
    }
   
    return cell;
}
@end
