//
//  ItemCell.m
//  Cheesecake
//
//  Created by Konstantinos Livieratos on 07/12/15.
//  Copyright © 2015 Konstantinos Livieratos. All rights reserved.
//

#import "ItemCell.h"
#import <Parse/Parse.h>

@implementation ItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)handleSharedItems{
    _sharedLabel.hidden = NO;
}


@end
