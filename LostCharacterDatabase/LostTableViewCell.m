//
//  LostTableViewCell.m
//  LostCharacterDatabase
//
//  Created by ETC ComputerLand on 8/12/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import "LostTableViewCell.h"

@implementation LostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
