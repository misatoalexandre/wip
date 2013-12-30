//
//  EndPageVC.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/27/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "EndPageVC.h"

@interface EndPageVC ()

@end

@implementation EndPageVC

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
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(initializeBackButton)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *shareButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showShare)];
    self.navigationItem.rightBarButtonItem =shareButton;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initializeBackButton{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)showShare{
    NSString *title= [NSString stringWithFormat:@"Just finished my Fitwirr workout. I feel great! \n Check them out at www.fitwirr.com"];
    UIImage *icon=[UIImage imageNamed:@"FitwirrIcon120.png"];
    
    
    NSMutableArray *activitiesItem=[[NSMutableArray alloc]initWithObjects:title, icon,nil];
    
    UIActivityViewController *avc=[[UIActivityViewController alloc]initWithActivityItems:activitiesItem applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
    
    title=nil;
    icon=nil;
    activitiesItem=nil;
    avc=nil;

}


@end
