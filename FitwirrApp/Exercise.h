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
@property (nonatomic, strong) PFImageView *image;


@end
