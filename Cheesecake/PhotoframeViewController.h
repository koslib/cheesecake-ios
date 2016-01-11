//
//  PhotoframeViewController.h
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 21/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoframeViewController : UIViewController

@property NSInteger *index;

@property NSMutableArray *images;

@property (weak, nonatomic) IBOutlet UIImageView *imageToShow;

- (IBAction)startPhotoframe:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startBtnOutlet;

@end
