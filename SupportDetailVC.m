//
//  SupportDetailVC.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 1/20/14.
//  Copyright (c) 2014 Misato Tina Alexandre. All rights reserved.
//

#import "SupportDetailVC.h"

@interface SupportDetailVC ()

@end

@implementation SupportDetailVC

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
    if (self.terms) {
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Disclaimer" message:@"Exercises and workout plans in this app are developed by a qualified fitness professional. \n We highly recommend and advise that you consult a physician before beginning any exercise program including exercises and workouts in this app.\n The content in this app is in no way intended to substitute any exercise routine that may have been prescribed by your medical practitioner. \n All exercises and workouts are done at your own risk. Know your limits and train safely." delegate:nil cancelButtonTitle:@"Agree. See Terms of Use." otherButtonTitles:nil, nil];
        [view show];
    }
	// Do any additional setup after loading the view.
    self.webView.delegate=self;
    NSURL *url=[NSURL URLWithString:self.uRLstring];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}
-(void)dealloc{
    self.webView=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
