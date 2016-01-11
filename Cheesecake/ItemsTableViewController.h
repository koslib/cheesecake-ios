//
//  ItemsTableViewController.h
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 07/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutBtnOutlet;
@property(nonatomic, weak) UIImage *image;
- (IBAction)logoutTaped:(id)sender;

@end
