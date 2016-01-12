//
//  LoginViewController.m
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 17/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser.username);
        //        [self performSegueWithIdentifier:@"showMainView" sender:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI {
    // login button
    _loginButton.backgroundColor = [UIColor colorWithRed:(197/255.f) green:(24/255.f) blue:(49/255.f) alpha:1];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // login later button
    _loginLaterButton.backgroundColor = [UIColor colorWithRed:(155/255.f) green:(155/255.f) blue:(155/255.f) alpha:1];
    [_loginLaterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // other UI
    [_usernameTextfield setFrame:CGRectMake(_usernameTextfield.frame.origin.x, _usernameTextfield.frame.origin.y, _usernameTextfield.frame.size.width, 50)];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Actions
- (IBAction)loginAction:(id)sender {
    NSString *username = [self.usernameTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:@"Make sure you enter a username and password!"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else {
        [PFUser logInWithUsernameInBackground:username password:password
                                        block:^(PFUser *user, NSError *error) {
                                            if (error) {
                                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                                                    message:[error.userInfo objectForKey:@"error"]
                                                                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                [alertView show];
                                            }
                                            
                                            if (user) {
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                            } else {
                                                // The login failed. Check error to see why.
                                                NSLog(@"Login Error: %@", error);
                                            }
                                        }];
    }
}

- (IBAction)anonymousLoginAction:(id)sender {
    [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (error) {
            NSLog(@"Anonymous login failed.");
        } else {
            NSLog(@"Anonymous user logged in.");
//            [self performSegueWithIdentifier:@"showMain" sender:sender];
        }
    }];
}

#pragma mark - UITextField Delegate methods
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
@end
