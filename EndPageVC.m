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
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@"< MENU " style:UIBarButtonItemStyleBordered target:self action:@selector(initializeBackButton)];
    UIBarButtonItem *shareButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(showShare)];
    self.navigationItem.leftBarButtonItem = backButton;
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
    NSLog(@"");
}


@end
