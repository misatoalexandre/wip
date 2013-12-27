//
//  Exercise.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/25/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <Parse/Parse.h>

@interface Exercise : PFObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) PFFile *imageFile;
@property (nonatomic, strong) UIImage *image;
@property NSNumber *time;

@end
