//
//  SignupViewController.m
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 17/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import "SignupViewController.h"
#import "Parse/Parse.h"

@interface SignupViewController () <UITextFieldDelegate>

@end

@implementation SignupViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser.username);
    }
    
}

-(void)setupUI {
    // sinup button
    _signupButton.backgroundColor = [UIColor colorWithRed:(197/255.f) green:(24/255.f) blue:(49/255.f) alpha:1];
    [_signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)registerAction:(id)sender {
    
    NSString *username = [self.usernameTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0 || [email length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:@"Make sure you enter a username, password, and email address!"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else {
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {   // Hooray! Let them use the app now.
                [self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"Registered successfully with username %@", username);
            } else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"Error in registration: %@", errorString);
            }
            
        }];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
@end
