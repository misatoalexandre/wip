//
//  Workout.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/23/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Workout : PFObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *segment;
@property (nonatomic, strong) PFFile *displayImage;
@property (nonatomic, copy)   NSArray *exerciseList;


@end
