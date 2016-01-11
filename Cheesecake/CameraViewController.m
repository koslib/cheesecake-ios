//
//  CameraViewController.m
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 09/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import "CameraViewController.h"
#import <Parse/Parse.h>

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

- (void)takePhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)uploadPhoto:(id)sender {
    UIImage *new = self.imageView.image;
    
    // Convert to JPEG with 50% quality
    NSData* data = UIImageJPEGRepresentation(new, 0.99f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    // Save the image to Parse
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // The image has now been uploaded to Parse. Associate it with a new object
            PFObject* newPhotoObject = [PFObject objectWithClassName:@"Images"];
            [newPhotoObject setObject:imageFile forKey:@"image"];
            [newPhotoObject setObject:[PFUser currentUser] forKey:@"user"];
            [newPhotoObject setObject:@"test" forKey:@"title"];
            
            [newPhotoObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                UIAlertView *alert = [UIAlertView alloc];
                if (!error) {
                    NSLog(@"Saved");
                    [alert initWithTitle:@"Saved!" message:@"Your photo has been uploaded!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                }
                else{
                    // Error
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                    [alert initWithTitle:@"Error!" message:@"Something went wrong! Try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                }
                [alert show];
//                [self takePhoto];
                self.imageView.image = nil;
            }];
        }
    }];
}

- (IBAction)newPhotoTaped:(id)sender {
    [self takePhoto];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
