//
//  SettingTVC.h
//  FitwirrApp
//
//  Created by Misato Tina Alexandre on 12/30/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SettingTVC : UITableViewController<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *shareCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *contactCell;

@end
