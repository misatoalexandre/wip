//
//  FitwirrHelper.h
//  FitwirrApp
//
//  Created by Harry on 1/2/14.
//  Copyright (c) 2014 Misato Tina Alexandre. All rights reserved.
//

#import "IAPHelper.h"

// In-App Purchase Ids
#define kAbsHome1   @"com.misato.AbsHome1.5SecretMovestoaCelebBody"
#define kAbsHome2   @"com.misato.AbsHome1.Beginners5MustMovesToFlatStomach"
#define kAbsHome3   @"com.misato.AbsHome3.BusyMomsSecretMovestoBeachBody"
#define kAbsHome4   @"com.misato.AbsHome4.NoEquipmentsNoMythsJustSexyAbs"
#define kAbsGym1    @"com.misato.AbsGym1.WorkOutLikeASuperModel"
#define kAbsGym2    @"com.misato.AbsGym2.BeachBodyWorkout"

#define kButtsHome1   @"com.misato.buttsHome1.LoseWeightSlimYourBottomNoEquipments"
#define kButtsHome2   @"com.misato.buttsHome2.CelebBootyWorkout"
#define kButtsHome3   @"com.misato.buttsHome3.ButtBlastingWorkoutforBeginner"
#define kButtsHome4   @"com.misato.buttsHome4.5MovestoTrimYourThighs"
#define kButtsGym1    @"com.misato.buttsGym1.ToningandCelluliteBustingWorkout"
#define kButtsGym2    @"com.misato.buttsGym2.ButtShapingWorkout"

#define kAbsProductsId      @[kAbsHome1, kAbsHome2, kAbsHome3, kAbsHome4, kAbsGym1, kAbsGym2]

#define kButtsProductsId    @[kButtsHome1, kButtsHome2, kButtsHome3, kButtsHome4, kButtsGym1, kButtsGym2]

#define kAbsObjectsId       @[@"FFeqomDTID", @"9cSyKgOGbK", @"zuTGCkvgHQ", @"JkdxP9svci", @"bFWHQQgw89", @"I7LWnnrTpt"]

#define kButtsObjectsId     @[@"wmpDYvJ1qz", @"BHABCBEreh", @"s2yULiLlAF", @"txcmcN7pWI", @"LlUFF7ZVct", @"wFN6F7czoh"]

#define kFreeAbsWorkoutId   @"PIp9N5a5Zk"
#define kFreeButtsWorkoutId @"BSGoaeZrZt"

@interface FitwirrIAPHelper : IAPHelper

+ (FitwirrIAPHelper *)sharedInstance;

@end
