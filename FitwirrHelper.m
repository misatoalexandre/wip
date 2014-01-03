//
//  FitwirrHelper.m
//  FitwirrApp
//
//  Created by Harry on 1/2/14.
//  Copyright (c) 2014 Misato Tina Alexandre. All rights reserved.
//

#import "FitwirrHelper.h"

@implementation FitwirrIAPHelper

#define kAbsGymLevel1       @"com.misato.absGymLevel1"
#define kAbsGymLevel2       @"com.misato.absGymLevel2"
#define kAbsGymLevel3       @"com.misato.absGymLevel3"
#define kAbsHomeLevel1      @"com.misato.absHomeLevel1"
#define kAbsHomeLevel2      @"com.misato.absHomeLevel2"
#define kAbsHomeLevel3      @"com.misato.absHomeLevel3"
#define kButtsGymLevel1     @"com.misato.buttsGymLevel1"
#define kButtsGymLevel2     @"com.misato.buttsGymLevel2"
#define kButtsGymLevel3     @"com.misato.buttsGymLevel3"
#define kButtsHomeLevel1    @"com.misato.buttsHomeLevel1"
#define kButtsHomeLevel2    @"com.misato.buttsHomeLevel2"
#define kButtsHomeLevel3    @"com.misato.buttsHomeLevel3"

+ (FitwirrIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static FitwirrIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      kAbsGymLevel1, kAbsGymLevel2, kAbsGymLevel3, kAbsHomeLevel1, kAbsHomeLevel2, kAbsHomeLevel3, kButtsGymLevel1, kButtsGymLevel2, kButtsGymLevel3, kButtsHomeLevel1, kButtsHomeLevel2, kButtsHomeLevel3,
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}


@end
