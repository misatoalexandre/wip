//
//  Exercise.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/25/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "Exercise.h"
#import <Parse/PFObject+Subclass.h>

@implementation Exercise
@synthesize name, time, imageFile, repeat, goal ;

+ (NSString *)parseClassName
{
    return @"Exercise";
}


@end
