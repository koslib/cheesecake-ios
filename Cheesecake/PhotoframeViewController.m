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
@property (nonatomic, strong) NSTimer *photoTimer;

@end

@implementation PhotoframeViewController
@synthesize parseItemsArray;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadImages];
    _images = [[NSMutableArray alloc] init];
    
    _startBtnOutlet.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_photoTimer invalidate];
    _photoTimer = nil;
    _imageToShow.image = nil;
}

- (void)changeImage:(NSTimer *)timer
{
    _startBtnOutlet.hidden = YES;
    static int counter = 0;
    if([_images count] == counter)
    {
        counter = 0;
    }
    _imageToShow.image = [UIImage imageWithData:[_images objectAtIndex:counter]];
    
    NSLog(@"Photoframe counter index: %d", counter);
    counter++;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    // We don't need to manually deallon or release our _images NSMutableArray resources,
    // because we make use of the ARC. It forbits explicit deallocation, but it also
    // handles memory-pressing reources itself.
}

-(void)loadImages {
    PFQuery *query = [PFQuery queryWithClassName:@"Images"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            // Handle found objects
            for (PFObject *object in objects) {
                PFFile *imageFile = object[@"image"];
                
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!data) {
                        return NSLog(@"%@", error);
                    }
                    
                    // Do something with the image
                    [_images addObject:data];
                }];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

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
    _photoTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                     target:self selector:@selector(changeImage:) userInfo:nil repeats:YES];
}
@end
