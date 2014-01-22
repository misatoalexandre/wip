//
//  SupportDetailVC.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 1/20/14.
//  Copyright (c) 2014 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupportDetailVC : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *uRLstring;
@property BOOL terms;

@end
