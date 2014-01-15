//
//  FitwirrHelper.m
//  FitwirrApp
//
//  Created by Harry on 1/2/14.
//  Copyright (c) 2014 Misato Tina Alexandre. All rights reserved.
//

#import "FitwirrHelper.h"

@implementation FitwirrIAPHelper

+ (FitwirrIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static FitwirrIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      kAbsHome1, kAbsHome2, kAbsHome3, kAbsHome4,kAbsGym1,kAbsGym2,kButtsHome1,kButtsHome2,kButtsHome3,kButtsHome4,kButtsGym1,kButtsGym2,
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
