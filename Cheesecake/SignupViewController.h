//
//  SignupViewController.h
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 17/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *signupWithFacebookButton;

- (IBAction)registerAction:(id)sender;

@end
