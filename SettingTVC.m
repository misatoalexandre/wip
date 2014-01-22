//
//  SettingTVC.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/30/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "SettingTVC.h"
#import "SupportDetailVC.h"

@interface SettingTVC ()

@end

@implementation SettingTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SupportDetailVC *sdVC=(SupportDetailVC *)[segue destinationViewController];
    if ([segue.identifier isEqualToString:@"privacy"]) {
        sdVC.terms=NO;
        sdVC.uRLstring=@"http://www.fitwirr.com/privacy";
        sdVC.title=@"Privacy Policy";
    }
    if ([segue.identifier isEqualToString:@"terms"]) {
        sdVC.uRLstring=@"http://www.fitwirr.com/terms_app";
        sdVC.terms=YES;
        sdVC.title=@"Disclaimer/Terms of Service";
        
    }
    if ([segue.identifier isEqualToString:@"about"]) {
        sdVC.uRLstring=@"http://www.fitwirr.com/about";
        sdVC.terms=NO;
        sdVC.title=@"About Fitwirr";
    }
   
    
}
-(void)share{
    NSLog(@"Share");
    NSString *appName=@"Ab & Butt Workout App for Women by Fitwirr. \n http://www.fitwirr.com";
    
    UIImage *icon=[UIImage imageNamed:@"FitwirrIcon120.png"];
    
    
    NSMutableArray *activitiesItem=[[NSMutableArray alloc]initWithObjects:appName, icon,nil];
    
    UIActivityViewController *avc=[[UIActivityViewController alloc]initWithActivityItems:activitiesItem applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
    
    appName=nil;
    icon=nil;
    activitiesItem=nil;
    avc=nil;

    
}
-(void)contact{
    NSLog(@"contact");
    //NSString *toEmailAddress=@"misato@fitwirr.com";
    NSString *emailTitle=@"Re: About your Ab & Butt Workouts for Women App";
    NSString *emailBody=[NSString
                         stringWithFormat:@"App Version: 1.01 \n OS Version: %@ %@ \n Mode: %@",[[UIDevice currentDevice]systemName], [[UIDevice currentDevice]systemVersion], [[UIDevice currentDevice]model]];
                         // NSString *appVersion=@"App Version: 1.01";
                         //NSString *osVersion=[NSString stringWithFormat:@"OS Version: %@ %@",[[UIDevice currentDevice]systemName], [[UIDevice currentDevice]systemVersion]];
                         //NSString *model=[NSString stringWithFormat:@"Mode: %@",[[UIDevice currentDevice]model]];
    NSArray *toRecipents=[NSArray arrayWithObjects:@"misato@fitwirr.com", nil];
                         
    MFMailComposeViewController *mc=[[MFMailComposeViewController alloc]init];
    mc.mailComposeDelegate=self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:emailBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    [self presentViewController:mc animated:YES completion:nil];
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"mail cancelled.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"mail saved.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"mail sent.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"mail sent failure: %@",[error localizedDescription]);
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell==self.shareCell) {
        [self share];
    }
    if (cell==self.contactCell) {
        [self contact];
    }
}
@end
