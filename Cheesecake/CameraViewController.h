//
//  CameraViewController.h
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 09/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)uploadPhoto:(id)sender;
- (IBAction)newPhotoTaped:(id)sender;

@end
