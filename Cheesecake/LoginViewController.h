//
//  LoginViewController.h
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 10/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *loginLaterButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *loginWithFacebookButton;

- (IBAction)loginAction:(id)sender;
- (IBAction)anonymousLoginAction:(id)sender;
@end
