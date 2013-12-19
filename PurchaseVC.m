//
//  PurchaseVC.m
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "PurchaseVC.h"
#define KUpgradeProductID @"com.misato.AbWorkoutUpgrade"

@interface PurchaseVC ()

@end

@implementation PurchaseVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    activityIndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center=self.view.center;
    [activityIndicatorView hidesWhenStopped];
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    //hides purchase button intially
    self.purchaseButton.hidden=YES;
    [self fetchAvailableProducts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fetchAvailableProducts{
    NSSet *productIdentitfiers=[NSSet setWithObjects: KUpgradeProductID,nil];
    productsRequest=[[SKProductsRequest alloc]initWithProductIdentifiers:productIdentitfiers];
    productsRequest.delegate=self;
    [productsRequest start];
}
-(BOOL)canMakePurchase{
    return [SKPaymentQueue canMakePayments];
}
-(void)purchaseMyProduct:(SKProduct *)product{
    if ([self canMakePurchase]) {
        SKPayment *payment=[SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue]addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue]addPayment:payment];
    } else{
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Purchases are disabled in your device" message:@"nil" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [view show];
    }
}

- (IBAction)purchase:(id)sender {
    [self purchaseMyProduct:[validProducts objectAtIndex:0]];
    self.purchaseButton.enabled=NO;
}

#pragma mark-
#pragma mark StoreKit Delegate
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"purchasing");
                break;
            case SKPaymentTransactionStatePurchased:
                if ([transaction.payment.productIdentifier isEqualToString:KUpgradeProductID]) {
                    NSLog(@"Purchased");
                    UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Purchase is completed successfully" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [view show];
                }
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Restored");
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"Purchase failed");
                break;
                
            default:
                break;
        }
    }
}
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct=nil;
    int count=(unsigned)[response.products count];
    if (count>0) {
        validProducts=response.products;
        validProduct=[response.products objectAtIndex:0];
        if ([validProduct.productIdentifier isEqualToString:KUpgradeProductID]) {
            [self.productTitleLabel setText:[NSString stringWithFormat:@"Title:%@", validProduct.localizedTitle]];
            [self.productDescriptionLabel setText:[NSString stringWithFormat:@"Description: %@", validProduct.localizedDescription]];
            [self.productPriceLabe setText:[NSString stringWithFormat:@"Price: %@", validProduct.price]];
        }
        else{
            UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Not Available" message:@"No Products to purchase" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
        }
        [activityIndicatorView stopAnimating];
        self.purchaseButton.hidden=NO;
    }
}

@end
