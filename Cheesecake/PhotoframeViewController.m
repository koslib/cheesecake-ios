//
//  PhotoframeViewController.m
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 21/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import "PhotoframeViewController.h"
#import <Parse/Parse.h>

@class PFQuery;

@interface PhotoframeViewController ()
@property (nonatomic, strong) NSMutableArray *parseItemsArray;

@end

@implementation PhotoframeViewController
@synthesize parseItemsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    _images = @[@"shareIcon.png", @"shareIconSelected.png", @"shareIcon.png", @"shareIconSelected.png"];
    [self loadImages];
    
}

- (void)changeImage
{
    static int counter = 0;
    if([_images count] == counter+1)
    {
        counter = 0;
    }
    _imageToShow.image = [UIImage imageNamed:[_images objectAtIndex:counter]];
    
    NSLog(@"%d", counter);
    counter++;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadImages {
    PFQuery *query = [PFQuery queryWithClassName:@"Images"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    parseItemsArray = [query findObjects];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startPhotoframe:(id)sender {
    [self changeImage];
}
@end
