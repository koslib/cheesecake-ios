//
//  ItemCell.h
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 07/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemPreview;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *sharedLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameToShareTextfield;

@end
