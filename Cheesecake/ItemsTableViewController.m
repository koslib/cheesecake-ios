//
//  ItemsTableViewController.m
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 07/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import "ItemsTableViewController.h"
#import "ItemCell.h"
#import "Parse/Parse.h"
#import <SAMCache/SAMCache.h>

@class PFQuery;

@interface ItemsTableViewController ()
@property (nonatomic, strong) NSMutableArray *parseItemsArray;

@end

@implementation ItemsTableViewController
@synthesize parseItemsArray;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupUI];
    if ([PFUser currentUser]) {
        [self loadItemsObjects];
    }
    
    parseItemsArray = [[NSMutableArray alloc] init];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser.username);
        
        // Initialize the refresh control.
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.backgroundColor = [UIColor orangeColor];
        self.refreshControl.tintColor = [UIColor whiteColor];
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.refreshControl addTarget:self
                                action:@selector(loadItemsObjectsFast)
                      forControlEvents:UIControlEventValueChanged];
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }

}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI {
    _logoutBtnOutlet.title = [NSString stringWithFormat:@"Log out %@", [PFUser currentUser].username];
}

#pragma mark - ParseData
-(void)loadItemsObjects {
    PFQuery *query = [PFQuery queryWithClassName:@"Images"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            NSLog(@"Successfully retrieved %lu images.", (unsigned long)objects.count);
            for (PFObject *object in objects) {
                NSLog(@"Retrieved Object ID: %@", object.objectId);
                [parseItemsArray addObject:object];
            }
            [self.tableView reloadData];
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self.tableView reloadData];
            });
            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

-(void)loadItemsObjectsFast {
    PFQuery *query = [PFQuery queryWithClassName:@"Images"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    parseItemsArray = [query findObjects];
    
    [self reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (parseItemsArray) {
        return [parseItemsArray count];

    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];

        messageLabel.text = @"No data is currently available. Please pull down to refresh or add new images.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"OpenSans-Regular" size:26];
        [messageLabel sizeToFit];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundView = messageLabel;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.itemTitle.text = [NSString stringWithFormat:@"%@", parseItemsArray[indexPath.row][@"title"]];
    cell.sharedLabel.text = @"shared";
    
    NSString *key = [[NSString alloc] initWithFormat:@"%@-photoItem", parseItemsArray[indexPath.row][@"image"]];
    UIImage *photo = [[SAMCache sharedCache] imageForKey:key];
    
    if (photo) {
        cell.itemPreview.image = photo;
        return cell;
    } else {

        PFFile *eventImage = [[parseItemsArray objectAtIndex:indexPath.row] objectForKey:@"image"];
        
        if(eventImage != NULL)
        {
            
            [eventImage getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                
                UIImage *thumbnailImage = [UIImage imageWithData:imageData];
                UIImageView *thumbnailImageView = [[UIImageView alloc] initWithImage:thumbnailImage];
                [[SAMCache sharedCache] setObject:thumbnailImageView.image forKey:key];
                
                cell.itemPreview.image = thumbnailImageView.image;
                
            }];
            
        }
        
    }
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *object = [parseItemsArray objectAtIndex:indexPath.row];
        [object deleteInBackground];
        
        // Delete the row from the data source
        [parseItemsArray removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadData];
    } /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   */
}



- (IBAction)logoutTaped:(id)sender {
    NSLog(@"Logging out user %@", [PFUser currentUser].username);
    [PFUser logOutInBackground];
    
    [self performSegueWithIdentifier:@"showLogin" sender:nil];
}

@end
