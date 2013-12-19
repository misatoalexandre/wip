//
//  PurchaseVC.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>


@interface PurchaseVC : UIViewController<SKProductsRequestDelegate, SKPaymentTransactionObserver>{
    SKProductsRequest *productsRequest;
    NSArray *validProducts;
    UIActivityIndicatorView *activityIndicatorView;
}

@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabe;
@property (weak, nonatomic) IBOutlet UILabel *productDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *purchaseButton;

- (IBAction)purchase:(id)sender;

-(void)fetchAvailableProducts;
-(BOOL)canMakePurchase;
-(void)purchaseMyProduct:(SKProduct *)product;
@end
