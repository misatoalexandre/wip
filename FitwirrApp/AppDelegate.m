//
//  AppDelegate.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Exercise.h"
#import <AVFoundation/AVFoundation.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.75]



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    // Override point for customization after application launch.
    [Exercise registerSubclass];
    [Parse setApplicationId:@"lw2iUINQfUEeHU1Op0e2VfsfqsIxVBT6XSfdvROK"
                  clientKey:@"lZy4eOunpCf2or3800244r2wBqETSi7OUQJCmI3J"];
   
    
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //page view controller setup
    /*UIPageControl *pageControl=[UIPageControl appearance];
    pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor=[UIColor blackColor];
    pageControl.backgroundColor=[UIColor clearColor];*/
    
//    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
//    
//    [dict setObject:(__bridge id) kSecClassGenericPassword  forKey:(__bridge id) kSecClass];
//    [dict setObject:kYourUpgradeStateKey           forKey:(id)kSecAttrService];
//    [dict setObject:kYourUpgradeStateValue         forKey:(id)kSecValueData];
//    
//    SecItemAdd ((__bridge CFDictionaryRef)dict, NULL);
    
     //Nav Bar Customization
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x191919)];

   
    
    
  // [[UINavigationBar appearance] setTintColor:[UIColor lightGrayColor]];
    
   // NSShadow *shadow = [[NSShadow alloc] init];
   // shadow.shadowColor = [UIColor blackColor];
    //shadow.shadowOffset = CGSizeMake(0, 0.5);
   /* [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           UIColorFromRGB(0xFFFFCC), NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"Gujarati Sangam MN " size:21.0], NSFontAttributeName, nil]]; */
    //Conscent Alert first time launching
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (! [defaults boolForKey:@"notFirstRun"]) {
        // display alert...
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Use of App Policy" message:@"CONSCENT \n I have my physician’s permission to engage in fitness activities and use Fitwirr at my own risk." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [defaults setBool:YES forKey:@"notFirstRun"];
    }
    

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
